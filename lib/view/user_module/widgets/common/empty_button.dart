import 'package:flutter/material.dart';


class EmptyButton extends StatelessWidget {
  void Function()? onPressed;
  Widget child;
  Color? color;
  double? padding ;
  double? circular;

   EmptyButton({required this.child , this.onPressed, this.color, this.padding, this.circular, super.key});

  @override
  Widget build(BuildContext context) {
    return  TextButton(
        onPressed: onPressed,
    style: TextButton.styleFrom(
    padding: EdgeInsets.all( padding ?? 5),
    minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circular?? 20),


        )
    ),
    child: child
    );
  }
}
