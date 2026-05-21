import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/routes_manager/route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          AppConstants.appName,
          style: TextStyle(
            color: AppColors.surface,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.surface),
            onPressed: () =>
                Navigator.pushNamed(context, Routes.settingsRoute),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Hisabak!\nStart by adding your first customer.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.addCustomer),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add_outlined, color: AppColors.surface),
        label: const Text(
          'New Customer',
          style: TextStyle(
            color: AppColors.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 0),
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.surface,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        if (i == 0) Navigator.pushReplacementNamed(context, Routes.homeRoute);
        if (i == 1) Navigator.pushReplacementNamed(context, Routes.customersRoute);
        if (i == 2) Navigator.pushReplacementNamed(context, Routes.settingsRoute);
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Customers'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings'),
      ],
    );
  }
}