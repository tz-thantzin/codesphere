import 'package:flutter/material.dart';

import '../../core/widgets/animated_background.dart';
import '../widgets/not_found_section.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          NotFoundSection(
            onGoHome: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
