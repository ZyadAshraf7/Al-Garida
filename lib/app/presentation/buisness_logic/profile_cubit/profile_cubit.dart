import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/data/models/user_model.dart';
import 'package:the_news/app/data/shared_preference/user_preference.dart';
import 'package:the_news/app/presentation/buisness_logic/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:uuid/uuid.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  UserModel? user;

  fetchProfileInformation() async {
    emit(ProfileLoading());
    try {
      final phoneNumber = await UserPreferences.getUserPhoneNumber();
      print(phoneNumber);
      CollectionReference collectionRef = FirebaseFirestore.instance.collection(
          "users");
      var snapshot = await collectionRef.doc(phoneNumber).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        user = UserModel.fromJson(userData);
        emit(ProfileLoadedSuccess());
      }
    }catch(e){
      print(e.toString());
      emit(ProfileFailed());
    }
  }

  Future<void>changeProfilePicture()async{
    final _picker = ImagePicker();
    PickedFile? _imageFile;

    try {
      // Get the image file from the user's phone storage
      print("h");
      _imageFile = await _picker.getImage(source: ImageSource.gallery);
      // Upload the image file to Firebase Storage
      emit(ProfileLoading());

      if(_imageFile!=null){
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("user_profile/${Uuid().v1()}.jpg");
        UploadTask uploadTask = ref.putFile(File(_imageFile!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.phoneNumber).update({
          'profilePictureUrl':downloadUrl
        }).then((value){
          user = fetchProfileInformation();
          emit(ChangeProfilePictureSuccess());
        });
      }else{
        emit(ProfileLoading());
        user = fetchProfileInformation();
        emit(ProfileLoadedSuccess());
      }
    }catch(e){
      print("loadig error");
      print(e.toString());
      emit(ChangeProfilePictureFailed());
    }
  }
}
