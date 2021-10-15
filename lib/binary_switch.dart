import 'package:flutter/material.dart';

class ModeSwitch extends StatefulWidget {
  final Function(String mode) setMode;
  final Function() setStatus;
  final String mode;
  final bool status;
  ModeSwitch(this.setMode, this.mode, this.status, this.setStatus);
  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}

class _ModeSwitchState extends State<ModeSwitch> {

  bool isPressed = false;
  Color primaryColor = Colors.white;
  Map<String, String> modeDecimal = {
    "0": "to decimal", // binary
    "1": "to hex", // binary
    "2": "to binary", // decimal
    "3": "to hex", // decimal
    "4": "to binary", // hex
    "5": "to decimal", // hex
  };

  void pressed() {
    widget.setStatus();
    setState(() {
      if (widget.status) {
        widget.setMode(widget.mode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String? mode = modeDecimal[widget.mode];
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.72;
    double width = screenSize.width;
    double smaller = height > width ? width : height;
    double buttonSizeHight = smaller * 0.13;
    double buttonSizeWidth = smaller * 0.22;
    return SizedBox(
      width: buttonSizeWidth,
      height: buttonSizeHight,
      child: ElevatedButton(
        onPressed: widget.status?pressed:null,
        child: Text(
          // String?ってなんだろう。。Stringとは違うらしい
          mode.toString(),
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          onPrimary: Colors.black,
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
    );
  }
}
