import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/ui/auth/signup/signup_page.dart';
import 'package:conoce_bonao/ui/home/home_page.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';
import 'package:conoce_bonao/widgets/custom_button.dart';
import 'package:conoce_bonao/widgets/custom_textfield.dart';
import 'package:conoce_bonao/widgets/horizontal_lined_text.dart';

import '../../../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          Get.off(const HomePage());
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultVerticalSpacing),
        child: SingleChildScrollView(
          child: Form(
            key: loginController.formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const VerticalSpacing(topPadding),
                  Text("Hi, Wecome Back! 👋", style: textTheme.headline5),
                  const Text("Hello again, you’ve been missed!"),
                  const VerticalSpacing(),
                  CustomTextField(
                    controller: loginController.email,
                    textInputType: TextInputType.emailAddress,
                    label: "Correo",
                    hint: "Introduzca su Correo",
                  ),
                  const VerticalSpacing(),
                  CustomTextField(
                    controller: loginController.password,
                    textInputType: TextInputType.visiblePassword,
                    label: "Contraseña",
                    hint: "Introduzca su Contraseña",
                  ),
                  const VerticalSpacing(defaultVerticalSpacing * 1.5),
                  CustomButton(
                    text: "Entrar",
                    onPressed: loginController.login,
                  ),
                  const VerticalSpacing(defaultVerticalSpacing * 1.5),
                  const HorizontalLinedText(text: "O con"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No tienes cuenta?"),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Get.to(const SignUpPage()),
                        child: Text(
                          "Crea una",
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
      ),
    );
  }
}
