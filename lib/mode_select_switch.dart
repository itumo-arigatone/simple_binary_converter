import 'package:flutter/material.dart';

class ModeSwitch extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const ModeSwitch({
    Key? key,
    required this.label,
    required this.isActive,
    required this.onPressed,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[600],
          padding: EdgeInsets.zero,
          side: const BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
