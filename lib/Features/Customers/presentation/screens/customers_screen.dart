import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisabak/Features/add_customer/presentation/bloc/customar_events.dart';
import 'package:hisabak/Features/add_customer/presentation/bloc/customar_state.dart';
import 'package:hisabak/Features/add_customer/presentation/bloc/customer_bloc.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/di.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CustomersBloc>()..add(GetCustomersEvent()),
      child: Scaffold(
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
            Expanded(
              child: BlocBuilder<CustomersBloc, CustomersState>(
                builder: (context, state) {
                  if (state.getCustomersStatus == RequestStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }
                  if (state.getCustomersStatus == RequestStatus.error) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              color: AppColors.danger, size: 48),
                          const SizedBox(height: 12),
                          Text(
                            state.getCustomersMessage ?? 'Something went wrong',
                            style: AppTextStyles.bodyMedium,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => context
                                .read<CustomersBloc>()
                                .add(GetCustomersEvent()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state.filteredCustomers.isEmpty) {
                    return const _EmptyState();
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(AppConstants.spaceMd),
                    itemCount: state.filteredCustomers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) =>
                        _CustomerCard(customer: state.filteredCustomers[i]),
                  );
                },
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
      ),
    );
  }

  Widget _buildSearchBar() {
    return Builder(
      builder: (context) => Container(
        color: AppColors.primary,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: TextFormField(
          onChanged: (v) => context
              .read<CustomersBloc>()
              .add(SearchCustomersEvent(query: v)),
          style: AppTextStyles.bodyLarge,
          decoration: InputDecoration(
            hintText: 'Search customer...',
            hintStyle: AppTextStyles.bodyMedium,
            prefixIcon: const Icon(Icons.search,
                color: AppColors.textSecondary, size: 20),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
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

class _CustomerCard extends StatelessWidget {
  final dynamic customer;
  const _CustomerCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.customerDetail,
        arguments: customer.id,
      ),
      borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spaceMd),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                customer.name?[0] ?? '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.name ?? '', style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 2),
                  Text(customer.phone ?? '', style: AppTextStyles.labelSmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline,
              size: 64, color: AppColors.textSecondary.withOpacity(0.4)),
          const SizedBox(height: 16),
          const Text('No customers yet', style: AppTextStyles.titleLarge),
          const SizedBox(height: 8),
          const Text('Tap + to add a customer', style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}