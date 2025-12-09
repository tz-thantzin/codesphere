// lib/presentation/widgets/navbar_section.dart
import 'package:codesphere/core/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_images.dart';
import '../../core/utils/extensions/extensions.dart';

class NavbarSection extends StatelessWidget {
  final void Function(String) onNavigate;

  const NavbarSection({super.key, required this.onNavigate});

  static const List<_NavItem> _items = [
    _NavItem(label: 'Home', hash: 'home'),
    _NavItem(label: 'About Us', hash: 'about'),
    _NavItem(label: 'Services', hash: 'services'),
    _NavItem(label: 'Contact Us', hash: 'contact'),
  ];

  void _handleTap(String hash, BuildContext context) {
    onNavigate(hash);
    if (context.isMobile) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.isMobile
          ? const EdgeInsets.symmetric(horizontal: 20)
          : context.appbarPadding(),
      height: context.isMobile ? 60 : 100,
      color: context.isDesktop ? kTransparent : kPrimary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Logo
          Image.asset(
            kLogoText,
            height: context.isMobile ? 28 : context.adaptive(36, 52),
            fit: BoxFit.contain,
          ),

          const Spacer(),

          /// Desktop Menu Items
          if (!context.isMobile)
            Row(
              children: _items.asMap().entries.map((e) {
                final item = e.value;
                return _NavText(
                      label: item.label,
                      onTap: () => _handleTap(item.hash, context),
                    )
                    .animate()
                    .fadeIn(delay: (100 + e.key * 80).ms)
                    .slideY(begin: -0.4);
              }).toList(),
            ),

          /// Mobile Hamburger
          if (context.isMobile)
            IconButton(
              onPressed: () => _showDrawer(context),
              icon: const Icon(Icons.menu_rounded, size: 32, color: kWhite),
            ).animate().scale(delay: 300.ms),
        ],
      ),
    );
  }

  void _showDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Menu",
      transitionDuration: 400.ms,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim, _, __) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim),
          child: Material(
            color: kPrimary,
            child: SafeArea(
              child: Stack(
                children: [
                  /// Drawer content
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          kLogoText,
                          height: context.adaptive(36, 52),
                        ),
                        const SizedBox(height: 80),
                        ..._items.map(
                          (item) => _MobileNavItem(
                            label: item.label,
                            onTap: () => _handleTap(item.hash, ctx),
                          ).animate().fadeIn().slideX(begin: 0.3),
                        ),
                      ],
                    ),
                  ),

                  /// Close button
                  const Positioned(
                    top: 16,
                    right: 16,
                    child: CloseButton(color: kWhite),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  final String label;
  final String hash;
  const _NavItem({required this.label, required this.hash});
}

class _NavText extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavText({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: kWhite,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _MobileNavItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimary,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: TitleMedium(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
