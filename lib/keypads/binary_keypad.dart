import 'package:flutter/material.dart';
import 'package:simple_binary_converter/keypads/keypad_layout.dart';

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
