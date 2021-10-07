import 'package:flutter/material.dart';
import 'package:simple_binary_convertor/setter_getter.dart';

class NumButton {
  late BuildContext context;

  NumButton(this.context);

  Text buttonStyle(String num) {
    return Text(
      num,
      style: TextStyle(
        fontSize: 35,
      ),
    );
  }

  void _setNumber(String recieveNum) {
    SetterGetter setterGetter = SetterGetter();
    String number = setterGetter.getNumber();
    number += recieveNum;
    setterGetter.setNumber(number);
  }

  ElevatedButton numButton(String num) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.72;
    double width = screenSize.width;
    double smaller = height > width ? width : height;
    double buttonSize = smaller * 0.1;
    return ElevatedButton(
      child: buttonStyle(num),
      onPressed: () => _setNumber(num),
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
