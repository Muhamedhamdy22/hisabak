import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_bloc.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_event.dart';
import 'package:hisabak/Features/AddTransaction/presentation/bloc/transaction_state.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/enums/request_status.dart';
import 'package:hisabak/di.dart';

class AddTransactionScreen extends StatelessWidget {
  final int customerId;
  const AddTransactionScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    final noteController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => getIt<TransactionBloc>(),
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state.addTransactionStatus == RequestStatus.success) {
            Navigator.pop(context);
          }
          if (state.addTransactionStatus == RequestStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.addTransactionMessage ?? 'Something went wrong'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          final isDebt = state.selectedType == 'debt';
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: isDebt ? AppColors.danger : AppColors.success,
              title: Text(
                isDebt ? 'Add Debt' : 'Add Payment',
                style: const TextStyle(
                    color: AppColors.surface, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: AppColors.surface),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.spaceMd),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildTypeToggle(context, state),
                    const SizedBox(height: 16),
                    _buildAmountField(amountController, isDebt),
                    const SizedBox(height: 16),
                    _buildNoteField(noteController),
                    const SizedBox(height: 16),
                    _buildWhatsAppNote(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(
                      context,
                      formKey,
                      amountController,
                      noteController,
                      isDebt,
                      state,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeToggle(BuildContext context, TransactionState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeButton(
              context: context,
              type: 'debt',
              label: 'Debt',
              icon: Icons.arrow_upward,
              isSelected: state.selectedType == 'debt',
            ),
          ),
          Expanded(
            child: _buildTypeButton(
              context: context,
              type: 'payment',
              label: 'Payment',
              icon: Icons.arrow_downward,
              isSelected: state.selectedType == 'payment',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required BuildContext context,
    required String type,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    final color = type == 'debt' ? AppColors.danger : AppColors.success;
    return GestureDetector(
      onTap: () => context.read<TransactionBloc>().add(
        SelectTypeEvent(type: type),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.surface : AppColors.textSecondary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.surface : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField(TextEditingController controller, bool isDebt) {
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
          const Text('Amount', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: isDebt ? AppColors.danger : AppColors.success,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary.withOpacity(0.4),
              ),
              suffixText: 'EGP',
              suffixStyle: TextStyle(
                fontSize: 20,
                color: isDebt ? AppColors.danger : AppColors.success,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Enter amount';
              if (double.tryParse(v) == null) return 'Invalid amount';
              if (double.parse(v) <= 0) return 'Amount must be positive';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: 3,
        style: AppTextStyles.bodyLarge,
        decoration: const InputDecoration(
          labelText: 'Note (optional)',
          hintText: 'e.g. January goods...',
          prefixIcon: Icon(
            Icons.note_outlined,
            color: AppColors.textSecondary,
            size: 20,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildWhatsAppNote() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: const Color(0xFF25D366).withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: const Color(0xFF25D366).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.chat_outlined, color: Color(0xFF1D9E50), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'WhatsApp message will open after saving',
              style: TextStyle(fontSize: 13, color: Color(0xFF1D9E50)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController amountController,
      TextEditingController noteController,
      bool isDebt,
      TransactionState state,
      ) {
    final isLoading = state.addTransactionStatus == RequestStatus.loading;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
          if (formKey.currentState!.validate()) {
            context.read<TransactionBloc>().add(
              AddTransactionEvent(
                customerId: customerId,
                type: state.selectedType,
                amount: double.parse(amountController.text),
                note: noteController.text,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDebt ? AppColors.danger : AppColors.success,
          foregroundColor: AppColors.surface,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: AppColors.surface,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDebt ? Icons.arrow_upward : Icons.check,
              size: 20,
              color: AppColors.surface,
            ),
            const SizedBox(width: 8),
            Text(
              isDebt
                  ? 'Save Debt & Send WhatsApp'
                  : 'Save Payment & Send WhatsApp',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}