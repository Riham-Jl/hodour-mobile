import 'package:flutter/material.dart';

import 'empty_button.dart';

class ImagePickerContainer extends StatelessWidget {
  void Function()? onPressed;
  Color color;
  String icon;
  String text;
   ImagePickerContainer({required this.onPressed, required this.color, required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return  EmptyButton(
        onPressed: onPressed,

        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                width:70,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color
                ),
                child: Image.asset(icon)),
            Text(text)
          ],
        )
    );
  }
}
