import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/models/user.dart';

import '../../constants/firebase.dart';

class UserRepository {
  Future<Resource> updateUser(UserModel user) {
    return Resource.fromCallback(() async {
      final currentUserId = authController.firebaseUser.value?.uid;
      await firebaseFirestore.collection(userCollection).doc(currentUserId).set(
            user.toMap(),
          );
    });
  }
}
