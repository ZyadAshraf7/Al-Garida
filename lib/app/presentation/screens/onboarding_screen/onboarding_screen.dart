import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_news/app/presentation/widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(child: Image.asset("assets/images/onboarding.png")),
                  Container(
                    width: 315,
                    height: 350,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(1),
                            Colors.white.withOpacity(0.1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                  Positioned(
                    // bottom: -30,
                    child: SvgPicture.asset("assets/icons/logo.svg"),
                  )
                ],
              ),
              Text(
                "مرحباً بك",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(
                width: 200,
                child: Text(
                  "استمتع بتجربة قراءة آخر الأخبار من جميع أنحاء العالم",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onTap: () {},
                title: "إنشاء حساب",
                hasColor: true,
                titleColor: Colors.white,
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: "لديك حساب",
                onTap: () {},
                hasColor: false,
                titleColor: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
