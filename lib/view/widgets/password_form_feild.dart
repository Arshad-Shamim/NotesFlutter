import 'package:flutter/material.dart';

class BuildPasswordField extends StatelessWidget {

  late TextEditingController controller;
  late String label;
  late bool isHidden;
  late VoidCallback onTap;
  TextInputType keyboardType = TextInputType.text;
  String? Function(String?)? validator;

  BuildPasswordField({super.key,required this.controller,required this.label,required this.isHidden,required this.onTap,keyboardType=TextInputType.text,this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: isHidden,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              isHidden ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}