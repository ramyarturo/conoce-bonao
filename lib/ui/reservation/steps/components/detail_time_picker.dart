import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';
import 'package:conoce_bonao/widgets/circle_icon.dart';

import '../../../../constants/theme.dart';

class DetailTimePicker extends StatelessWidget {
  final String title;
  final bool datePicker;
  final void Function(DateTime dateTime)? onDateChange;
  final void Function(TimeOfDay timeOfDay)? onTimeChange;
  const DetailTimePicker({
    super.key,
    required this.title,
    this.datePicker = false,
    this.onDateChange,
    this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    final selectedTime = TimeOfDay.now().obs;
    final selectedDate = DateTime.now().obs;
    final localizations = MaterialLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelMedium),
        const VerticalSpacing(20),
        GestureDetector(
          onTap: () async {
            if (datePicker) {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(365.days),
              ).then((value) {
                if (value != null) {
                  selectedDate.value = value;
                  onDateChange?.call(value);
                }
              });
            } else {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((value) {
                if (value != null) {
                  selectedTime.value = value;
                  onTimeChange?.call(value);
                }
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleIcon(
                child: Icon(
                  datePicker ? Icons.calendar_month_outlined : Icons.watch_later_outlined,
                  color: datePicker ? blackColor : greenColor,
                ),
              ),
              Obx(() => Text(
                    datePicker
                        ? localizations.formatFullDate(selectedDate.value)
                        : localizations.formatTimeOfDay(
                            selectedTime.value,
                            alwaysUse24HourFormat: false,
                          ),
                    style: TextStyle(
                      color: datePicker ? yellowColor : greenColor,
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
