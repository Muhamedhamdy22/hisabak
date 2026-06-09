import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_event.dart';
import 'package:hisabak/Features/Auth/presentation/bloc/auth_state.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/di.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.registerRequestStatus == RequestStatus.success) {
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
          if (state.registerRequestStatus == RequestStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.registerRequestMessage ?? 'Something went wrong'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildForm(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 64, bottom: 32, left: 24, right: 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.radiusXl),
          bottomRight: Radius.circular(AppConstants.radiusXl),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'H',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.surface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.surface,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppConstants.appSlogan,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.surface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context, AuthState state) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text('Create Account', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 24),
            _buildTextField(
              controller: nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline,
              validator: (v) =>
              v == null || v.isEmpty ? 'Enter your name' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: phoneController,
              label: 'Phone Number',
              hint: '01xxxxxxxxx',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Enter phone number';
                if (v.length < 11) return 'Invalid phone number';
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: passwordController,
              label: 'Password',
              hint: '••••••••',
              icon: Icons.lock_outline,
              obscureText: true,
              validator: (v) =>
              v == null || v.length < 6 ? 'Password too short' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: confirmController,
              label: 'Confirm Password',
              hint: '••••••••',
              icon: Icons.lock_outline,
              obscureText: true,
              validator: (v) => v != passwordController.text
                  ? 'Passwords do not match'
                  : null,
            ),
            const SizedBox(height: 28),
            _buildPrimaryButton(
              label: 'Create Account',
              color: AppColors.gold,
              isLoading: state.registerRequestStatus == RequestStatus.loading,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthBloc>().add(
                    RegisterEvent(
                      name: nameController.text,
                      phone: phoneController.text,
                      password: passwordController.text,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account?',
                    style: AppTextStyles.bodyMedium),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextDirection textDirection = TextDirection.ltr,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textDirection: textDirection,
      validator: validator,
      style: AppTextStyles.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
        labelStyle: AppTextStyles.bodyMedium,
        hintStyle: AppTextStyles.bodyMedium,
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onPressed,
    bool isLoading = false,
    Color color = AppColors.primary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
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
            : Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}