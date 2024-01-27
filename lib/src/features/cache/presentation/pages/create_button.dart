import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: Colors.red,
        width: 200,
        height: 50,
        // child: ElevatedButton(
        //   onPressed: onPressed,
        //   child: const Text('Create'),
        // ),
      ),
    );
  }
}
