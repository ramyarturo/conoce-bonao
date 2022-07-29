import 'package:flutter/material.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/models/notification.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

class SingleNotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const SingleNotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 9.45,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          constraints: const BoxConstraints(
            maxHeight: 125,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  const Text(
                    "👋",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: greenColor,
                              fontSize: 18,
                              letterSpacing: 0.3,
                            ),
                      ),
                      Text(notification.body),
                    ],
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(localizations.formatTimeOfDay(TimeOfDay.fromDateTime(notification.sentAt))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
