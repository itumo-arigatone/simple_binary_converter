import 'package:flutter/material.dart';

class NumButton extends StatefulWidget {
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
  State<NumButton> createState() => _NumButtonState();
}

class _NumButtonState extends State<NumButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final fontSize = widget.size * 0.38;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F3),
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? [
                  // 押し込み
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: -2,
                  ),
                ]
              : [
                  // 浮き出し
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
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
            widget.label,
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

class LargeNumButton extends StatefulWidget {
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
  State<LargeNumButton> createState() => _LargeNumButtonState();
}

class _LargeNumButtonState extends State<LargeNumButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F3),
          borderRadius: BorderRadius.circular(40),
          boxShadow: _isPressed
              ? [
                  // 押し込み
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                    spreadRadius: -2,
                  ),
                ]
              : [
                  // 浮き出し
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(6, 6),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
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
            widget.label,
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
