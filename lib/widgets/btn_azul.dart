import 'package:flutter/material.dart';

class BtnAzul extends StatelessWidget {
  final String text;
  final Function()? onPressd;

  const BtnAzul({super.key, required this.text, required this.onPressd});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressd,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
