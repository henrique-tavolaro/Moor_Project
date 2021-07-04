import 'package:flutter/material.dart';
import 'package:project/Theme/AppColors.dart';

class HomePageCard extends StatelessWidget {
  final VoidCallback onTap;
  final String cardName;
  final IconData icon;

  const HomePageCard({
    Key? key,
    required this.onTap,
    required this.cardName,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            // color: AppColors.primaryLight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon),
                  Text(
                    cardName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
