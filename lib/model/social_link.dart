import 'package:flutter/material.dart';

class SocialLink {
  final IconData icon;
  final String url;
  final Color?
  brandColor; // optional: for special hover color (e.g. Facebook blue)

  const SocialLink({required this.icon, required this.url, this.brandColor});
}
