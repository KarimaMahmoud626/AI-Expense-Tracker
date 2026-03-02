import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.secondIcon,
  });

  final IconData icon;
  final IconData secondIcon;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: isPressed ? Icon(widget.secondIcon) : Icon(widget.icon),
      ),
    );
  }
}
