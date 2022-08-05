import 'package:conoce_bonao/constants/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/firebase.dart';
import 'package:conoce_bonao/models/user.dart';
import 'package:conoce_bonao/ui/home/home_page.dart';
import 'package:conoce_bonao/widgets/loading_widget.dart';

import '../constants/repositories.dart';

class AuthController extends GetxController {
  final firebaseUser = Rx<User?>(null);

  bool get isLoggedIn => firebaseUser.value != null;

  @override
  void onReady() {
    super.onReady();

    firebaseUser.value = firebaseAuth.currentUser;
    firebaseUser.bindStream(firebaseAuth.userChanges());
    _launchPage();
    ever(firebaseUser, (_) async {
      if (isLoggedIn) {
        userController.currentUser.bindStream(_listenUserChanges());
      } else {
        userController.currentUser.value = null;
        _launchPage();
      }
    });
    ever(userController.currentUser, (_) {
      _launchPage();
    });
  }

  _launchPage() {
    if (!userController.isUpdatingUser) {
      Get.offAll(() => const HomePage());
    }
  }

  logout() async {
    showLoading();
    await authRepository.signOut();
    hideLoading();
  }

  Stream<UserModel> _listenUserChanges() {
    return firebaseFirestore
        .collection(userCollection)
        .doc(firebaseUser.value!.uid)
        .snapshots(
          includeMetadataChanges: false,
        )
        .map(UserModel.fromSnapshot);
  }
}
