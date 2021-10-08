import 'package:flutter/material.dart';

class NumButton {
  late BuildContext context;
  final Function(String inputData) onChangeInputData;

  NumButton(this.context, this.onChangeInputData);

  Text buttonStyle(String num) {
    return Text(
      num,
      style: TextStyle(
        fontSize: 35,
      ),
    );
  }

  ElevatedButton numButton(String num) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.72;
    double width = screenSize.width;
    double smaller = height > width ? width : height;
    double buttonSize = smaller * 0.1;
    return ElevatedButton(
      child: buttonStyle(num),
      onPressed: () => onChangeInputData(num),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(buttonSize, buttonSize),
        primary: Colors.white,
        onPrimary: Colors.black,
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
