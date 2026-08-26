import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';

class AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final void Function()? onPress;
  const AdminStatCard(
      {required this.title,
      required this.value,
      required this.icon,
        this.onPress,
      super.key});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onPress,
    child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 5))
            ]),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: AppColor.secondaryColor, size: 32),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkBlue)),
          const SizedBox(height: 4),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColor.grey, fontWeight: FontWeight.bold))
        ])),
  );
}
