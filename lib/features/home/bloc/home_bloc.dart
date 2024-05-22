import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanlas_assignment/api/repo.dart';
import '../../../../util/bot_toast/bot_toast_functions.dart';
import '../../../util/custom_logger.dart';
import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState(isLoading: false));

  final _repo = Repo();

  // api calls
  Future<bool> scanQrCode(
      {required String qrCode, required String userId}) async {
    try {
      _showLoading();
      var response = await _repo.scanQrCode(qrCode: qrCode, userId: userId);
      if (response['success']) {
        CustomLogger.logInfo(response['data'].toString());
        return true;
      } else {
        showNotification(title: response['message']);
      }
    } catch (e) {
      CustomLogger.logError(e.toString());
    } finally {
      _closeLoading();
    }
    return false;
  }

  _showLoading() {
    emit(state.copyWith(isLoading: true));
  }

  _closeLoading() {
    emit(state.copyWith(isLoading: false));
  }
}
