import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/controllers/signup_controller.dart';
import 'package:conoce_bonao/models/province.dart';
import 'package:conoce_bonao/ui/auth/login/login_page.dart';
import 'package:conoce_bonao/widgets/buttons/custom_button.dart';
import 'package:conoce_bonao/widgets/textfield/custom_textfield.dart';
import 'package:conoce_bonao/widgets/textfield/form_field_list_search.dart';

import '../../../constants/repositories.dart';
import '../../../constants/theme.dart';
import '../../../utils/theme/colors.dart';
import '../../../widgets/horizontal_lined_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultVerticalSpacing),
        child: SingleChildScrollView(
          child: Form(
            key: signUpController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacing(topPadding),
                Text("Crear una cuenta", style: Theme.of(context).textTheme.headline5),
                const Text("Conecta con la mejor experiencia!"),
                const VerticalSpacing(defaultVerticalSpacing * 2),
                CustomTextField(
                  controller: signUpController.fullName,
                  label: "Nombre Completo",
                  hint: "Ej: Juan",
                ),
                const VerticalSpacing(),
                CustomTextField(
                  controller: signUpController.email,
                  textInputType: TextInputType.emailAddress,
                  label: "Correo electrónico",
                  hint: "Introduzca su correo",
                ),
                const VerticalSpacing(),
                CustomTextField(
                  controller: signUpController.phone,
                  textInputType: TextInputType.phone,
                  label: "Número telefónico",
                  hint: "Introduzca su número telefónico",
                ),
                const VerticalSpacing(),
                FutureBuilder<List<ProvinceModel>>(
                    future: provinceRepository.getProvinces(),
                    builder: (_, data) {
                      if (data.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator.adaptive());
                      }
                      return FormFieldListSearch(
                        label: "Provincia",
                        hint: "Seleccione la provincia",
                        controller: signUpController.province,
                        items: data.data!.map((e) => e.province).toList(),
                      );
                    }),
                const VerticalSpacing(),
                CustomTextField(
                  controller: signUpController.password,
                  textInputType: TextInputType.visiblePassword,
                  label: "Contraseña",
                  hint: "Introduzca su contraseña",
                ),
                const VerticalSpacing(defaultVerticalSpacing * 2),
                CustomButton(
                  text: "Crear Cuenta",
                  onPressed: signUpController.signUp,
                ),
                const VerticalSpacing(defaultVerticalSpacing * 2),
                const HorizontalLinedText(text: "O con"),
                const VerticalSpacing(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Tienes una cuenta?"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => Get.off(const LoginPage()),
                      child: Text(
                        "Iniciar sesion",
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: greenColor,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
