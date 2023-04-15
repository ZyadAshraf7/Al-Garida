import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_news/app_router.dart';

import 'app/data/shared_preference/shared_preference.dart';
import 'firebase_options.dart';
import 'the_news.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(TheNews(appRouter: AppRouter(),));
}
