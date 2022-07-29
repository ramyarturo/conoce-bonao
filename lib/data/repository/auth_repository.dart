import 'package:firebase_auth/firebase_auth.dart';
import 'package:conoce_bonao/core/resource.dart';
import 'package:conoce_bonao/models/user.dart';
import 'package:conoce_bonao/utils/exts/list_exts.dart';

import '../../constants/firebase.dart';

class AuthRepository {
  Future<Resource> signUp(UserModel userModel) async {
    final result = await Resource.fromCallback(() async {
      return firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
    }, errorParser: parseAuthFirebaseException);
    if (result.isSuccessful) {
      final userId = result.data!.user?.uid;
      await firebaseFirestore.collection(userCollection).doc(userId).set(
            userModel.toMap(),
          );
    }

    return result;
  }

  Future<Resource<UserCredential>> login({required String email, required String password}) async {
    final result = await Resource.fromCallback(() async {
      return firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }, errorParser: parseAuthFirebaseException);
    return result;
  }

  signOut() async {
    firebaseAuth.signOut();
  }
}

String parseAuthFirebaseException(FirebaseException exception) {
  final errorsMap = {
    ["user-not-found", "wrong-password"]: "Usuario o Contraseña incorrecta",
    ["email-already-in-use"]: "Correo electrónico en uso",
    ["invalid-email"]: "Correo electrónico no válido",
    ["weak-password"]: "Contraseña debe contener al menos 6 caracteres"
  };
  return errorsMap.entries.firstOrNull((element) {
        return element.key.contains(exception.code);
      })?.value ??
      "Ha ocurrido un error inesperado";
}
