import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';

import '../../../core/functions/valid_input.dart';
import '../../user_module/widgets/common/custom_button.dart';
import '../../user_module/widgets/common/custom_text_field.dart';

class AdminEditUserDialog extends StatefulWidget {
  final bool isEdit;
  final bool isAdmin;
  final int allowedCoursesCount;
  final int allowedMembersCount;

  const AdminEditUserDialog({
    this.isEdit = true,
    this.isAdmin = false,
    this.allowedCoursesCount = 3,
    this.allowedMembersCount = 100,
    super.key,
  });

  @override
  State<AdminEditUserDialog> createState() => _AdminEditUserDialogState();
}

class _AdminEditUserDialogState extends State<AdminEditUserDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController coursesController;
  late TextEditingController membersController;

  late bool isAdmin;

  @override
  void initState() {
    super.initState();

    isAdmin = widget.isAdmin;

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    coursesController =
        TextEditingController(text: widget.allowedCoursesCount.toString());
    membersController =
        TextEditingController(text: widget.allowedMembersCount.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    coursesController.dispose();
    membersController.dispose();
    super.dispose();
  }

  Widget _label(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 15,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, size: 15),
                      ),
                    ),
                    Text(
                      widget.isEdit ? 'edit_user'.tr : 'add_user'.tr,
                      style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(width: 15),
                  ],
                ),

                const SizedBox(height: 10),

                if (!widget.isEdit) ...[
                  _label("${"name".tr}:"),
                  CustomTextField(
                    theController: nameController,
                    hintText: "name".tr,
                    validator: (val) => validInput(val!, 3, 50, null),
                  ),
                  const SizedBox(height: 10),

                  _label("${"email".tr}:"),
                  CustomTextField(
                    theController: emailController,
                    hintText: "email".tr,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => validInput(val!, 5, 100, "email"),
                  ),
                  const SizedBox(height: 10),
                ],

                _label(widget.isEdit? "change_password".tr : "password".tr),
                CustomTextField(
                  theController: passwordController,
                  hintText:widget.isEdit? "new_password".tr : "password".tr,
                  validator: (val) {
                    return validInput(
                      val!,
                      6,
                      50,
                      "password",
                      nullable: widget.isEdit,
                    );
                  },
                ),

                const SizedBox(height: 10),

                _label("${"allowed_courses_count".tr}:"),
                CustomTextField(
                  theController: coursesController,
                  hintText: "allowed_courses_count".tr,
                  keyboardType: TextInputType.number,
                  validator: (val) => validInput(val!, 1, 5, null),
                ),

                const SizedBox(height: 10),

                _label("${"allowed_members_count".tr}:"),
                CustomTextField(
                  theController: membersController,
                  hintText: "allowed_members_count".tr,
                  keyboardType: TextInputType.number,
                  validator: (val) => validInput(val!, 1, 5, null),
                ),

                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: isAdmin,
                  title: Text(
                    "is_admin".tr,
                    style: const TextStyle(
                      color: AppColor.darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  inactiveTrackColor: AppColor.grey2,
                  onChanged: (value) {
                    setState(() => isAdmin = value);
                  },
                ),

                CustomButtonWidget(
                  title: 'save'.tr,
                  backgroundColor: AppColor.primaryColor,
                  textColor: AppColor.white,
                  onPress: () {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      final Map<String, dynamic> data = {
                        'admin': isAdmin ? 1 : 0,
                        'Courses_count':
                        int.parse(coursesController.text.trim()),
                        'members_count':
                        int.parse(membersController.text.trim()),
                      };

                      if (!widget.isEdit) {
                        data['name'] = nameController.text.trim();
                        data['email'] = emailController.text.trim();
                        data['password'] = passwordController.text.trim();
                      } else if (passwordController.text.trim().isNotEmpty) {
                        data['password'] = passwordController.text.trim();
                      }

                      Get.back(result: data);
                    }
                  },
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}