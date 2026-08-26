import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/view/admin_module/widgets/mobile_application_status_extension.dart';

import '../../../core/functions/valid_input.dart';
import '../../../model/admin/admin_mobile_application.dart';
import '../../user_module/widgets/common/custom_button.dart';

class AddEditMobileApplicationDialog extends StatefulWidget {
  final bool isEdit;
  final AdminMobileApplication? app;

  const AddEditMobileApplicationDialog({
    this.isEdit = false,
    this.app,
    super.key,
  });

  @override
  State<AddEditMobileApplicationDialog> createState() =>
      _AddEditMobileApplicationDialogState();
}

class _AddEditMobileApplicationDialogState
    extends State<AddEditMobileApplicationDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController versionController = TextEditingController();

  String platform = 'android';
  MobileApplicationStatus status = MobileApplicationStatus.supported;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.app != null) {
      platform = widget.app!.platform;
      versionController.text = widget.app!.version;
      status = widget.app!.status;
    }
  }

  @override
  void dispose() {
    versionController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColor.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColor.lightGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColor.secondaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColor.pink),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColor.pink),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.darkBlue,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Dialog(
            insetPadding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          width: 15,
                          child: IconButton(
                            onPressed: Get.back,
                            icon: const Icon(Icons.close, size: 15),
                          ),
                        ),
                        Text(
                          widget.isEdit ? 'edit_version'.tr : 'add_version'.tr,
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

                    _label('platform'.tr),
                    DropdownButtonFormField<String>(
                      value: platform,
                      isExpanded: true,
                      decoration: _fieldDecoration('platform'.tr),
                      items: const [
                        DropdownMenuItem(value: 'android', child: Text('Android')),
                        DropdownMenuItem(value: 'ios', child: Text('iOS')),
                      ],
                      onChanged: (value) {
                        setState(() => platform = value ?? 'android');
                      },
                    ),

                    const SizedBox(height: 14),

                    _label('Version'),
                    TextFormField(
                      controller: versionController,
                      decoration: _fieldDecoration('version'.tr),
                      validator: (val){ return validInput(val!, 1, 10, null);},),

                    const SizedBox(height: 14),

                    _label('status'.tr),

                    DropdownButtonFormField<MobileApplicationStatus>(
                      value: status,
                      isExpanded: true,
                      decoration: _fieldDecoration('status'.tr),
                      items: MobileApplicationStatus.values.map((item) {
                        return DropdownMenuItem<MobileApplicationStatus>(
                          value: item,
                          child: Text(
                            item.title,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          status = value;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    CustomButtonWidget(
                      title: 'save'.tr,
                      backgroundColor: AppColor.secondaryColor,
                      textColor: AppColor.white,
                      onPress: () {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          Get.back(result: {
                            'platform': platform,
                            'version': versionController.text.trim(),
                            'status': status.apiValue,
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}