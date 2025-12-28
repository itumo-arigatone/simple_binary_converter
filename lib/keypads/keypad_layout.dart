import 'package:flutter/material.dart';
import 'package:simple_binary_converter/numbutton.dart';
import 'package:simple_binary_converter/mode_select_switch.dart';

// 共通のキーパッドレイアウトを構築するヘルパー
class KeypadLayout {
  final Function(String inputData, String page) onChangeInputData;
  final String page;

  KeypadLayout({
    required this.onChangeInputData,
    required this.page,
  });

  // 固定サイズ
  static const double _buttonSize = 70.0;
  static const double _smallButtonSize = 64.0;
  static const double _largeButtonSize = 130.0;
  static const double _modeSwitchWidth = 90.0;
  static const double _smallModeSwitchWidth = 72.0;
  static const double _modeSwitchHeight = 42.0;
  static const double _smallModeSwitchHeight = 34.0;

  Widget buildNumButton(String label) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: NumButton(
        label: label,
        page: page,
        onPressed: () => onChangeInputData(label, page),
        size: _buttonSize,
      ),
    );
  }

  Widget buildSmallNumButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: NumButton(
        label: label,
        page: page,
        onPressed: () => onChangeInputData(label, page),
        size: _smallButtonSize,
      ),
    );
  }

  Widget buildLargeButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: LargeNumButton(
        label: label,
        page: page,
        onPressed: () => onChangeInputData(label, page),
        size: _largeButtonSize,
      ),
    );
  }

  Widget buildModeSwitch({
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ModeSwitch(
        label: label,
        isActive: isActive,
        onPressed: onPressed,
        width: _modeSwitchWidth,
        height: _modeSwitchHeight,
      ),
    );
  }

  Widget buildSmallModeSwitch({
    required String label,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ModeSwitch(
        label: label,
        isActive: isActive,
        onPressed: onPressed,
        width: _smallModeSwitchWidth,
        height: _smallModeSwitchHeight,
      ),
    );
  }

  Widget buildRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
