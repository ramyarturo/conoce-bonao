import 'package:conoce_bonao/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/controllers/auth_controller.dart';
import 'package:conoce_bonao/controllers/main_controller.dart';
import 'package:conoce_bonao/controllers/notification_controller.dart';
import 'package:conoce_bonao/data/services/notification_service.dart';

MainController get mainController => Get.find();
AuthController get authController => Get.find();
UserController get userController => Get.find();

NotificationController get notificationController => Get.find();
NotificationService get notificationService => Get.find();
