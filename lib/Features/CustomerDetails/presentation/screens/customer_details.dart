import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_bloc.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_event.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_state.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/di.dart';

class CustomerDetailScreen extends StatelessWidget {
  final int customerId;
  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TransactionBloc>()
        ..add(GetTransactionsEvent(customerId: customerId)),
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state.deleteTransactionStatus == RequestStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Transaction deleted')),
            );
          }
          if (state.deleteTransactionStatus == RequestStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.deleteTransactionMessage ?? 'Error'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: CustomScrollView(
              slivers: [
                _buildSliverAppBar(context),
                SliverToBoxAdapter(child: _buildSummary(state)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: const Text('Account Statement', style: AppTextStyles.titleLarge),
                  ),
                ),
                if (state.getTransactionsStatus == RequestStatus.loading)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    ),
                  )
                else if (state.transactions.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('No transactions yet', style: AppTextStyles.bodyMedium),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (_, i) => _TransactionTile(
                        transaction: state.transactions[i],
                        onDelete: () => context.read<TransactionBloc>().add(
                          DeleteTransactionEvent(id: state.transactions[i].id!),
                        ),
                      ),
                      childCount: state.transactions.length,
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
                    context,
                    Routes.addTransaction,
                    arguments: customerId,
                  ),
                  backgroundColor: AppColors.danger,
                  icon: const Icon(Icons.add, color: AppColors.surface),
                  label: const Text('Add Debt',
                      style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 10),
                FloatingActionButton.extended(
                  heroTag: 'payment',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    Routes.addTransaction,
                    arguments: customerId,
                  ),
                  backgroundColor: AppColors.success,
                  icon: const Icon(Icons.check, color: AppColors.surface),
                  label: const Text('Add Payment',
                      style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.surface),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.primary,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 48),
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.gold,
                child: Icon(Icons.person, size: 36, color: AppColors.surface),
              ),
              SizedBox(height: 12),
              Text(
                'Customer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary(TransactionState state) {
    double totalDebt = 0;
    double totalPayment = 0;
    for (var t in state.transactions) {
      if (t.type == 'debt') totalDebt += t.amount ?? 0;
      if (t.type == 'payment') totalPayment += t.amount ?? 0;
    }
    final balance = totalDebt - totalPayment;

    return Container(
      margin: const EdgeInsets.all(AppConstants.spaceMd),
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(child: _SummaryItem(label: 'Total Debts', value: '${totalDebt.toStringAsFixed(0)} EGP', color: AppColors.danger)),
          Container(width: 0.5, height: 40, color: AppColors.border),
          Expanded(child: _SummaryItem(label: 'Payments', value: '${totalPayment.toStringAsFixed(0)} EGP', color: AppColors.success)),
          Container(width: 0.5, height: 40, color: AppColors.border),
          Expanded(child: _SummaryItem(label: 'Remaining', value: '${balance.toStringAsFixed(0)} EGP', color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _SummaryItem({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.bodyLarge.copyWith(color: color, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall, textAlign: TextAlign.center),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final dynamic transaction;
  final VoidCallback onDelete;
  const _TransactionTile({required this.transaction, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDebt = transaction.type == 'debt';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDebt ? AppColors.danger.withOpacity(0.1) : AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
            ),
            child: Icon(
              isDebt ? Icons.arrow_upward : Icons.arrow_downward,
              color: isDebt ? AppColors.danger : AppColors.success,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDebt ? 'Debt' : 'Payment',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isDebt ? AppColors.danger : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (transaction.note != null && transaction.note!.isNotEmpty)
                  Text(transaction.note!, style: AppTextStyles.labelSmall),
                Text(transaction.createdAt ?? '', style: AppTextStyles.labelSmall),
              ],
            ),
          ),
          Text(
            '${isDebt ? '+' : '-'} ${transaction.amount?.toStringAsFixed(0)} EGP',
            style: AppTextStyles.bodyLarge.copyWith(
              color: isDebt ? AppColors.danger : AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.danger, size: 20),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}