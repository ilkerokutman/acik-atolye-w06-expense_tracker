import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    //
    await Get.putAsync(() async => ExpenseController(), permanent: true);
  }
}
