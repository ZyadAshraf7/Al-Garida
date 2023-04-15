import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_news/app/presentation/screens/home_screen/home_screen.dart';
import 'package:the_news/app/presentation/screens/onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        splash: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("الجريدة",style: Theme.of(context).textTheme.displaySmall,),
            const SizedBox(width: 10),
            SvgPicture.asset("assets/icons/logo.svg")
          ],
        ),
        nextScreen: const OnBoardingScreen(),
        //splashTransition: SplashTransition.slideTransition,
        // pageTransitionType: PageTransition,
      ),
    );
  }
}
