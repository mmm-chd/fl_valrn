import 'package:get/get.dart';

class UserController extends GetxController {
  final id = RxnInt();
  final name = ''.obs;
  final email = ''.obs;
  // final name = ''.obs;
  // final email = ''.obs;
  // final name = ''.obs;
  // final email = ''.obs;

  void setUser({required int id, required String name, required String email}) {
    this.id.value = id;
    this.name.value = name;
    this.email.value = email;
  }

  void clear() {
    id.value = null;
    name.value = '';
    email.value = '';
  }
}
