import 'package:flutter/material.dart';

class NumButton {
  late BuildContext context;
  final Function(String inputData, String page) onChangeInputData;

  NumButton(this.context, this.onChangeInputData);

  Text buttonStyle(String num) {
    return Text(
      num,
      style: const TextStyle(
        fontSize: 35,
      ),
    );
  }

  ElevatedButton numButton(String num, String page) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.72;
    double width = screenSize.width;
    double smaller = height > width ? width : height;
    double buttonSize = smaller * 0.13;
    return ElevatedButton(
      child: buttonStyle(num),
      onPressed: () => onChangeInputData(num, page),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        fixedSize: Size(buttonSize, buttonSize),
        backgroundColor: Colors.white,
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

  ElevatedButton largeButton(String num, String page) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.72;
    double width = screenSize.width;
    double smaller = height > width ? width : height;
    double buttonSize = smaller * 0.40;
    return ElevatedButton(
      child: buttonStyle(num),
      onPressed: () => onChangeInputData(num, page),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        fixedSize: Size(buttonSize, buttonSize),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
          side: const BorderSide(
            width: 3,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
