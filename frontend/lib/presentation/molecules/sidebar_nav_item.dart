import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Molécula: Item de navegação da sidebar
class SidebarNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isCollapsed;
  final VoidCallback? onTap;

  const SidebarNavItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.isCollapsed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          hoverColor: Colors.white.withOpacity(0.08),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCollapsed ? 10 : 14,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? Colors.white
                      : Colors.white.withOpacity(0.7),
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isActive
                            ? Colors.white
                            : Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
