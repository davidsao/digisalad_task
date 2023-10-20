import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digisalad_task/constants/constant.dart';
import 'package:get/get.dart';

Future<bool> checkConnection() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Get.snackbar(
        'Internet Connection Error', 'Please turn on your wifi or mobile data',
        backgroundColor: AppColor.errorColor,
        duration: const Duration(seconds: 3),
        colorText: AppColor.backgroundColor);
    return false;
  }
  return true;
}
