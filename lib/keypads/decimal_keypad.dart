import 'package:flutter/material.dart';
import 'package:simple_binary_converter/keypads/keypad_layout.dart';

class DecimalKeyPad extends StatelessWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;
  final String currentMode;

  const DecimalKeyPad(this.onChangeInputData, this.setMode, {Key? key, required this.currentMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      onChangeInputData: onChangeInputData,
      page: "decimal",
    );

    // "2" = to binary, "3" = to hex
    final isBinaryMode = currentMode == "2";

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
            isActive: isBinaryMode,
            onPressed: () {
              setMode("2");
            },
          ),
          layout.buildNumButton("0"),
          layout.buildModeSwitch(
            label: "to hex",
            isActive: !isBinaryMode,
            onPressed: () {
              setMode("3");
            },
          ),
        ]),
      ],
    );
  }
}
