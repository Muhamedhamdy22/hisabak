import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';

class AddCustomerScreen extends StatelessWidget {
  AddCustomerScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Add Customer',
            style: TextStyle(color: AppColors.surface, fontWeight: FontWeight.w600)),
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
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(Icons.person_add_outlined,
                    size: 48, color: AppColors.primary),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(AppConstants.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      style: AppTextStyles.bodyLarge,
                      validator: (v) =>
                      v == null || v.isEmpty ? 'Enter customer name' : null,
                      decoration: const InputDecoration(
                        labelText: 'Customer Name',
                        hintText: 'Enter full name',
                        prefixIcon: Icon(Icons.person_outline,
                            color: AppColors.textSecondary, size: 20),
                        labelStyle: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      style: AppTextStyles.bodyLarge,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Enter phone number';
                        if (v.length < 11) return 'Invalid phone number';
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        hintText: '01xxxxxxxxx',
                        prefixIcon: Icon(Icons.phone_outlined,
                            color: AppColors.textSecondary, size: 20),
                        labelStyle: AppTextStyles.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // TODO: add customer event
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.surface,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: const Text('Save Customer',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.surface)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}