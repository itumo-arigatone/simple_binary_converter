import 'package:flutter/material.dart';

class ModeSwitch extends StatefulWidget {
  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}

class _ModeSwitchState extends State<ModeSwitch> {
  bool isPressed = false;
  Color primaryColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        this.isPressed = !this.isPressed;
        setState(() {
          this.primaryColor = this.isPressed ? Colors.grey: Colors.white;
        });
      },
      child: Text(
        "to Binary",
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