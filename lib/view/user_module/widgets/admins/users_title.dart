import 'package:flutter/material.dart';

class UsersTitle extends StatelessWidget {
  final String title;
  const UsersTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child:  Text(title , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),),
      ),
    );
  }
}