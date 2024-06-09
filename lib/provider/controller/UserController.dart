import 'package:Easy/Model/UserModel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late User _currentUser;
  bool _isLoading = false;

  User get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  void updateCurrentUser(User user) {
    _currentUser = user;
  }

  void controlLoading(bool loading) {
    _isLoading = loading;
    update();
  }
}
