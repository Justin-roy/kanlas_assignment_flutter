import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/api/repo.dart';
import 'package:kanlas_assignment/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../cache/prefs_constant.dart';
import '../../../../cache/shared_preferences.dart';
import '../../../../util/bot_toast/bot_toast_functions.dart';
import '../../../util/custom_logger.dart';
import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc()
      : super(const AuthState(
          isAuthenticated: false,
          isLoading: false,
        ));

  final SharedPreferences _prefs = Pref.instance.pref;
  final _repo = Repo();

  // api calls
  Future<void> signIn({required String email, required String password}) async {
    try {
      _showLoading();
      var response = await _repo.signIn(email: email, password: password);
      if (response['success']) {
        CustomLogger.logInfo(response['data'].toString());
        var user = UserModel.fromJson(response);
        emit(state.copyWith(userModel: user));
        saveToken(userId: user.data!.id!);
      }
    } catch (e) {
      CustomLogger.logError(e.toString());
    } finally {
      _closeLoading();
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String phone}) async {
    try {
      _showLoading();
      var response =
          await _repo.signUp(email: email, password: password, phone: phone);
      if (response['success']) {
        showNotification(title: "${response['message']}\nNow go back to login");
        emit(state.copyWith(isAuthenticated: true));
      } else {
        showNotification(title: response['message']);
        debugPrint(response.toString());
      }
    } catch (e) {
      CustomLogger.logError(e.toString());
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      _closeLoading();
    }
  }

  saveToken({required String userId}) async {
    await _prefs.setString(PrefConstant.loggedUserId, userId);
    await _prefs.setBool(PrefConstant.isLoggedIn, true);
    emit(state.copyWith(isAuthenticated: true));
  }

  Future<bool> sendOTP({required String email}) async {
    try {
      _showLoading();
      var response = await _repo.sentOTP(email: email);
      if (response['success']) {
        CustomLogger.logInfo(response['data'].toString());
        showNotification(
            title: response['data'], duration: const Duration(seconds: 10));
        return true;
      } else {
        showNotification(title: response['message']);
        debugPrint(response.toString());
      }
    } catch (e) {
      CustomLogger.logError(e.toString());
    } finally {
      _closeLoading();
    }
    return false;
  }

  Future<void> forgetPassword(
      {required String email,
      required String otp,
      required String password}) async {
    try {
      _showLoading();
      var response =
          await _repo.veriftyOTP(email: email, otp: otp, password: password);
      if (response['success']) {
        CustomLogger.logInfo(response['message'].toString());
        showNotification(title: response['message']);
      } else {
        showNotification(title: response['message']);
        debugPrint(response.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _closeLoading();
    }
  }

  Future<void> getUser({required String userId}) async {
    try {
      _showLoading();
      var response = await _repo.getUser(userId: userId);
      if (response['success']) {
        CustomLogger.logInfo(response['data'].toString());
        var user = UserModel.fromJson(response);
        emit(state.copyWith(userModel: user));
      }
    } catch (e) {
      CustomLogger.logError(e.toString());
    } finally {
      _closeLoading();
    }
  }

  _showLoading() {
    emit(state.copyWith(isLoading: true));
  }

  _closeLoading() {
    emit(state.copyWith(isLoading: false));
  }
}
