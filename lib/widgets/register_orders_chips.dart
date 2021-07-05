import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Theme/AppColors.dart';

class RegisterOrdersChips extends StatefulWidget {
  final VoidCallback? onTap;
  final String text;
  final Color color;
  const RegisterOrdersChips({
    Key? key,
    this.onTap,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  _RegisterOrdersChipsState createState() => _RegisterOrdersChipsState();
}

class _RegisterOrdersChipsState extends State<RegisterOrdersChips> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: widget.color,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [

              Text(
                widget.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
