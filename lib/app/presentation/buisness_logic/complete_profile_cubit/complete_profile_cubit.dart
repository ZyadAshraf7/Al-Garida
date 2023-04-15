import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  String gender = "الجنس";
  String? downloadUrl;
  bool userExist = false;
  bool verifyProfileCompletion(
      String firstName, String lastName, String? gender) {
    if (firstName.isEmpty || lastName.isEmpty || gender == "الجنس") {
      emit(IncompleteInformation());
      return false;
    } else {
      emit(ProfileInfoCompleted());
      return true;
    }
  }

  modifyGender() {
    emit(ModifyGender());
  }

  uploadProfilePicture() async {
    emit(FetchProfilePhotoLoading());
    final _picker = ImagePicker();
    PickedFile? _imageFile;
    String? _uploadedFileURL;

    try {
      // Get the image file from the user's phone storage
      _imageFile = await _picker.getImage(source: ImageSource.gallery);
      // Upload the image file to Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("user_profile/${Uuid().v1()}.jpg");
      UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
      emit(FetchProfilePhotoSuccess());
    } catch (e) {
      print(e.toString());
      emit(FetchProfilePhotoFailed());
    }
  }

  uploadProfileToFirestore(UserModel userModel) async {
    emit(UploadProfileLoading());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
          .set(userModel.toJson(), SetOptions(merge: true));
      emit(UploadProfileSuccess());
    } catch (e) {
      print(e.toString());
      emit(UploadProfileFailed());
    }
  }

}
