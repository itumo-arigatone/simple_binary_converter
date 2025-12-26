import 'package:flutter/material.dart';

class NumButton extends StatelessWidget {
  final String label;
  final String page;
  final VoidCallback onPressed;
  final double size;

  const NumButton({
    Key? key,
    required this.label,
    required this.page,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 3,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class LargeNumButton extends StatelessWidget {
  final String label;
  final String page;
  final VoidCallback onPressed;
  final double size;

  const LargeNumButton({
    Key? key,
    required this.label,
    required this.page,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
            side: const BorderSide(
              width: 3,
              color: Colors.black,
            ),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
