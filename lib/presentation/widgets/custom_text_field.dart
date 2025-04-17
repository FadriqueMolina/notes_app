import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? formerText;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.formerText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    if (widget.formerText != null) {
      widget.controller.text = widget.formerText!;
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: widget.controller,

        decoration: InputDecoration(
          hintText: widget.hint,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
