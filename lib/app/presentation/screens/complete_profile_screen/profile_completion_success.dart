import 'package:flutter/material.dart';
import 'package:the_news/app/core/constants/route_names.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/presentation/widgets/custom_button.dart';

class ProfileCompletionSuccessScreen extends StatelessWidget {
  const ProfileCompletionSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/profileSuccess.png"),
              const SizedBox(height: 24),
              Text(
                "حسابك جاهز للاستخدام",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                "الآن يمكنك استكشاف آخر الأخبار",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.grey500,
                    ),
              ),
              const SizedBox(height: 40),
              CustomButton(title: "تصفح الصفحة الرئيسية", hasColor: true, onTap: (){
                Navigator.of(context).pushReplacementNamed(RouteNames.bottomNavBarScreen);
              }, titleColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
