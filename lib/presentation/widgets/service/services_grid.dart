import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_data.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import 'service_card.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: serviceData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.adaptive(1, 3, md: 2),
        crossAxisSpacing: context.adaptive(s20, s30),
        mainAxisSpacing: context.adaptive(s20, s30),
        mainAxisExtent: context.adaptive(s320, s360),
      ),
      itemBuilder: (context, index) {
        final service = serviceData[index];

        final row = index ~/ 3;
        final col = index % 3;
        final delay = 100 + (row * 120) + (col * 80);

        return AnimatedFadeSlide(
          visibilityKey: 'service-$index',
          delay: delay.ms,
          beginY: 0.3,
          curve: Curves.easeOutCubic,
          child: ServiceCard(
            title: service.title,
            description: service.description,
            icon: service.icon,
          ),
        );
      },
    );
  }
}
