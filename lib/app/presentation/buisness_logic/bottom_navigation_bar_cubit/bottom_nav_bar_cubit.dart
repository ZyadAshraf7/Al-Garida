import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:the_news/app/presentation/screens/home_screen/home_screen.dart';

import '../../screens/profile_screen/profile_screen.dart';
import '../../screens/search_screen/search_screen.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  int currentIndex=0;

  List <Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),

  ];
  void navigateScreens(int index){
    currentIndex=index;
    emit(NavBarChangeScreenState());
  }

}
