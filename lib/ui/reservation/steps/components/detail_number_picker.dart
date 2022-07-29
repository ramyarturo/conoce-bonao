import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';
import 'package:conoce_bonao/widgets/circle_icon.dart';
import 'package:intl/intl.dart';
import 'package:synchronized/synchronized.dart';

class DetailNumberPicker extends StatelessWidget {
  final String title;
  final int initialNumber;
  final void Function(int number)? onChanged;
  const DetailNumberPicker({
    super.key,
    required this.title,
    this.initialNumber = 1,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    final number = initialNumber.obs;
    if (onChanged != null) {
      number.listen(onChanged!);
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
          ),
        ),
        const VerticalSpacing(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CircleIcon(
              icon: Icons.add,
              onPressing: () {
                if (number.value < 100) {
                  number.value++;
                }
              },
            ),
            SizedBox(
              width: 72,
              child: Obx(() {
                return _NumberDisplayField(number: number.value);
              }),
            ),
            _CircleIcon(
              icon: Icons.remove_sharp,
              onPressing: () {
                if (number.value > 1) {
                  number.value--;
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _NumberDisplayField extends StatelessWidget {
  const _NumberDisplayField({
    Key? key,
    required this.number,
  }) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: Listener(
        child: TextField(
          readOnly: true,
          textAlign: TextAlign.center,
          controller: TextEditingController(text: number.toString()),
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(6),
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: greyColor,
                )),
          ),
        ),
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final VoidCallback? onPressing;

  const _CircleIcon({
    super.key,
    required this.icon,
    this.onPressed,
    this.onPressing,
  });

  @override
  Widget build(BuildContext context) {
    var isButtonPressed = false;
    final lock = Lock();

    return CircleIcon(
      child: Listener(
        onPointerDown: (_) async {
          SystemSound.play(SystemSoundType.click);

          isButtonPressed = true;
          await lock.synchronized(() async {
            while (isButtonPressed) {
              onPressing?.call();

              await Future.delayed(const Duration(milliseconds: 175));
            }
          });
          onPressed?.call();
        },
        onPointerUp: (_) {
          isButtonPressed = false;
        },
        child: Icon(icon, color: blackColor),
      ),
    );
  }
}
