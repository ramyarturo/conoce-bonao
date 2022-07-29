import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/models/user.dart';
import 'package:conoce_bonao/ui/auth/login/login_page.dart';
import 'package:conoce_bonao/widgets/custom_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (!authController.isLoggedIn) {
      return const _RequiredLoggedInMessage();
    }
    final Size size = MediaQuery.of(context).size;
    final UserModel userModel = authController.userModel.value!;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(topPadding),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: size.width * 0.1,
                child: Icon(
                  Icons.person,
                  size: size.width * 0.12,
                ),
              ),
              const VerticalSpacing(),
              CustomTextField(
                initialValue: userModel.fullName,
                label: "Nombre completo",
                textInputType: TextInputType.none,
              ),
              const VerticalSpacing(),
              CustomTextField(
                initialValue: userModel.email,
                label: "Correo electrónico",
                textInputType: TextInputType.none,
              ),
              const VerticalSpacing(),
              CustomTextField(
                initialValue: userModel.phone,
                label: "Número de teléfono",
                textInputType: TextInputType.none,
              ),
              const VerticalSpacing(),
              CustomTextField(
                initialValue: userModel.province,
                label: "Provincia",
                textInputType: TextInputType.none,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequiredLoggedInMessage extends StatelessWidget {
  const _RequiredLoggedInMessage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Debe estar logueado para ingresar a su Perfil"),
          OutlinedButton(
            child: const Text("Iniciar sesión"),
            onPressed: () => Get.to(const LoginPage()),
          )
        ],
      ),
    );
  }
}
