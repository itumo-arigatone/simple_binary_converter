import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton {
  copyToClipborad() {
    Clipboard.setData(const ClipboardData(text: 'コピーされるテキストaaa'));
  }

  IconButton copyButton() {
    return IconButton(
      icon: const Icon(Icons.content_copy),
      onPressed: () => copyToClipborad(),
    );
  }
}
