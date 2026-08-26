


import 'package:flutter/material.dart';
import 'package:hodor/core/constants/images.dart';

class BackgroundContainer extends StatelessWidget {


  Widget child;

  BackgroundContainer ({super.key, required this.child } );

  @override
  Widget build(BuildContext context) {
    return    Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage(AppImageAsset.background),
      fit: BoxFit.cover,
      ),
      ),
      child: child
    );
  }

}