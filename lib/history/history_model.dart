/// 変換履歴のデータモデル
class HistoryItem {
  final String input;
  final String result;
  final String type;
  final int timestamp;

  HistoryItem({
    required this.input,
    required this.result,
    required this.type,
    required this.timestamp,
  });

  /// JSONからHistoryItemを作成
  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      input: json['input'] as String,
      result: json['result'] as String,
      type: json['type'] as String,
      timestamp: json['timestamp'] as int,
    );
  }

  /// HistoryItemをJSONに変換
  Map<String, dynamic> toJson() {
    return {
      'input': input,
      'result': result,
      'type': type,
      'timestamp': timestamp,
    };
  }

  /// convertModeから表示用の変換タイプ文字列を取得
  static String getTypeLabel(String convertMode) {
    switch (convertMode) {
      case "0":
        return "BIN → DEC";
      case "1":
        return "BIN → HEX";
      case "2":
        return "DEC → BIN";
      case "3":
        return "DEC → HEX";
      case "4":
        return "HEX → BIN";
      case "5":
        return "HEX → DEC";
      default:
        return "Unknown";
    }
  }

  /// 表示用の変換タイプ文字列からconvertModeを取得
  static String? getConvertMode(String typeLabel) {
    switch (typeLabel) {
      case "BIN → DEC":
        return "0";
      case "BIN → HEX":
        return "1";
      case "DEC → BIN":
        return "2";
      case "DEC → HEX":
        return "3";
      case "HEX → BIN":
        return "4";
      case "HEX → DEC":
        return "5";
      default:
        return null;
    }
  }

  /// typeから入力ページを取得
  static int getPageIndex(String typeLabel) {
    switch (typeLabel) {
      case "BIN → DEC":
      case "BIN → HEX":
        return 0; // Binary page
      case "DEC → BIN":
      case "DEC → HEX":
        return 1; // Decimal page
      case "HEX → BIN":
      case "HEX → DEC":
        return 2; // Hex page
      default:
        return 0;
    }
  }
}
