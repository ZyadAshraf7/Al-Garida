import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_news/app/core/constants/route_names.dart';
import 'package:the_news/app/core/theme/app_theme.dart';
import 'package:the_news/app/presentation/buisness_logic/authentication_cubit/authentication_cubit.dart';
import 'package:the_news/app/presentation/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthenticationCubit>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/logo.svg"),
              Text(
                "الجريدة",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                "برجاء تسجيل الدخول",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppTheme.grey600),
              ),
              const SizedBox(height: 24),
              TextFormField(
                //textDirection: TextDirection.ltr,
                controller: authCubit.phoneNumberController,
                style: const TextStyle(color: AppTheme.grey700),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "مثال: 0105xxxxxxx",
                  prefixIcon: Icon(Icons.phone_enabled),
                ),
              ),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  if (state is InvalidPhoneNumber ||
                      state is EmptyPhoneNumber) {
                    return Text(authCubit.errorMessage, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppTheme.error)
                    );
                  }else{
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  final formattedPhoneNumber = authCubit.alterPhoneNumber(authCubit.phoneNumberController.text);
                  authCubit.phoneNumberController.text = formattedPhoneNumber;
                  bool isValid = authCubit.validatePhoneNumber(
                      formattedPhoneNumber);
                  if (isValid) {
                    authCubit.sendVerificationCode(authCubit.phoneNumberController.text);
                    Navigator.of(context).pushNamed(RouteNames.phoneVerificationScreen);
                  } else {}
                },
                titleColor: Colors.white,
                hasColor: true,
                title: 'تسجيل الدخول',
              )
            ],
          ),
        ),
      ),
    );
  }
}
