import 'package:Easy/common/SnackBar/upper_snack_bar.dart';
import 'package:Easy/provider/controller/AuthController.dart';
import 'package:get/get.dart';

import '../../common/SnackBar/lower_snack_bar.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    // inject Controller
    Get.lazyPut(() => AuthController());

    // inject Class
    Get.lazyPut(() => UpperSnackBar());
    Get.lazyPut(() => LowerSnackBar());
  }

}