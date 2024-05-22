// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';
import '../../util/extentions/extensions.dart';

class HeadingTextField extends StatefulWidget {
  final void Function(String?) onChanged;
  final String? hintText;
  final String heading;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordField;
  const HeadingTextField({
    super.key,
    required this.onChanged,
    this.hintText,
    required this.heading,
    this.validator,
    this.maxLines = 1,
    this.initialText,
    this.keyboardType,
    this.maxLength,
    this.textCapitalization,
    this.enabled = true,
    this.isPasswordField = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<HeadingTextField> createState() => _HeadingTextFieldState();
}

class _HeadingTextFieldState extends State<HeadingTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: const TextStyle(
              color: Pallet.purple, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          enabled: widget.enabled,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          initialValue: widget.initialText,
          validator: widget.validator,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          obscureText: widget.isPasswordField ? obscureText : false,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            helperText: ' ',
            counterText: '',
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.5, horizontal: 12),
            hintText: widget.hintText,
            labelStyle:
                textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w300),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  )
                : widget.suffixIcon,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
