import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_news/app/core/constants/route_names.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/data/models/user_model.dart';
import 'package:the_news/app/presentation/buisness_logic/authentication_cubit/authentication_cubit.dart';
import 'package:the_news/app/presentation/buisness_logic/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:the_news/app/presentation/widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completeProfileCubit = BlocProvider.of<CompleteProfileCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<CompleteProfileCubit, CompleteProfileState>(
        listener: (context, state) {
          if (state is IncompleteInformation) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                padding: EdgeInsets.all(8),
                backgroundColor: AppTheme.error,
                content: Text(
                  "برجاء إكمال البيانات",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                )));
          } else if (state is UploadProfileSuccess) {
              Navigator.of(context).pushReplacementNamed(
                RouteNames.profileCompletionSuccessScreen,
              );
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppTheme.primaryBlue, width: 2),
                          borderRadius: BorderRadius.circular(80)),
                      child: BlocBuilder<CompleteProfileCubit,
                          CompleteProfileState>(
                        builder: (context, state) {
                          if (state is FetchProfilePhotoLoading) {
                            return const CircularProgressIndicator();
                          }
                          return GestureDetector(
                            onTap: () {
                              completeProfileCubit.uploadProfilePicture();
                            },
                            child: completeProfileCubit.downloadUrl != null
                                ? CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        completeProfileCubit.downloadUrl!),
                                    radius: 65,
                                  )
                                : CircleAvatar(
                                    foregroundImage: AssetImage(
                                        completeProfileCubit.gender == "أنثى"
                                            ? "assets/images/femaleAvatar.png"
                                            : "assets/images/maleAvatar.png"),
                                    radius: 65,
                                  ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          completeProfileCubit.uploadProfilePicture();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/upload.svg",
                          fit: BoxFit.scaleDown,
                          width: 40,
                          height: 40,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 70),
                TextFormField(
                  controller: completeProfileCubit.firstNameController,
                  style: const TextStyle(color: AppTheme.grey700),
                  decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/profile.svg",
                      color: AppTheme.grey600,
                      allowDrawingOutsideViewBox: false,
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "الأسم الأول",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: AppTheme.grey700),
                  controller: completeProfileCubit.lasttNameController,
                  decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/profile.svg",
                      color: AppTheme.grey600,
                      allowDrawingOutsideViewBox: false,
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "الأسم الأخير",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: FirebaseAuth.instance.currentUser?.phoneNumber,
                      hintStyle: const TextStyle(color: AppTheme.grey700),
                      prefixIcon: const Icon(
                        Icons.phone_enabled,
                        color: AppTheme.grey600,
                      )),
                ),
                BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                  builder: (context, state) {
                    return DropdownButton<String>(
                      // value: completeProfileCubit.gender,
                      isExpanded: true,
                      itemHeight: 50,
                      elevation: 2,
                      hint: Row(
                        children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(
                            "assets/icons/gender.svg",
                            color: AppTheme.grey600,
                          ),
                          SizedBox(width: 12),
                          Text(completeProfileCubit.gender),
                        ],
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "male",
                          child: Text(
                            "ذكر",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.grey700),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "female",
                          child: Text(
                            "أنثى",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.grey700),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == "male") {
                          completeProfileCubit.gender = "ذكر";
                        } else if (value == "female") {
                          completeProfileCubit.gender = "أنثى";
                        }
                        completeProfileCubit.modifyGender();
                      },
                    );
                  },
                ),
                SizedBox(height: 40),
                BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                  builder: (context, state) {
                    if (state is UploadProfileLoading) {
                      return const CircularProgressIndicator();
                    }
                    return CustomButton(
                      title: "حفظ",
                      hasColor: true,
                      onTap: () {
                        final isInfoCompleted =
                            completeProfileCubit.verifyProfileCompletion(
                                completeProfileCubit.firstNameController.text,
                                completeProfileCubit.lasttNameController.text,
                                completeProfileCubit.gender);
                        if (isInfoCompleted) {
                          UserModel userModel = UserModel(
                            userId: FirebaseAuth.instance.currentUser?.uid,
                            bookmarks: [],
                            fullName:
                                "${completeProfileCubit.firstNameController.text} ${completeProfileCubit.lasttNameController.text}",
                            gender: completeProfileCubit.gender,
                            phoneNumber:
                                FirebaseAuth.instance.currentUser?.phoneNumber,
                            profilePictureUrl: completeProfileCubit.downloadUrl,
                          );
                          completeProfileCubit
                              .uploadProfileToFirestore(userModel);
                        }
                      },
                      titleColor: Colors.white,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
