import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton {
  copyToClipborad(_convertResult) {
    Clipboard.setData(ClipboardData(text: _convertResult));
  }

  IconButton copyButton(_convertResult) {
    return IconButton(
      icon: const Icon(Icons.content_copy),
      onPressed: () => copyToClipborad(_convertResult),
    );
  }
}
