import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hodor/core/constants/colors.dart';
import 'package:hodor/core/constants/images.dart';



class AuthInputText extends StatefulWidget {
  String? hintText;
  void Function(String)? onChange;
  void Function()? onTap;
  String? Function(String?)? validator;
  void Function(String)? onFieldSubmitted;
  bool obscureText;
  String? initialValue;
  String? labelText;
  Widget? prefix;
  Widget? suffix;
  bool isPassword;
  TextDirection? textDirection;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  Color? backgroundColor;
  bool? readonly;
  TextEditingController? theController = TextEditingController();

  AuthInputText(
      {super.key,  this.prefix,
        this.suffix,
        this.readonly=false,
        this.textInputType,
        this.labelText,
        this.hintText,
        this.onChange,
        this.theController,
        this.validator,
        this.textDirection,
        this.obscureText = false,
        this.isPassword = false,
        this.textInputAction,
        this.onFieldSubmitted,
        this.onTap,
        this.initialValue,
        this.backgroundColor
      });

  @override
  State<AuthInputText> createState() => _InputTextState();
}

class _InputTextState extends State<AuthInputText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: const TextStyle(color: AppColor.grey , fontSize: 14),
        onTap: widget.onTap ,
       // readOnly: readonly!,
        textDirection: widget.textDirection,
        validator: widget.validator,
        initialValue: widget.initialValue,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChange,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText,
        controller: widget.theController,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30),
            borderSide: widget.backgroundColor!=null? BorderSide.none:const BorderSide()
          ),
            filled: true,
            fillColor: widget.backgroundColor??AppColor.white,
            labelText: widget.labelText,
            hintText: widget.hintText ,
             hintTextDirection: widget.textDirection == TextDirection.rtl
                ? TextDirection.rtl
                : TextDirection.ltr,
            suffixIcon:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: widget.prefix,
                ),
            prefixIcon: widget.isPassword? Padding(
                padding: const EdgeInsets.all(10.0),
                child:  GestureDetector(
                  onTap: (){
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
              child: Icon(widget.obscureText?Icons.visibility_off_outlined :Icons.visibility_outlined , color: AppColor.grey,),
            )
            ):widget.suffix
        )

      ),
    );
  }
}
