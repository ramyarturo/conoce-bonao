import 'package:conoce_bonao/core/result.dart';
import 'package:conoce_bonao/core/status.dart';
import 'package:conoce_bonao/models/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../constants/theme.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/theme/colors.dart';
import '../../widgets/textfield/custom_textfield.dart';

class AddBalancePage extends StatefulWidget {
  const AddBalancePage({super.key});

  @override
  State<AddBalancePage> createState() => _AddBalancePageState();
}

class _AddBalancePageState extends State<AddBalancePage> {
  var showBackView = false;

  final formKey = GlobalKey<FormState>();
  final balance = TextEditingController();
  final creditCard = CreditCard().obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Agregar saldo a su cuenta"),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: blackColor,
          ),
          onPressed: () => Get.back(),
        ),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showBackView = !showBackView;
                    });
                  },
                  child: Obx(() => CreditCardWidget(
                        cardNumber: creditCard.value.cardNumber,
                        expiryDate: creditCard.value.expiryDate,
                        cardHolderName: creditCard.value.cardHolderName,
                        isHolderNameVisible: true,
                        cvvCode: creditCard.value.cvvCode,
                        showBackView: showBackView,
                        labelCardHolder: "Nombre en la tarjeta",
                        onCreditCardWidgetChange: (creditCard) {},
                      )),
                ),
                CustomTextField(
                    hint: "Nombre",
                    onChanged: (value) => creditCard.update((val) {
                          val?.cardHolderName = value;
                        })),
                const VerticalSpacing(10),
                CustomTextField(
                    hint: "Número",
                    textInputType: TextInputType.number,
                    maxLength: 17,
                    onChanged: (value) => creditCard.update((val) {
                          val?.cardNumber = value;
                        })),
                const VerticalSpacing(10),
                Obx(() => CustomTextField(
                      hint: "Fecha",
                      textInputType: TextInputType.none,
                      initialValue: creditCard.value.expiryDate,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add((365 * 10).days),
                        ).then((value) {
                          if (value != null) {
                            creditCard.update((val) {
                              val?.expiryDate = "${value.month}/${value.year.toString().substring(2, 4)}";
                            });
                          }
                        });
                      },
                      onChanged: (value) {
                        creditCard.update((val) {
                          val?.expiryDate = value;
                        });
                      },
                    )),
                const VerticalSpacing(10),
                SizedBox(
                  width: 100,
                  child: CustomTextField(
                    hint: "CVV",
                    textInputType: TextInputType.number,
                    maxLength: 3,
                    onChanged: (value) {
                      creditCard.update((val) {
                        val?.cvvCode = value;
                      });
                    },
                  ),
                ),
                const VerticalSpacing(10),
                Text(
                  "Saldo a agregar",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const VerticalSpacing(10),
                TextFormField(
                  controller: balance,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo requerido";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "RD 0.00",
                    border: OutlineInputBorder(),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: const Text("Agregar"),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        DialogUtils.showLoadingDialog(message: "Actualizando balance...");
                        await userController.updateUserBalance(double.tryParse(balance.text) ?? 0.0);
                        DialogUtils.hideLoadingDialog();

                        Get.back(result: Result.ok);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
