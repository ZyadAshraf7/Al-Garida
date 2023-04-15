import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pinput/pinput.dart';
import 'package:the_news/app/data/shared_preference/user_preference.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  String errorMessage = "";
  String verificationID = "";

  bool validatePhoneNumber(String phoneNumber) {
    String patttern = r'^\+20(10|11|12|15)[0-9]{8}$';
    RegExp regExp = RegExp(patttern);
    if (phoneNumber.isEmpty) {
      errorMessage = "برجاء إدخال رقم هاتف";
      emit(EmptyPhoneNumber());
      return false;
    } else if (!regExp.hasMatch(phoneNumber)) {
      errorMessage = "برجاء إدخال رقم هاتف صحيح";
      emit(InvalidPhoneNumber());
      return false;
    }
    return true;
  }

  String alterPhoneNumber(String phoneNumber) {
    if (phoneNumber[0] == "0") {
      phoneNumber = "+2${phoneNumber.substring(0)}";
    } else if (phoneNumber[0] == "1") {
      phoneNumber = "+20$phoneNumber";
    }
    print(phoneNumber);
    return phoneNumber;
  }

  Future<void> sendVerificationCode(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        emit(VerificationLoading());
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(VerificationSuccess());
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.toString());
        emit(VerificationFailed());
      },
      codeSent: (String verificationId, int? resendToken) async {
        // emit(VerificationLoading());
        verificationID = verificationId;
        // emit(VerificationSuccess());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID = verificationId;
      },
    );
  }

  Future<void> verityOTP(String otpCode) async {
    emit(VerificationLoading());
    UserCredential credential =
        await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otpCode),
    );
    if (credential.user != null) {
      String token = await credential.user!.getIdToken();
      // save user credentials
      UserPreferences.setUserToken(token);
      print("token" + token);
      UserPreferences.setUserId(credential.user!.uid);
      print("userId" + credential.user!.uid);
      UserPreferences.setUserPhoneNumber(credential.user!.phoneNumber!);
      print("phone number" + credential.user!.phoneNumber!);
      emit(VerificationSuccess());
    } else {
      emit(VerificationFailed());
    }
  }

  Future<bool>checkIfUserExist() async {
    print(
        "current user phone number ${FirebaseAuth.instance.currentUser?.phoneNumber}");
    var userExist = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
        .get();
    if (userExist.exists) {
      print("user exist !!");
      return true;
    } else {
      print("user NOT exist !!");
      return false;
    }
  }
}
