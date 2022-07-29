import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/ui/reservation/steps/base_step.dart';
import 'package:conoce_bonao/widgets/custom_textfield.dart';

import '../../../controllers/reservation_controller.dart';

class PaymentStep extends StatefulWidget {
  const PaymentStep({super.key});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends BaseStep<PaymentStep> {
  final formKey = GlobalKey<FormState>();
  var showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showBackView = !showBackView;
            });
          },
          child: GetX<ReservationController>(builder: (controller) {
            return CreditCardWidget(
              cardNumber: controller.creditCard.value.cardNumber,
              expiryDate: controller.creditCard.value.expiryDate,
              cardHolderName: controller.creditCard.value.cardHolderName,
              isHolderNameVisible: true,
              cvvCode: controller.creditCard.value.cvvCode,
              showBackView: showBackView,
              labelCardHolder: "Nombre",
              onCreditCardWidgetChange: (creditCard) {},
            );
          }),
        ),
        CustomTextField(
            hint: "Nombre",
            initialValue: controller.creditCard.value.cardHolderName,
            onChanged: (value) => controller.creditCard.update((val) {
                  val?.cardHolderName = value;
                })),
        const VerticalSpacing(10),
        CustomTextField(
            hint: "Número",
            initialValue: controller.creditCard.value.cardNumber,
            textInputType: TextInputType.number,
            maxLength: 17,
            onChanged: (value) => controller.creditCard.update((val) {
                  val?.cardNumber = value;
                })),
        const VerticalSpacing(10),
        Obx(() => CustomTextField(
              hint: "Fecha",
              initialValue: controller.creditCard.value.expiryDate,
              textInputType: TextInputType.none,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add((365 * 10).days),
                ).then((value) {
                  if (value != null) {
                    controller.creditCard.update((val) {
                      val?.expiryDate = "${value.month}/${value.year.toString().substring(2, 4)}";
                    });
                  }
                });
              },
              onChanged: (value) {
                controller.creditCard.update((val) {
                  val?.expiryDate = value;
                });
              },
            )),
        const VerticalSpacing(10),
        SizedBox(
          width: 100,
          child: CustomTextField(
            hint: "CVV",
            initialValue: controller.creditCard.value.cvvCode,
            textInputType: TextInputType.number,
            maxLength: 3,
            onChanged: (value) {
              controller.creditCard.update((val) {
                val?.cvvCode = value;
              });
            },
          ),
        ),
        const VerticalSpacing(10),
      ]),
    );
  }

  @override
  FutureOr<bool> validate() {
    return formKey.currentState!.validate();
  }
}
