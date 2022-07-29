import 'package:get/get.dart';
import 'package:conoce_bonao/controllers/auth_controller.dart';
import 'package:conoce_bonao/controllers/main_controller.dart';
import 'package:conoce_bonao/controllers/notification_controller.dart';
import 'package:conoce_bonao/data/services/notification_service.dart';

AuthController get authController => Get.find();
NotificationController get notificationController => Get.find();
MainController get mainController => Get.find();

NotificationService get notificationService => Get.find();
