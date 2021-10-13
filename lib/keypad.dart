import 'package:flutter/material.dart';
import 'package:simple_binary_convertor/numbutton.dart';
import 'package:simple_binary_convertor/binary_switch.dart';

class KeyPad {
  late BuildContext context;
  final Function(String inputData) onChangeInputData;
  final Function(String mode) setMode;

  KeyPad(this.context, this.onChangeInputData, this.setMode);
  Container decimalKeyPad() {
    NumButton button = NumButton(context, onChangeInputData);
    ModeSwitch binaryMode = ModeSwitch(setMode, "2");
    ModeSwitch hexMode = ModeSwitch(setMode, "3");
    return Container(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("1"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("2"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("3"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("4"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("5"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("6"),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button.numButton("7"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button.numButton("8"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button.numButton("9"),
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: binaryMode,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("0"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: hexMode,
              ),
            ],
          ),
        ],
      ),
    );
  }

    Container hexKeypad() {
      NumButton button = NumButton(context, onChangeInputData);
      ModeSwitch binaryMode = ModeSwitch(setMode, "4");
      ModeSwitch decimalMode = ModeSwitch(setMode, "5");
      return Container(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("1"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("2"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("3"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("4"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("5"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("6"),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button.numButton("7"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button.numButton("8"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: button.numButton("9"),
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: binaryMode,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("0"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: decimalMode,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container binaryKeyPad() {
    NumButton button = NumButton(context, onChangeInputData);
    ModeSwitch decimalMode = ModeSwitch(setMode, "0");
    ModeSwitch hexMode = ModeSwitch(setMode, "1");
    return Container(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 45),
              child: button.numButton("0"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 45),
              child: button.numButton("1"),
            ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40, right: 45),
                child: decimalMode,
                ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 45),
                child: hexMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}