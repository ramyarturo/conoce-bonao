import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/controllers/notification_controller.dart';
import 'package:conoce_bonao/ui/notifications/components/single_notification_item.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> sizeFloatingAnimation;
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: 100.milliseconds);
    scrollController = ScrollController()..addListener(_scrollListener);

    sizeFloatingAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
  }

  _scrollListener() {
    bool isBottom = scrollController.position.pixels == scrollController.position.maxScrollExtent;
    isFloatingButtonVisible = isBottom;
  }

  set isFloatingButtonVisible(bool value) {
    if (value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedBuilder(
          animation: sizeFloatingAnimation,
          builder: ((context, child) {
            return Transform.scale(
              scale: sizeFloatingAnimation.value,
              child: FloatingActionButton(
                onPressed: notificationController.clearNotifications,
                child: const Icon(Icons.mark_chat_read),
              ),
            );
          })),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacing(topPadding),
            Text(
              "Novedades! 👋",
              style: Theme.of(context).textTheme.headline5,
            ),
            const Text("Centro de notificaciones"),
            const VerticalSpacing(defaultVerticalSpacing * 2.5),
            Expanded(
              child: GetX<NotificationController>(
                builder: (controller) {
                  if (controller.notificationList.isEmpty) {
                    isFloatingButtonVisible = false;
                    return const Center(
                      child: Text("No tiene notificaciones pendientes"),
                    );
                  }
                  isFloatingButtonVisible = true;
                  return AnimatedList(
                    key: controller.animatedKeyList,
                    controller: scrollController,
                    initialItemCount: controller.notificationList.length,
                    itemBuilder: ((context, index, animation) {
                      final item = controller.notificationList[index];
                      return SizeTransition(
                        sizeFactor: animation,
                        child: SingleNotificationItem(notification: item),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    animationController.dispose();
  }
}
