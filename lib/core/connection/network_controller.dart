import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Get.rawSnackbar(
      //   messageText: Text(
      //     'Нет подключения к интернету!',
      //     style: GoogleFonts.montserrat(
      //       color: Colors.black,
      //       fontSize: 14,
      //     ),
      //   ),
      //   isDismissible: false,
      //   duration: const Duration(days: 1),
      //   // margin: const EdgeInsets.all(20),
      //   backgroundColor: Colors.white,
      //   borderRadius: 10,
      // );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
