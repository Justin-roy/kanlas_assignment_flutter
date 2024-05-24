import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/cache/prefs_constant.dart';
import 'package:kanlas_assignment/features/auth/bloc/auth_bloc.dart';
import 'package:kanlas_assignment/features/home/bloc/home_bloc.dart';
import 'package:kanlas_assignment/styles/colors/pallet.dart';
import 'package:kanlas_assignment/util/show_snack_bar.dart';
import 'package:kanlas_assignment/util/utils.dart';
import 'package:kanlas_assignment/widgets/text/bold_header_text.dart';
import 'package:kanlas_assignment/widgets/text/description_text.dart';

import '../../cache/shared_preferences.dart';
import '../auth/bloc/auth_state.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const id = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();

  @override
  void initState() {
    _getUserDetail();
    super.initState();
  }

  _getUserDetail() async {
    String? userID = Pref.instance.pref.getString(PrefConstant.loggedUserId);
    var bloc = context.read<AuthBloc>();
    if (userID != null && bloc.state.userModel?.data == null) {
      await bloc.getUser(userId: userID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLargeScreen = size.width > 600;

    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          var authBloc = state.userModel?.data;
          return Scaffold(
            resizeToAvoidBottomInset: !isLargeScreen,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => _logoutPopUpDialog(context));
                  },
                  icon: const Icon(Icons.logout_rounded),
                )
              ],
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: isLargeScreen
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldHeaderText(
                            label:
                                "Welcome ${getUsernameFromEmail(authBloc?.email)}",
                          ),
                          const DescriptionText(
                            label:
                                "Reedem your points or scan QR to earn more\nEach Scan Gives you 10 Points",
                            color: Colors.grey,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.15),
                      Container(
                        alignment: Alignment.center,
                        width: isLargeScreen ? size.width * 0.5 : size.width,
                        height: isLargeScreen
                            ? size.height * 0.3
                            : size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Pallet.purple,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // progress
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text:
                                        '${((authBloc?.coin ?? 0) / 10).ceil()}',
                                    children: const <TextSpan>[
                                      TextSpan(
                                        text: '/100',
                                        style: TextStyle(
                                          color: Pallet.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: SizedBox(
                                    height: 6,
                                    width: isLargeScreen
                                        ? size.width * 0.2
                                        : size.width * 0.3,
                                    child: LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(30),
                                      value: (authBloc?.coin ?? 0) / 1000,
                                      color: Pallet.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // wallet
                            Container(
                              width: isLargeScreen
                                  ? size.width * 0.2
                                  : size.width * 0.4,
                              height: isLargeScreen
                                  ? size.height * 0.25
                                  : size.width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.wallet,
                                        color: Pallet.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(
                                          "balance",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Pallet.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.camera_outlined,
                                        color: Colors.black,
                                        size: 35,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          "Rs. ${authBloc?.coin}",
                                          style: const TextStyle(
                                            color: Pallet.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      "Reedem",
                                      style: TextStyle(
                                        color: Pallet.green,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: IconButton(
                          onPressed: () async {
                            var coinBloc = context.read<AuthBloc>();
                            var data = await AutoRouter.of(context)
                                .pushNamed('/qr-home');

                            if (data is String) {
                              if (authBloc != null && authBloc.id != null) {
                                bool check = await _bloc.scanQrCode(
                                    qrCode: data, userId: authBloc.id!);
                                await coinBloc.getUser(userId: authBloc.id!);
                                if (!context.mounted) return;
                                showSnackBar(context, isWrongMessage: !check);
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.qr_code_scanner_rounded,
                            size: 85,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.1),
                    ],
                  ),
                ),
                if (state.isLoading)
                  isLargeScreen
                      ? const SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 8.0,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
              ],
            ),
          );
        },
      ),
    );
  }

  _logoutPopUpDialog(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
      child: AlertDialog(
        backgroundColor: Colors.grey.shade200.withOpacity(0.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        title: const Text(
          'Are you sure you want to logout?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
            ),
          ),
          //
          TextButton(
            onPressed: () async {
              final prefs = Pref.instance.pref;
              var navigator = AutoRouter.of(context);
              await prefs.clear();
              navigator.pushNamed('/login');
            },
            child: const Text(
              'Log Out',
            ),
          )
        ],
      ),
    );
  }
}
