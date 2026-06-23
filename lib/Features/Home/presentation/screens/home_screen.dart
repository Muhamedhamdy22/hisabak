import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisabak/Features/Home/presentation/bloc/dashboard_bloc.dart';
import 'package:hisabak/Features/Home/presentation/bloc/dashboard_event.dart';
import 'package:hisabak/Features/Home/presentation/bloc/dashboard_state.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/di.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(GetDashboardEvent()),
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state.getDashboardStatus == RequestStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.getDashboardMessage ?? 'Something went wrong'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
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
            body: state.getDashboardStatus == RequestStatus.loading
                ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
                : _buildBody(context, state),
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
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, DashboardState state) {
    final dashboard = state.dashboard;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('Summary', style: AppTextStyles.titleLarge),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: 'Total Debt',
                  value: '${dashboard?.totalDebt?.toStringAsFixed(0) ?? 0} EGP',
                  color: AppColors.danger,
                  icon: Icons.trending_up_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  label: 'Payments',
                  value: '${dashboard?.totalPayment?.toStringAsFixed(0) ?? 0} EGP',
                  color: AppColors.success,
                  icon: Icons.trending_down_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: 'Remaining',
                  value: '${dashboard?.balance?.toStringAsFixed(0) ?? 0} EGP',
                  color: AppColors.primary,
                  icon: Icons.account_balance_wallet_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  label: 'Customers',
                  value: '${dashboard?.customersCount ?? 0}',
                  color: AppColors.gold,
                  icon: Icons.people_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: AppTextStyles.titleLarge.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.labelSmall),
        ],
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
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people),
          label: 'Customers',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}