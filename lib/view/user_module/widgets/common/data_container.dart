import 'package:flutter/material.dart';
import 'package:hodor/core/constants/images.dart';

class DataContainer extends StatelessWidget {
  Future<void> Function() onRefresh;
  bool isLoading;
  bool isEmpty;
  Widget child;
  Widget? emptyWidget;

   DataContainer({required this.onRefresh , required this.isLoading, required this.isEmpty,required this.child ,this.emptyWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: onRefresh,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            :isEmpty? emptyWidget?? Center(
                       child:  ListView(
                           shrinkWrap: true,
                           children:[  Image.asset(AppImageAsset.empty)]
                       ),)
            : child
    );
  }
}
