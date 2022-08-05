import 'dart:async';

import 'package:flutter/material.dart';
import 'package:conoce_bonao/ui/reservation/steps/base_step.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentStep extends StatefulWidget {
  const PaymentStep({super.key});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends BaseStep<PaymentStep> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CreditCardWidget(
        cardNumber: "",
        expiryDate: "",
        cardHolderName: "",
        isHolderNameVisible: true,
        cvvCode: "",
        showBackView: false,
        labelCardHolder: "Nombre",
        onCreditCardWidgetChange: (creditCard) {},
      ),
    );
  }
}
