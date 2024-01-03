import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {

  final controller;
  final String hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(204, 0, 125, 82),
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.white,
          child: const Text(
            "Save",
            style: TextStyle(
                color: Color.fromRGBO(206, 33, 255, 0.6),
                fontWeight: FontWeight.bold),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.white,
          child: const Text(
            "Cancel",
            style: TextStyle(
                color: Color.fromARGB(204, 0, 125, 82),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
