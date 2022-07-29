import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/controllers/main_controller.dart';
import 'package:conoce_bonao/ui/main/main_page.dart';
import 'package:conoce_bonao/ui/map/map_viewer_page.dart';
import 'package:conoce_bonao/ui/notifications/notification_page.dart';
import 'package:conoce_bonao/ui/profile/profile_page.dart';
import 'package:conoce_bonao/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  final homeController = Get.put(MainController());
  late final toMap = [
    () => const MainPage(),
    () => const MapViewerPage(),
    () => const NotificationPage(),
    () => const ProfilePage(),
  ].asMap();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        currentIndex: currentIndex,
        onChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: toMap.values.toList()[currentIndex](),
    );
  }
}
