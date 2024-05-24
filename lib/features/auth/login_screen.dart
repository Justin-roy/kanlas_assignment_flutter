import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_bloc.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_state.dart';
import 'package:kanlas_assignment/routes/routes_import.gr.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';
import 'package:kanlas_assignment/util/validators.dart';
import 'package:kanlas_assignment/widgets/buttons/small_button.dart';
import 'package:kanlas_assignment/widgets/text_form_field/text_form_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = true;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLargeScreen = size.width > 600;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              AutoRouter.of(context).replaceAll([const HomeScreenRoute()]);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: isLargeScreen,
            body: Form(
              key: _formKey,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: isLargeScreen ? 120 : 18),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: isLargeScreen
                              ? size.height * 0.2
                              : size.width * 0.2),
                      const Icon(Icons.camera_outlined, size: 150),
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
                        child: HeadingTextField(
                          isPasswordField: true,
                          heading: "Password",
                          onChanged: (val) => password = val,
                          hintText: 'Enter Password',
                          validator: Validators.simpleText,
                        ),
                      ),
                      SizedBox(
                        width: isLargeScreen ? size.width * 0.3 : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //remember me
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Pallet.purple,
                                  fillColor:
                                      MaterialStateProperty.all(Colors.white),
                                  value: rememberMe,
                                  onChanged: (val) =>
                                      setState(() => rememberMe = val ?? false),
                                ),
                                const Text("Remember me")
                              ],
                            ),
                            // forget password
                            TextButton(
                              onPressed: () => AutoRouter.of(context)
                                  .pushNamed('/forget-password'),
                              child: const Text(
                                "Forget Password",
                                style: TextStyle(color: Pallet.red),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: SizedBox(
                          width: isLargeScreen
                              ? size.width * 0.3
                              : size.width * 0.9,
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
                                  label: "Login",
                                  onPressed: () async {
                                    var bloc = context.read<AuthBloc>();
                                    if (_formKey.currentState!.validate()) {
                                      await bloc.signIn(
                                          email: email!, password: password!);
                                    }
                                  },
                                ),
                        ),
                      ),
                      const Spacer(),
                      Wrap(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () =>
                                AutoRouter.of(context).pushNamed('/signup'),
                            child: const Text("Sign Up"),
                          )
                        ],
                      ),
                      SizedBox(
                          height: isLargeScreen
                              ? size.height * 0.04
                              : size.width * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
