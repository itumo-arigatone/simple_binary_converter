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
    final fontSize = size * 0.38;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F3),
          shape: BoxShape.circle,
          boxShadow: [
            // 右下の影（暗い）
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
            // 左上の影（明るい）
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F3),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            // 右下の影（暗い）
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(6, 6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
            // 左上の影（明るい）
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
