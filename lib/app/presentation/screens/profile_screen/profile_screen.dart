import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_news/app/core/constants/route_names.dart';
import 'package:the_news/app/presentation/buisness_logic/profile_cubit/profile_cubit.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/shared_preference/user_preference.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = BlocProvider.of<ProfileCubit>(context);
    profile.fetchProfileInformation();

    /*if (profile.user == null) {
      profile.fetchProfileInformation();
    }*/
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/error.png"),
                  SizedBox(height: 24),
                  Text(
                    "حدث خطأ أثناء الاتصال",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "برجاء المحاولة في وقت لاحق",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            );
          } else if (state is ProfileLoadedSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ).copyWith(bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                            width: 150,
                            height: 150,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppTheme.primaryBlue, width: 2),
                                borderRadius: BorderRadius.circular(80)),
                            child: state is ChangeProfilePictureLoading
                                ? CircularProgressIndicator()
                                : profile.user?.profilePictureUrl != null
                                    ? CircleAvatar(
                                        radius: 65,
                                        foregroundImage: NetworkImage(
                                            profile.user!.profilePictureUrl!),
                                      )
                                    : CircleAvatar(
                                        foregroundImage: profile.user?.gender ==
                                                "ذكر"
                                            ? AssetImage(
                                                "assets/images/maleAvatar.png")
                                            : AssetImage(
                                                "assets/images/femaleAvatar.png"),
                                      )),
                        Positioned(
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<ProfileCubit>(context)
                                  .changeProfilePicture();
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
                  ),
                  Center(
                      child: Text(
                    profile.user!.fullName!,
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                  SizedBox(height: 50),
                  ListTile(
                    onTap: () {
                      /* Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => EditProfileInfoScreen(user: profile.user!,)));*/
                    },
                    leading: SvgPicture.asset(
                      "assets/icons/edit.svg",
                      color: AppTheme.grey800,
                    ),
                    title: Text(
                      "البيانات الشخصية",
                      style: TextStyle(
                          color: AppTheme.grey800, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("تعديل البيانات الشخصية مثل الاسم و الجنس"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.bookmarkedArticlesScreen);
                    },
                    leading: SvgPicture.asset(
                      "assets/icons/bookmark.svg",
                      color: AppTheme.grey800,
                    ),
                    title: Text(
                      "الأخبار المحفوظة",
                      style: TextStyle(
                          color: AppTheme.grey800, fontWeight: FontWeight.w600),
                    ),
                    subtitle:
                        Text("يمكن قراءة الأخبار التي قمت بحفظها هنا مرة أخرى"),
                  ),
                  ListTile(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                      UserPreferences.setUserToken('');
                      Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.loginScreen,(x){return false;});
                    },
                    leading: SvgPicture.asset(
                      "assets/icons/logout.svg",
                      color: AppTheme.error,
                    ),
                    title: Text(
                      "تسجيل الخروج",
                      style: TextStyle(
                          color: AppTheme.error, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
