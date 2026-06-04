import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.only(top: 64, bottom: 32, left: 24, right: 24),
      decoration:  BoxDecoration(
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
            decoration:  BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
            child:  Center(
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
           SizedBox(height: 12),
           Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.surface,
              letterSpacing: 0.5,
            ),
          ),
           SizedBox(height: 2),
          //  Text(
          //   AppConstants.appNameAr,
          //   style: TextStyle(fontSize: 13, color: AppColors.surface),
          // ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(AppConstants.spaceMd),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: 16),
             Text('Create Account', style: AppTextStyles.headlineMedium),
             SizedBox(height: 24),
            _buildTextField(
              controller: nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline,
              validator: (v) =>
              v == null || v.isEmpty ? 'Enter your name' : null,
            ),
             SizedBox(height: 16),
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
             SizedBox(height: 16),
            _buildTextField(
              controller: passwordController,
              label: 'Password',
              hint: '••••••••',
              icon: Icons.lock_outline,
              obscureText: true,
              validator: (v) =>
              v == null || v.length < 6 ? 'Password too short' : null,
            ),
             SizedBox(height: 16),
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
             SizedBox(height: 28),
            _buildPrimaryButton(
              label: 'Create Account',
              color: AppColors.gold,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // TODO: add register event
                }
              },
            ),
             SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text('Already have account?',
                    style: AppTextStyles.bodyMedium),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child:  Text(
                    'Login',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 16),
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
    Color color = AppColors.primary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.surface,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
        ),
        child: Text(
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