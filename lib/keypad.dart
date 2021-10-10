import 'package:flutter/material.dart';
import 'package:simple_binary_convertor/numbutton.dart';
import 'package:simple_binary_convertor/switch.dart';

class KeyPad {
  late BuildContext context;
  final Function(String inputData) onChangeInputData;

  KeyPad(this.context, this.onChangeInputData);
  Container decimalKeyPad() {
    NumButton button = NumButton(context, onChangeInputData);
    ModeSwitch modeSwitch = ModeSwitch();
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
                child: modeSwitch,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: button.numButton("0"),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: modeSwitch,
              ),
            ],
          ),
        ],
      ),
    );
  }

    Container hexKeypad() {
      NumButton button = NumButton(context, onChangeInputData);
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
                child: button.numButton("0"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container binaryKeyPad() {
    NumButton button = NumButton(context, onChangeInputData);
    return Container(
      color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 250)),
          button.numButton("0"),
          const Padding(padding: EdgeInsets.only(left: 90)),
          button.numButton("1"),
        ]
      ),
    );
  }
}