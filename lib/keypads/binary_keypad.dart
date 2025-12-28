import 'package:flutter/material.dart';
import 'package:simple_binary_converter/keypads/keypad_layout.dart';

class BinaryKeyPad extends StatelessWidget {
  final Function(String mode) setMode;
  final Function(String inputData, String page) onChangeInputData;
  final String currentMode;

  const BinaryKeyPad(this.onChangeInputData, this.setMode, {Key? key, required this.currentMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layout = KeypadLayout(
      onChangeInputData: onChangeInputData,
      page: "binary",
    );

    // "0" = to decimal, "1" = to hex
    final isDecimalMode = currentMode == "0";

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
            isActive: isDecimalMode,
            onPressed: () {
              setMode("0");
            },
          ),
          layout.buildModeSwitch(
            label: "to hex",
            isActive: !isDecimalMode,
            onPressed: () {
              setMode("1");
            },
          ),
        ]),
      ],
    );
  }
}
