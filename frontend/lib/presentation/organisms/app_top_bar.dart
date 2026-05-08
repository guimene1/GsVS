import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/user_model.dart';
import '../atoms/avatar_initials.dart';

/// Organismo: Barra superior do sistema
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final UserModel user;
  final VoidCallback? onMenuTap; // mobile
  final int notificationCount;

  const AppTopBar({
    super.key,
    required this.user,
    this.onMenuTap,
    this.notificationCount = 3,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Mobile menu toggle
          if (onMenuTap != null) ...[
            IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.textPrimary,
              ),
              onPressed: onMenuTap,
            ),
            const SizedBox(width: 8),
          ],

          const Spacer(),

          // Notificações
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                  size: 22,
                ),
                onPressed: () {},
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDC2626),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),

          // User info
          PopupMenuButton<dynamic>(
            offset: const Offset(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (_) => <PopupMenuEntry<dynamic>>[
              PopupMenuItem<dynamic>(
                child: Row(
                  children: [
                    Icon(Icons.person_outline_rounded, size: 18),
                    SizedBox(width: 10),
                    Text('Meu perfil'),
                  ],
                ),
              ),
              PopupMenuItem<dynamic>(
                child: Row(
                  children: [
                    Icon(Icons.lock_outline_rounded, size: 18),
                    SizedBox(width: 10),
                    Text('Alterar senha'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<dynamic>(
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      size: 18,
                      color: Color(0xFFDC2626),
                    ),
                    SizedBox(width: 10),
                    Text('Sair', style: TextStyle(color: Color(0xFFDC2626))),
                  ],
                ),
              ),
            ],
            child: Row(
              children: [
                AvatarInitials(
                  initials: user.initials,
                  size: 36,
                  backgroundColor: AppColors.primary,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      user.role.label,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
