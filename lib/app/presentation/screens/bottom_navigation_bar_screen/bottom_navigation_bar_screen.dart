import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_news/app/presentation/screens/bottom_navigation_bar_screen/widgets/bottom_nav_icon.dart';

import '../../../core/theme/app_theme.dart';
import '../../buisness_logic/bottom_navigation_bar_cubit/bottom_nav_bar_cubit.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BlocProvider.of<BottomNavBarCubit>(context);
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: bottomNavBarCubit.screens[bottomNavBarCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 12,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            selectedItemColor: AppTheme.primaryBlue,
            unselectedItemColor: AppTheme.grey700,
            type: BottomNavigationBarType.fixed,
            onTap: bottomNavBarCubit.navigateScreens,
            currentIndex: bottomNavBarCubit.currentIndex,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'الرئيسية',
                icon: BottomNavIcon(
                  iconPath: 'assets/icons/home.svg',
                  isSelected: bottomNavBarCubit.currentIndex == 0,
                ),
              ),
              BottomNavigationBarItem(
                label: 'بحث',
                icon: BottomNavIcon(
                  iconPath: 'assets/icons/search.svg',
                  isSelected: bottomNavBarCubit.currentIndex == 1,
                ),
              ),
              BottomNavigationBarItem(
                label: 'الملف الشخصي',
                icon: BottomNavIcon(
                  iconPath: 'assets/icons/profile.svg',
                  isSelected: bottomNavBarCubit.currentIndex == 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
