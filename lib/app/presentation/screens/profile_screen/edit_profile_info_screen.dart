import 'package:flutter/material.dart';
import 'package:the_news/app/data/models/user_model.dart';

class EditProfileInfoScreen extends StatelessWidget {
  const EditProfileInfoScreen({Key? key,required this.user}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ],
        ),
      ),
    );
  }
}
