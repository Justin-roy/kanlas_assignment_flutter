import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_bloc.dart';
import 'package:kanlas_assignment/util/bot_toast/bot_toast_functions.dart';
import 'package:kanlas_assignment/widgets/text/bold_header_text.dart';

import '../../util/validators.dart';
import '../../widgets/buttons/small_button.dart';
import '../../widgets/text_form_field/text_form_field.dart';
import 'bloc/auth_state.dart';

@RoutePage()
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static const id = 'forget-password-screen';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  bool showMoreFields = false;
  String? email;
  String? password;
  String? otp;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLargeScreen = size.width > 600;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: isLargeScreen,
          body: Form(
            key: _formKey,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: isLargeScreen ? 120 : 18),
              child: Column(
                crossAxisAlignment: isLargeScreen
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height:
                          isLargeScreen ? size.height * 0.2 : size.width * 0.2),
                  const BoldHeaderText(label: "Change Password"),
                  SizedBox(
                      height:
                          isLargeScreen ? size.height * 0.1 : size.width * 0.1),
                  SizedBox(
                    width: isLargeScreen ? size.width * 0.3 : null,
                    child: HeadingTextField(
                      heading: "Email",
                      onChanged: (val) => email = val,
                      hintText: 'Enter Email',
                      validator: Validators.email,
                    ),
                  ),
                  Visibility(
                    visible: showMoreFields,
                    child: SizedBox(
                      width: isLargeScreen ? size.width * 0.3 : null,
                      child: HeadingTextField(
                        isPasswordField: true,
                        heading: "Password",
                        onChanged: (val) => password = val,
                        hintText: 'Enter New Password',
                        validator: Validators.simpleText,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showMoreFields,
                    child: SizedBox(
                      width: isLargeScreen ? size.width * 0.3 : null,
                      child: HeadingTextField(
                        heading: "OTP",
                        onChanged: (val) => otp = val,
                        hintText: 'Enter OTP',
                        validator: Validators.simpleText,
                      ),
                    ),
                  ),
                  Align(
                    alignment: isLargeScreen
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Resend OTP"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: SizedBox(
                      width:
                          isLargeScreen ? size.width * 0.3 : size.width * 0.9,
                      height: isLargeScreen
                          ? size.height * 0.07
                          : size.width * 0.12,
                      child: state.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SmallButton(
                              radius: 10,
                              fontSize: 16,
                              label:
                                  showMoreFields ? "Change Password" : "Send",
                              onPressed: showMoreFields
                                  ? () async {
                                      var bloc = context.read<AuthBloc>();
                                      if (_formKey.currentState!.validate()) {
                                        await bloc.forgetPassword(
                                            email: email!,
                                            otp: otp!,
                                            password: password!);
                                      }
                                    }
                                  : () async {
                                      if (email != null) {
                                        var bloc = context.read<AuthBloc>();
                                        showMoreFields =
                                            await bloc.sendOTP(email: email!);
                                        setState(() {});
                                      } else {
                                        showNotification(
                                            title: "Email is required");
                                      }
                                    },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
