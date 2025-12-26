import 'package:flutter/material.dart';
import 'package:simple_binary_converter/numbutton.dart';
import 'package:simple_binary_converter/mode_select_switch.dart';

// 共通のキーパッドレイアウトを構築するヘルパー
class KeypadLayout {
  final BuildContext context;
  final Function(String inputData, String page) onChangeInputData;
  final String page;

  KeypadLayout({
    required this.context,
    required this.onChangeInputData,
    required this.page,
  });

  double get _buttonSize {
    final size = MediaQuery.of(context).size;
    final smaller = size.height > size.width ? size.width : size.height;
    return smaller * 0.12;
  }

  double get _largeButtonSize {
    final size = MediaQuery.of(context).size;
    final smaller = size.height > size.width ? size.width : size.height;
    return smaller * 0.35;
  }

  double get _modeSwitchWidth {
    final size = MediaQuery.of(context).size;
    final smaller = size.height > size.width ? size.width : size.height;
    return smaller * 0.22;
  }

  double get _modeSwitchHeight => _buttonSize;

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

  Widget buildRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

// 2進数キーパッド
class BinaryKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;

  const BinaryKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);

  @override
  State<BinaryKeyPad> createState() => _BinaryKeyPadState();
}

class _BinaryKeyPadState extends State<BinaryKeyPad> {
  bool _isDecimalMode = true;

  void _toggleMode() {
    setState(() {
      _isDecimalMode = !_isDecimalMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      context: context,
      onChangeInputData: widget.onChangeInputData,
      page: "binary",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        layout.buildRow([
          layout.buildLargeButton("0"),
          layout.buildLargeButton("1"),
        ]),
        const SizedBox(height: 24),
        layout.buildRow([
          layout.buildModeSwitch(
            label: "to decimal",
            isActive: _isDecimalMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("0");
            },
          ),
          layout.buildModeSwitch(
            label: "to hex",
            isActive: !_isDecimalMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("1");
            },
          ),
        ]),
      ],
    );
  }
}

// 10進数キーパッド
class DecimalKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;

  const DecimalKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);

  @override
  State<DecimalKeyPad> createState() => _DecimalKeyPadState();
}

class _DecimalKeyPadState extends State<DecimalKeyPad> {
  bool _isBinaryMode = true;

  void _toggleMode() {
    setState(() {
      _isBinaryMode = !_isBinaryMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      context: context,
      onChangeInputData: widget.onChangeInputData,
      page: "decimal",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        layout.buildRow([
          layout.buildNumButton("1"),
          layout.buildNumButton("2"),
          layout.buildNumButton("3"),
        ]),
        layout.buildRow([
          layout.buildNumButton("4"),
          layout.buildNumButton("5"),
          layout.buildNumButton("6"),
        ]),
        layout.buildRow([
          layout.buildNumButton("7"),
          layout.buildNumButton("8"),
          layout.buildNumButton("9"),
        ]),
        layout.buildRow([
          layout.buildModeSwitch(
            label: "to binary",
            isActive: _isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("2");
            },
          ),
          layout.buildNumButton("0"),
          layout.buildModeSwitch(
            label: "to hex",
            isActive: !_isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("3");
            },
          ),
        ]),
      ],
    );
  }
}

// 16進数キーパッド
class HexKeyPad extends StatefulWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;

  const HexKeyPad(this.onChangeInputData, this.setMode, {Key? key})
      : super(key: key);

  @override
  State<HexKeyPad> createState() => _HexKeyPadState();
}

class _HexKeyPadState extends State<HexKeyPad> {
  bool _isBinaryMode = true;

  void _toggleMode() {
    setState(() {
      _isBinaryMode = !_isBinaryMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      context: context,
      onChangeInputData: widget.onChangeInputData,
      page: "hex",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        layout.buildRow([
          layout.buildNumButton("A"),
          layout.buildNumButton("B"),
          layout.buildNumButton("C"),
        ]),
        layout.buildRow([
          layout.buildNumButton("D"),
          layout.buildNumButton("E"),
          layout.buildNumButton("F"),
        ]),
        layout.buildRow([
          layout.buildNumButton("1"),
          layout.buildNumButton("2"),
          layout.buildNumButton("3"),
        ]),
        layout.buildRow([
          layout.buildNumButton("4"),
          layout.buildNumButton("5"),
          layout.buildNumButton("6"),
        ]),
        layout.buildRow([
          layout.buildNumButton("7"),
          layout.buildNumButton("8"),
          layout.buildNumButton("9"),
        ]),
        layout.buildRow([
          layout.buildModeSwitch(
            label: "to binary",
            isActive: _isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("4");
            },
          ),
          layout.buildNumButton("0"),
          layout.buildModeSwitch(
            label: "to decimal",
            isActive: !_isBinaryMode,
            onPressed: () {
              _toggleMode();
              widget.setMode("5");
            },
          ),
        ]),
      ],
    );
  }
}
