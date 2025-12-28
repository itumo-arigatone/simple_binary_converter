import 'package:flutter/material.dart';
import 'package:simple_binary_converter/keypads/keypad_layout.dart';

class HexKeyPad extends StatelessWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;
  final String currentMode;

  const HexKeyPad(this.onChangeInputData, this.setMode, {Key? key, required this.currentMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      onChangeInputData: onChangeInputData,
      page: "hex",
    );

    // "4" = to binary, "5" = to decimal
    final isBinaryMode = currentMode == "4";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        layout.buildRow([
          layout.buildSmallNumButton("A"),
          layout.buildSmallNumButton("B"),
          layout.buildSmallNumButton("C"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("D"),
          layout.buildSmallNumButton("E"),
          layout.buildSmallNumButton("F"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("1"),
          layout.buildSmallNumButton("2"),
          layout.buildSmallNumButton("3"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("4"),
          layout.buildSmallNumButton("5"),
          layout.buildSmallNumButton("6"),
        ]),
        layout.buildRow([
          layout.buildSmallNumButton("7"),
          layout.buildSmallNumButton("8"),
          layout.buildSmallNumButton("9"),
        ]),
        layout.buildRow([
          layout.buildSmallModeSwitch(
            label: "to binary",
            isActive: isBinaryMode,
            onPressed: () {
              setMode("4");
            },
          ),
          layout.buildSmallNumButton("0"),
          layout.buildSmallModeSwitch(
            label: "to decimal",
            isActive: !isBinaryMode,
            onPressed: () {
              setMode("5");
            },
          ),
        ]),
      ],
    );
  }
}
