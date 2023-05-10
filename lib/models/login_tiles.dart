import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  const LoginTile({
    super.key,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 3,
          )),
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
