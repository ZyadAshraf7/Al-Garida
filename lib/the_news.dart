import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_news/app/data/repositories/base_news_repository.dart';
import 'package:the_news/app/data/repositories/search_artcile_repository.dart';
import 'package:the_news/app/data/shared_preference/user_preference.dart';
import 'package:the_news/app/presentation/buisness_logic/article_details_cubit/article_details_cubit.dart';
import 'package:the_news/app/presentation/buisness_logic/profile_cubit/profile_cubit.dart';
import 'package:the_news/app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:toast/toast.dart';

import 'app/core/constants/route_names.dart';
import 'app/core/theme/app_theme.dart';
import 'app/presentation/buisness_logic/all_news_cubit/all_news_cubit.dart';
import 'app/presentation/buisness_logic/authentication_cubit/authentication_cubit.dart';
import 'app/presentation/buisness_logic/bottom_navigation_bar_cubit/bottom_nav_bar_cubit.dart';
import 'app/presentation/buisness_logic/buisness_news_cubit/buisness_news_cubit.dart';
import 'app/presentation/buisness_logic/complete_profile_cubit/complete_profile_cubit.dart';
import 'app/presentation/buisness_logic/health_news_cubit/health_news_cubit.dart';
import 'app/presentation/buisness_logic/search_article_cubit/search_article_cubit.dart';
import 'app/presentation/buisness_logic/sports_news_cubit/sports_news_cubit.dart';
import 'app/presentation/buisness_logic/technology_news_cubit/technology_news_cubit.dart';
import 'app/presentation/screens/bottom_navigation_bar_screen/bottom_navigation_bar_screen.dart';
import 'app/presentation/screens/search_screen/search_screen.dart';
import 'app_router.dart';

class TheNews extends StatelessWidget {
  final AppRouter? appRouter;
  final String? initialRoute;

  const TheNews({Key? key, required this.appRouter, this.initialRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider(
          create: (_) => BottomNavBarCubit(),
          child: const BottomNavigationBarScreen(),
        ),
        BlocProvider(
          create: (context) =>
          AllNewsCubit(newsRepository: BaseNewsRepository())
            ..fetchAllNews(),
        ),
        BlocProvider(
          create: (context) =>
          SportsNewsCubit(baseNewsRepository: BaseNewsRepository())
            ..fetchSportsNews(),
        ),
        BlocProvider(
          create: (context) =>
          TechnologyNewsCubit(baseNewsRepository: BaseNewsRepository())
            ..fetchTechnolgyNews(),
        ),
        BlocProvider(
          create: (context) =>
          BuisnessNewsCubit(baseNewsRepository: BaseNewsRepository())
            ..fetchBuisnessNews(),
        ),
        BlocProvider(
          create: (context) =>
          HealthNewsCubit(baseNewsRepository: BaseNewsRepository())
            ..fetchHealthNews(),
        ),
        BlocProvider(
          create: (context) => SearchArticleCubit(searchArticleRepository: SearchArticleRepository()),
          child: const SearchScreen(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
          child: const ProfileScreen(),
        ),
        BlocProvider(
          create: (context) => CompleteProfileCubit(),
          // child: const CompleteProfileScreen(),
        ),
        BlocProvider(
          create: (context) => ArticleDetailsCubit(),
          // child: const CompleteProfileScreen(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("ar", "EG"), // OR Locale('ar', 'AE') OR Other RTL locales
            ],
            locale: const Locale("ar", "EG"),
            // OR Locale('ar', 'AE') OR Other RTL locales,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appLightMode,
            darkTheme: AppTheme.appDarkMode,
            themeMode: ThemeMode.light,
            onGenerateRoute: appRouter!.onGenerateRoutes,
            initialRoute: /*RouteNames.completeProfileScreen*/UserPreferences.getUserToken() != ''
                ? RouteNames.bottomNavBarScreen
                : RouteNames.loginScreen
        ),
      ),
    );
  }
}
