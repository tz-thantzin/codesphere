import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_images.dart';
import '../../core/constants/constant_sizes.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/typography.dart';

class NavbarSection extends StatelessWidget {
  final void Function(String) onNavigate;

  const NavbarSection({super.key, required this.onNavigate});

  void _handleTap(String hash, BuildContext context) {
    onNavigate(hash);
    if (context.isMobile) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;
    final bool isDesktop = context.isDesktop;

    return Container(
      height: isMobile ? s60 : s100,
      padding: isMobile
          ? const EdgeInsets.symmetric(horizontal: s20)
          : context.appbarPadding(),
      color: isDesktop ? kTransparent : kPrimary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Image.asset(
            kLogoText,
            height: isMobile ? s28 : context.adaptive(s36, s52),
            fit: BoxFit.contain,
          ),

          const Spacer(),

          // Desktop Navigation Items
          if (!isMobile)
            Row(
              children: navItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return _NavText(
                      label: item.label,
                      onTap: () => _handleTap(item.hash, context),
                    )
                    .animate()
                    .fadeIn(delay: (100 + index * 80).ms)
                    .slideY(begin: -0.4, curve: Curves.easeOutQuad);
              }).toList(),
            ),

          // Mobile Menu Button
          if (isMobile)
            IconButton(
              onPressed: () => _showMobileDrawer(context),
              icon: const Icon(Icons.menu_rounded, size: s32, color: kWhite),
            ).animate().scale(delay: 300.ms, curve: Curves.easeOutBack),
        ],
      ),
    );
  }

  void _showMobileDrawer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      transitionDuration: 400.ms,
      pageBuilder: (_, _, _) => const SizedBox.shrink(),
      transitionBuilder: (ctx, animation, _, _) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
          child: Material(
            color: kPrimary,
            child: SafeArea(
              child: Stack(
                children: [
                  // Drawer Content
                  Padding(
                    padding: const EdgeInsets.only(left: s40, top: s80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo in drawer
                        Image.asset(
                          kLogoText,
                          height: context.adaptive(s36, s52),
                        ),
                        const SizedBox(height: s80),

                        // Navigation Items
                        ...navItems.map((item) {
                          return _MobileNavItem(
                                label: item.label,
                                onTap: () => _handleTap(item.hash, ctx),
                              )
                              .animate()
                              .fadeIn(delay: 100.ms)
                              .slideX(begin: 0.3, curve: Curves.easeOut);
                        }),
                      ],
                    ),
                  ),

                  // Close Button
                  Positioned(
                    top: s16,
                    right: s16,
                    child: CloseButton(
                      color: kWhite,
                      onPressed: () => Navigator.pop(ctx),
                    ),
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
          padding: const EdgeInsets.symmetric(horizontal: s24, vertical: s10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: ts17,
              fontWeight: FontWeight.w600,
              color: kWhite,
              letterSpacing: 0.5,
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
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: kWhite.withValues(alpha: 0.2),
        highlightColor: kWhite.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: s22),
          child: TitleMedium(
            label,
            color: kWhite,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
