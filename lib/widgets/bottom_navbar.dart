import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index)? onChanged;

  BottomNavbar({super.key, this.currentIndex = 0, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight * 1.24,
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding * 2.3,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var index = 0; index < navItems.length; index++)
            _NavItem(
              label: navItems[index].label,
              icon: navItems[index].icon,
              isSelected: currentIndex == index,
              onPressed: () {
                SystemSound.play(SystemSoundType.click);
                onChanged?.call(index);
              },
            )
        ],
      ),
    );
  }

  late final List<_NavItemInfo> navItems = [
    _NavItemInfo(label: "Inicio", icon: Icons.home),
    _NavItemInfo(label: "Mapa", icon: Icons.route),
    _NavItemInfo(label: "Notificaciones", icon: Icons.notifications),
    _NavItemInfo(label: "Perfil", icon: Icons.person),
  ];
}

class _NavItemInfo {
  String label;
  IconData icon;
  _NavItemInfo({
    required this.label,
    required this.icon,
  });
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onPressed;

  const _NavItem({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? orangeColor : greyColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? orangeColor : greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
