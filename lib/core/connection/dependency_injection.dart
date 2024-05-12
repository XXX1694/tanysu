import 'package:get/get.dart';
import 'package:tanysu/core/connection/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
