import 'package:flutter/material.dart';
import 'history_model.dart';

/// 履歴モーダルを表示する
void showHistoryModal({
  required BuildContext context,
  required List<HistoryItem> history,
  required Function(HistoryItem item) onItemTap,
  required Function(int index) onItemDelete,
  required VoidCallback onClearAll,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFFF0F0F3),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return _HistoryModalContent(
        history: history,
        onItemTap: onItemTap,
        onItemDelete: onItemDelete,
        onClearAll: onClearAll,
      );
    },
  );
}

class _HistoryModalContent extends StatefulWidget {
  final List<HistoryItem> history;
  final Function(HistoryItem item) onItemTap;
  final Function(int index) onItemDelete;
  final VoidCallback onClearAll;

  const _HistoryModalContent({
    required this.history,
    required this.onItemTap,
    required this.onItemDelete,
    required this.onClearAll,
  });

  @override
  State<_HistoryModalContent> createState() => _HistoryModalContentState();
}

class _HistoryModalContentState extends State<_HistoryModalContent> {
  late List<HistoryItem> _history;

  @override
  void initState() {
    super.initState();
    _history = List.from(widget.history);
  }

  void _handleDelete(int index) {
    setState(() {
      _history.removeAt(index);
    });
    widget.onItemDelete(index);
  }

  void _handleClearAll() {
    setState(() {
      _history.clear();
    });
    widget.onClearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ハンドル
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // ヘッダー
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                if (_history.isNotEmpty)
                  TextButton(
                    onPressed: _handleClearAll,
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // リストまたは空状態
          Flexible(
            child: _history.isEmpty
                ? _buildEmptyState()
                : _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Text(
          'No history',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final item = _history[index];
        return Dismissible(
          key: ValueKey('${item.timestamp}_$index'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => _handleDelete(index),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red.shade400,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: _buildHistoryItem(item),
        );
      },
    );
  }

  Widget _buildHistoryItem(HistoryItem item) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        widget.onItemTap(item);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.type,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${item.input} → ${item.result}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
