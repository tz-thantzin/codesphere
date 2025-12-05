import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/constant_data.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import 'service_card.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid();

  @override
  Widget build(BuildContext context) {
    final spacing = context.adaptive(20.0, 30.0);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: serviceData.length,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: context.adaptive(400, 450),
        childAspectRatio: context.adaptive(0.7, 1.2, sm: 0.9, md: 1.0, xl: 1.3),
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) {
        final service = serviceData[index];
        return AnimatedFadeSlide(
          visibilityKey: 'service-card-$index',
          delay: (200 + index * 160).ms,
          beginY: 0.4,
          child: ServiceCard(
            title: service["title"]!,
            desc: service["description"]!,
            icon: service["icon"]!,
          ),
        );
      },
    );
  }
}
