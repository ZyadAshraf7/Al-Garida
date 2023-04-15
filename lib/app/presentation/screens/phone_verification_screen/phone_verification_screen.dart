import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:the_news/app/core/constants/route_names.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/presentation/widgets/custom_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../buisness_logic/authentication_cubit/authentication_cubit.dart';

class PhoneVerificationScreen extends StatelessWidget {
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthenticationCubit>(context);

    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              Text(
                "تحقق من هاتفك",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.grey800, fontWeight: FontWeight.w700),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  "لقد أرسلنا اليك رسالة بها الكود التعريفي لرقم\n${authCubit.phoneNumberController.text}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.grey600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              SvgPicture.asset("assets/icons/emailVerify.svg"),
              const SizedBox(height: 52),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  // androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                  //autofocus: true,
                  onSubmitted: (val) {
                    authCubit.verityOTP(authCubit.pinController.text);
                  },
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                        fontSize: 24,
                        color: AppTheme.grey800,
                        fontWeight: FontWeight.w700),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppTheme.primaryBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  controller: authCubit.pinController,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "الكود ينتهي في خلال:  ",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.grey500,
                        ),
                  ),
                  Countdown(
                    seconds: 99,
                    build: (BuildContext context, double time) => Text(
                      time.toString(),
                      style: const TextStyle(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.w600),
                    ),
                    interval: const Duration(seconds: 1),
                    onFinished: () {
                      print('Timer is done!');
                    },
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "لم تصلك رسالة ؟ ",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppTheme.grey500,
                        ),
                  ),
                  const Text(
                    "إعادة إرسال",
                    style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  if (state is VerificationLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      CustomButton(
                        title: "تأكيد",
                        onTap: () async {
                          await authCubit.verityOTP(authCubit.pinController.text);
                          bool userExist = await authCubit.checkIfUserExist();
                          if (userExist) {
                            Navigator.of(context).pushReplacementNamed(
                              RouteNames.bottomNavBarScreen,
                            );
                          } else {
                            Navigator.of(context).pushReplacementNamed(
                              RouteNames.completeProfileScreen,
                            );
                          }
                        },
                        hasColor: true,
                        titleColor: Colors.white,
                      ),
                      if (state is VerificationFailed)
                        Text(
                            "حدث خطأ اثنناءالتعريف\nبرجاء المحاولة في وقت لاحق",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppTheme.error))
                      else
                        SizedBox()
                    ],
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
