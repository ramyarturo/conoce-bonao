import 'package:auto_size_text/auto_size_text.dart';
import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/controllers/user_controller.dart';
import 'package:conoce_bonao/gen/assets.gen.dart';
import 'package:conoce_bonao/models/user.dart';
import 'package:conoce_bonao/ui/auth/login/login_page.dart';
import 'package:conoce_bonao/ui/profile/add_balance_page.dart';
import 'package:conoce_bonao/ui/profile/components/logout_button.dart';
import 'package:conoce_bonao/ui/profile/components/quick_actions_button.dart';
import 'package:conoce_bonao/ui/profile/myreservations/my_reservations_page.dart';
import 'package:conoce_bonao/utils/format_utils.dart';
import 'package:conoce_bonao/utils/intent_utils.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';
import 'package:conoce_bonao/widgets/animated_number.dart';
import 'package:conoce_bonao/widgets/buttons/custom_button.dart';
import 'package:conoce_bonao/widgets/rounded_card_image.dart';
import 'package:conoce_bonao/widgets/rx_value_listeneable.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';
import 'components/reload_balance.dart';
import 'components/section_history.dart';
import 'components/user_balance.dart';
import 'components/user_info.dart';
import 'components/user_tags.dart';
import 'components/user_visits.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userProfileUrl =
      "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80";
  @override
  Widget build(BuildContext context) {
    if (!authController.isLoggedIn) {
      return const _RequiredLoggedInMessage();
    }
    final Size size = MediaQuery.of(context).size;
    final UserModel userModel = userController.currentUser.value!;
    final tags = [
      "Biajera",
      "RD",
      "Bonao",
      "Experencias",
      "Diversión",
      "Verano",
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedCardImage(
                    size: Size.square(size.width * 0.3),
                    borderRadius: BorderRadius.circular(size.width * 0.3),
                    image: userProfileUrl,
                  ),
                  const Expanded(child: UserVisits()),
                  const Expanded(child: UserBalance())
                ],
              ),
              const VerticalSpacing(),
              Text(
                userModel.fullName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              UserInfo(userModel: userModel),
              const VerticalSpacing(),
              UserTags(tags: tags),
              const ReloadBalance(),
              const Divider(
                color: Color(0xfff2f2f2),
                height: 10,
                thickness: 9,
              ),
              const VerticalSpacing(),
              const QuickActionsButton(),
              const VerticalSpacing(),
              const Divider(
                color: Color(0xfff2f2f2),
                height: 10,
                thickness: 9,
              ),
              const SectionHistory(),
              const Align(
                alignment: Alignment.bottomRight,
                child: LogoutButton(),
              )
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
