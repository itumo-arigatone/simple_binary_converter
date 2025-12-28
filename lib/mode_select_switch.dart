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
    print('ModeSwitch build: $label, isActive: $isActive');
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('ModeSwitch tapped: $label, isActive: $isActive');
        if (!isActive) {
          onPressed();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [
                  // アクティブ: 押し込み（選択中）
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: -2,
                  ),
                ]
              : [
                  // 非アクティブ: 浮き出し（未選択）
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.grey.shade400 : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
