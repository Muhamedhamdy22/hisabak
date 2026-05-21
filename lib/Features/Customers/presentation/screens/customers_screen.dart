import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/routes_manager/route.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Customers',
          style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined, color: AppColors.surface),
            onPressed: () => Navigator.pushNamed(context, Routes.addCustomer),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          const Expanded(
            child: Center(
              child: Text('TODO: BlocBuilder هنا', style: AppTextStyles.bodyMedium),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.addCustomer),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.surface),
      ),
      bottomNavigationBar: _buildBottomNav(context, 1),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: TextFormField(
        style: AppTextStyles.bodyLarge,
        onChanged: (v) {
          // TODO: add search event
        },
        decoration: InputDecoration(
          hintText: 'Search customer...',
          hintStyle: AppTextStyles.bodyMedium,
          prefixIcon:
          const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
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
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Customers'),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}