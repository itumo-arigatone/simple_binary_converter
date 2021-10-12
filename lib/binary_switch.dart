import 'package:flutter/material.dart';

class ModeSwitch extends StatefulWidget {
  final Function(String mode) setMode;
  final String mode;
  ModeSwitch(this.setMode, this.mode);
  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}

class _ModeSwitchState extends State<ModeSwitch> {

  bool isPressed = false;
  Color primaryColor = Colors.white;
  Map<String, String> modeDecimal = {
    "0": "to decimal", // binary
    "1": "to hex", // binary
    "2": "decimal to binary", // decimal
    "3": "decimal to hex", // decimal
    "4": "hex to binary", // hex
    "5": "hex to decimal", // hex
  };
  @override
  Widget build(BuildContext context) {
    String? mode = modeDecimal[widget.mode];
    return ElevatedButton(
      onPressed: () {
        this.isPressed = !this.isPressed;
        setState(() {
          this.primaryColor = this.isPressed ? Colors.grey: Colors.white;
          if (this.isPressed) {
            widget.setMode(widget.mode);
          }
        });
      },
      child: Text(
        mode.toString(),
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: Colors.black,
      ),
    );
  }
}
