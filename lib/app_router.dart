import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';
import 'package:the_news/app/presentation/buisness_logic/complete_profile_cubit/complete_profile_cubit.dart';
import 'package:the_news/app/presentation/screens/bookmarked_articles_screen/bookmarked_articles_screen.dart';
import 'package:the_news/app/presentation/screens/complete_profile_screen/complete_profile_screen.dart';
import 'package:the_news/app/presentation/screens/complete_profile_screen/profile_completion_success.dart';
import 'package:the_news/app/presentation/screens/login_screen/login_screen.dart';
import 'package:the_news/app/presentation/screens/phone_verification_screen/phone_verification_screen.dart';
import 'package:the_news/app/presentation/screens/splash_screen/splash_screen.dart';

import 'app/core/constants/route_names.dart';
import 'app/presentation/buisness_logic/bookmarked_articles_cubit/bookmarked_articles_cubit.dart';
import 'app/presentation/screens/bottom_navigation_bar_screen/bottom_navigation_bar_screen.dart';
import 'app/presentation/screens/home_screen/home_screen.dart';
import 'app/presentation/screens/register_screen/register_screen.dart';

class AppRouter {
  late BaseNewsRepository newsRepository;

  void initAppSettings() {
    newsRepository = BaseNewsRepository();
  }

  Route? onGenerateRoutes(RouteSettings settings) {
    initAppSettings();
    switch (settings.name) {
      case RouteNames.bottomNavBarScreen:
        return MaterialPageRoute(builder: (_) => BottomNavigationBarScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteNames.phoneVerificationScreen:
        return MaterialPageRoute(
          builder: (_) => const PhoneVerificationScreen(),
        );
      case RouteNames.completeProfileScreen:
        return MaterialPageRoute(
          builder: (_) => CompleteProfileScreen(),
        );
      case RouteNames.profileCompletionSuccessScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfileCompletionSuccessScreen(),
        );
      case RouteNames.bookmarkedArticlesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BookmarkedArticlesCubit()..fetchBookMarkedArticles(),
            child: BookmarkedArtilclesScreen(),
          ),
        );
    }

    return null;
  }
}
