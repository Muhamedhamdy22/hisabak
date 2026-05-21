import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/routes_manager/route.dart';

class CustomerDetailScreen extends StatelessWidget {
  final int customerId;
  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.spaceMd),
                child: Text('TODO: BlocBuilder هنا', style: AppTextStyles.bodyMedium),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'debt',
            onPressed: () => Navigator.pushNamed(
                context, Routes.addTransaction,
                arguments: customerId),
            backgroundColor: AppColors.danger,
            icon: const Icon(Icons.add, color: AppColors.surface),
            label: const Text('Add Debt',
                style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'payment',
            onPressed: () => Navigator.pushNamed(
                context, Routes.addTransaction,
                arguments: customerId),
            backgroundColor: AppColors.success,
            icon: const Icon(Icons.check, color: AppColors.surface),
            label: const Text('Add Payment',
                style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.surface),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_outlined, color: AppColors.surface),
          onPressed: () {
            // TODO: edit customer event
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: AppColors.surface),
          onPressed: () => _confirmDelete(context),
        ),
      ],
      flexibleSpace: const FlexibleSpaceBar(
        background: Center(
          child: Text(
            'TODO: Customer Info هنا',
            style: TextStyle(color: AppColors.surface),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusLg)),
        title: const Text('Delete Customer'),
        content: const Text(
            'Are you sure you want to delete this customer and all their transactions?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: delete customer event
              Navigator.pop(context);
            },
            child:
            const Text('Delete', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }
}