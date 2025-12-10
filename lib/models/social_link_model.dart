import 'package:flutter/material.dart';

class SocialLinkModel {
  final IconData icon;
  final String url;
  final Color? brandColor;

  const SocialLinkModel({
    required this.icon,
    required this.url,
    this.brandColor,
  });
}
