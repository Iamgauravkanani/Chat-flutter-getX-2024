import 'package:chat_app_11/modules/screens/login/model/pass_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Password password = Password(isVisible: false);

  void changeVisiblity() {
    password.isVisible = !password.isVisible;
    update();
  }
}
