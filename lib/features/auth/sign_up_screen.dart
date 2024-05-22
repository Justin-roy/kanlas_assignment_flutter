import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_bloc.dart';
import 'package:kanlas_assignment/widgets/text/bold_header_text.dart';
import 'package:kanlas_assignment/widgets/text/description_text.dart';
import 'package:kanlas_assignment/widgets/text_form_field/phone_text_field.dart';

import '../../util/validators.dart';
import '../../widgets/buttons/small_button.dart';
import '../../widgets/text_form_field/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const id = 'sign-up-screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? mobile;
  String? password;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    return Scaffold(
      resizeToAvoidBottomInset: isLargeScreen,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isLargeScreen ? 120 : 18),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height:
                        isLargeScreen ? size.height * 0.1 : size.width * 0.2),
                const BoldHeaderText(label: "Create an account"),
                const DescriptionText(
                  label: "Connect with your friends today!",
                  color: Colors.grey,
                ),
                SizedBox(
                    height:
                        isLargeScreen ? size.height * 0.05 : size.width * 0.15),
                SizedBox(
                  width: isLargeScreen ? size.width * 0.3 : null,
                  child: HeadingTextField(
                    heading: "Email",
                    onChanged: (val) => email = val,
                    hintText: 'Enter Email',
                    validator: Validators.email,
                  ),
                ),
                SizedBox(
                  width: isLargeScreen ? size.width * 0.3 : null,
                  child: PhoneTextField(
                    heading: "Phone Number",
                    onPhoneNumberChange: (phone) =>
                        mobile = phone.completeNumber,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                SizedBox(
                  width: isLargeScreen ? size.width * 0.3 : null,
                  child: HeadingTextField(
                    isPasswordField: true,
                    heading: "Password",
                    onChanged: (val) => password = val,
                    hintText: 'Enter Password',
                    validator: Validators.simpleText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  child: SizedBox(
                    width: isLargeScreen ? size.width * 0.3 : size.width * 0.9,
                    height:
                        isLargeScreen ? size.height * 0.07 : size.width * 0.12,
                    child: SmallButton(
                      radius: 10,
                      fontSize: 16,
                      label: "Sign Up",
                      onPressed: () async {
                        var bloc = context.read<AuthBloc>();
                        if (_formKey.currentState!.validate()) {
                          await bloc.signUp(
                            email: email!,
                            password: password!,
                            phone: mobile!,
                          );
                        }
                      },
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Text("Sign In"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height:
                        isLargeScreen ? size.height * 0.04 : size.width * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
