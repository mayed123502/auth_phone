import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneProvider extends ChangeNotifier {
  late String verificationId;

  Future<void> submitPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+970$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    print("verificationCompleted");
    // await SignIn(phoneAuthCredential);
  }

  void verificationFailed(FirebaseAuthException error) {
    throw error;
  }

  void codeSent(String verificationId, int? forceResendingToken) async {
    print("codeSent");
    this.verificationId = verificationId;
  }

  void codeAutoRetrievalTimeout(String verificationId) {}

  Future<void> submitOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? users = await FirebaseAuth.instance.currentUser;

      print(users);

      if (users!.uid != "") {
        print(users.uid);
      }
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }



  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
