import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    super.key,
    required this.onPhoneNumberChange,
    required this.heading,
    this.initialValue,
    this.readOnly = false,
    this.initialCountryCode = "IN",
  });
  final void Function(PhoneNumber number) onPhoneNumberChange;
  final String? initialValue;
  final String heading;
  final bool readOnly;
  final String? initialCountryCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
              color: Pallet.purple, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        IntlPhoneField(
          initialCountryCode: initialCountryCode,
          keyboardType: TextInputType.phone,
          readOnly: readOnly,
          decoration: const InputDecoration(
            counterText: "",
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.5, horizontal: 12),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          textInputAction: TextInputAction.done,
          onChanged: (phoneNumber) => onPhoneNumberChange(phoneNumber),
          initialValue: initialValue,
        ),
      ],
    );
  }
}
