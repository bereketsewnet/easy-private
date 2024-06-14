import 'package:Easy/common/SnackBar/upper_snack_bar.dart';
import 'package:Easy/common/SocketConnection/SocketMethods.dart';
import 'package:Easy/provider/controller/AuthController.dart';
import 'package:Easy/provider/controller/ChatController.dart';
import 'package:get/get.dart';

import '../../common/SnackBar/lower_snack_bar.dart';
import '../controller/UserController.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    // not all controller inject in the app started
    // if and only if when the app need more time and any time


    // inject Controller
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => SocketMethods());

    // inject Class
    Get.lazyPut(() => UpperSnackBar());
    Get.lazyPut(() => LowerSnackBar());
  }

}