
import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {

  late TextEditingController controller;
  late String label;
  TextInputType keyboardType = TextInputType.text;
  String? Function(String?)? validator;

  BuildTextField({super.key,required this.controller,required this.label,keyboardType=TextInputType.text,this.validator});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

