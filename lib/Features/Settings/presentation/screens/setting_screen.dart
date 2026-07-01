import 'package:flutter/material.dart';
import 'package:hisabak/core/constants/app_colors.dart';
import 'package:hisabak/core/constants/app_text_styles.dart';
import 'package:hisabak/core/constants/app_constants.dart';
import 'package:hisabak/core/helper/shared_pref_helper.dart';
import 'package:hisabak/core/routes_manager/route.dart';
import 'package:hisabak/l10n/app_localizations.dart';
import 'package:hisabak/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(l.settings,
            style: const TextStyle(
                color: AppColors.surface, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(label: l.language.toUpperCase()),
            const SizedBox(height: 8),
            _buildLanguageCard(context, l),
            const SizedBox(height: 20),
            _SectionLabel(label: l.account.toUpperCase()),
            const SizedBox(height: 8),
            _buildSettingsCard(
              children: [
                _buildSettingsRow(
                  icon: Icons.lock_outline,
                  title: l.changePassword,
                  onTap: () {},
                ),
                _buildSettingsRow(
                  icon: Icons.phone_outlined,
                  title: l.changePhone,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SectionLabel(label: l.about.toUpperCase()),
            const SizedBox(height: 8),
            _buildSettingsCard(
              children: [
                _buildSettingsRow(
                  icon: Icons.info_outline,
                  title: l.version,
                  trailing: const Text(AppConstants.appVersion,
                      style: AppTextStyles.bodyMedium),
                  onTap: () {},
                ),
                _buildSettingsRow(
                  icon: Icons.star_outline,
                  title: l.rateApp,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildLogoutButton(context, l),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 2, l),
    );
  }

  Widget _buildLanguageCard(BuildContext context, AppLocalizations l) {
    final currentLang = SharedPrefHelper.getLang() ?? 'en';
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
          Row(
            children: [
              const Icon(Icons.language, color: AppColors.primary, size: 20),
              const SizedBox(width: 10),
              Text(l.language, style: AppTextStyles.bodyLarge),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildLangButton(
                  context: context,
                  code: 'en',
                  label: 'English',
                  flag: '🇬🇧',
                  isSelected: currentLang == 'en',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildLangButton(
                  context: context,
                  code: 'ar',
                  label: 'العربية',
                  flag: '🇪🇬',
                  isSelected: currentLang == 'ar',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLangButton({
    required BuildContext context,
    required String code,
    required String label,
    required String flag,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        await SharedPrefHelper.saveLang(code);
        HisabakApp.setLocale(context, Locale(code));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.surface : AppColors.textPrimary,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsRow({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(icon, color: AppColors.primary, size: 22),
          title: Text(title, style: AppTextStyles.bodyLarge),
          trailing: trailing ??
              const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary, size: 20),
        ),
        const Divider(
            height: 0.5, thickness: 0.5, indent: 56, color: AppColors.border),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, AppLocalizations l) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _confirmLogout(context, l),
        icon: const Icon(Icons.logout, color: AppColors.danger),
        label: Text(l.logout,
            style: const TextStyle(
                color: AppColors.danger, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: AppColors.danger, width: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, AppLocalizations l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusLg)),
        title: Text(l.logout),
        content: Text(l.logoutConfirm),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l.cancel)),
          TextButton(
            onPressed: () async {
              await SharedPrefHelper.clearAll();
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            child: Text(l.logout,
                style: const TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(
      BuildContext context, int currentIndex, AppLocalizations l) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      backgroundColor: AppColors.surface,
      type: BottomNavigationBarType.fixed,
      onTap: (i) {
        if (i == 0) Navigator.pushReplacementNamed(context, Routes.homeRoute);
        if (i == 1)
          Navigator.pushReplacementNamed(context, Routes.customersRoute);
        if (i == 2)
          Navigator.pushReplacementNamed(context, Routes.settingsRoute);
      },
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l.home),
        BottomNavigationBarItem(
            icon: const Icon(Icons.people_outline),
            activeIcon: const Icon(Icons.people),
            label: l.customers),
        BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l.settings),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: AppTextStyles.labelSmall
            .copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.5));
  }
}