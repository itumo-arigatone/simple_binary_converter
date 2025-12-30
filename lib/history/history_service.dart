import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'history_model.dart';

/// 履歴の保存・読み込みを管理するサービス
class HistoryService {
  static const String _key = 'conversion_history';
  static const int _maxItems = 20;

  /// 履歴を読み込む
  static Future<List<HistoryItem>> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);
      
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((item) => HistoryItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // パースエラー時は空のリストを返す
      return [];
    }
  }

  /// 履歴を保存する
  static Future<void> saveHistory(List<HistoryItem> history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = history.map((item) => item.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await prefs.setString(_key, jsonString);
    } catch (e) {
      // 保存失敗時はサイレントに無視
    }
  }

  /// 履歴を追加する
  static Future<List<HistoryItem>> addHistory({
    required String input,
    required String result,
    required String convertMode,
    required List<HistoryItem> currentHistory,
  }) async {
    // 直近の履歴と同じ場合は追加しない
    if (currentHistory.isNotEmpty) {
      final lastItem = currentHistory.first;
      final typeLabel = HistoryItem.getTypeLabel(convertMode);
      if (lastItem.input == input && lastItem.type == typeLabel) {
        return currentHistory;
      }
    }

    final newItem = HistoryItem(
      input: input,
      result: result,
      type: HistoryItem.getTypeLabel(convertMode),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    // 新しい履歴を先頭に追加
    final newHistory = [newItem, ...currentHistory];

    // 最大件数を超えた場合は古いものを削除
    final trimmedHistory = newHistory.length > _maxItems
        ? newHistory.sublist(0, _maxItems)
        : newHistory;

    // 保存
    await saveHistory(trimmedHistory);

    return trimmedHistory;
  }

  /// 履歴を削除する
  static Future<List<HistoryItem>> removeHistory({
    required int index,
    required List<HistoryItem> currentHistory,
  }) async {
    final newHistory = List<HistoryItem>.from(currentHistory);
    newHistory.removeAt(index);
    await saveHistory(newHistory);
    return newHistory;
  }

  /// 履歴を全削除する
  static Future<List<HistoryItem>> clearHistory() async {
    await saveHistory([]);
    return [];
  }
}
