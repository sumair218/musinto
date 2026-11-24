import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4F7),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 34,
                        backgroundColor: Colors.white,
                        child:
                            Icon(Icons.person, size: 38, color: AppColors.pink),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pavan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'pavan@example.com',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.hint.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.profile),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                ),
                const SectionHeader('Your Library', Icons.library_music),
                const _ProfileTile(
                  icon: Icons.favorite_border,
                  title: 'Liked Songs',
                  route: Routes.liked,
                ),
                const _ProfileTile(
                  icon: Icons.download_outlined,
                  title: 'Downloaded',
                ),
                const _ProfileTile(
                  icon: Icons.history,
                  title: 'Listening History',
                ),
                const SectionHeader('Settings', Icons.settings_outlined),
                const _ProfileTile(
                  icon: Icons.language,
                  title: 'Music Language',
                  route: Routes.language,
                ),
                const _ProfileTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                ),
                const _ProfileTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                ),
                const SizedBox(height: 18),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, Routes.splash, (_) => false),
                  icon: const Icon(Icons.logout, color: AppColors.pink),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(color: AppColors.pink),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    side: const BorderSide(color: Color(0xFFFFD0DC)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? route;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: route == null ? null : () => Navigator.pushNamed(context, route!),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.dark),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, size: 20, color: AppColors.hint),
            ],
          ),
        ),
      ),
    );
  }
}
