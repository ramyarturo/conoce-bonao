import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/theme.dart';
import '../../utils/theme/colors.dart';

class AddBalancePage extends StatelessWidget {
  final void Function(double value)? onChanged;

  AddBalancePage({super.key, this.onChanged});
  final formKey = GlobalKey<FormState>();
  final balance = TextEditingController();
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
          child: Column(
            children: [
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
                  labelText: "Saldo",
                  border: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    child: const Text("Agregar"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                         
                        Get.back(result: double.tryParse(balance.text) ?? 0.0);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
