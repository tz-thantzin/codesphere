import 'package:codesphere/core/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/social_link.dart';
import '../../model/stat.dart';

final List<Map<String, dynamic>> serviceData = [
  {
    'title': 'Native iOS Development',
    'description':
        'Crafting swift, beautiful, and secure applications using Swift and SwiftUI.',
    'icon': Icons.phone_iphone,
  },
  {
    'title': 'Native Android Development',
    'description':
        'Leveraging Kotlin for powerful, modern Android experiences.',
    'icon': Icons.phone_android,
  },
  {
    'title': 'Cross-Platform Solutions',
    'description': 'Efficient development using Flutter for unified codebases.',
    'icon': Icons.devices_other,
  },
  {
    'title': 'HRM & ERP Systems',
    'description':
        'Enterprise-grade mobile apps for internal management and resource planning.',
    'icon': Icons.business_center,
  },
  {
    'title': 'E-Commerce Mobile Apps',
    'description':
        'Building fast, reliable mobile storefronts that maximize conversion.',
    'icon': Icons.shopping_cart,
  },
  {
    'title': 'Real Estate Platforms',
    'description':
        'Mapping, and secure transaction handling for property tech.',
    'icon': Icons.location_on,
  },
  {
    'title': 'Custom Feature Development',
    'description':
        'Building unique, complex features and Minimum Viable Products (MVPs).',
    'icon': Icons.code,
  },
  {
    'title': 'UI/UX Design & Prototyping',
    'description':
        'Wireframe, high-fidelity mockups, and user testing for perfect flows.',
    'icon': Icons.design_services,
  },
  {
    'title': 'App Store Optimization',
    'description':
        'Visibility strategy, listing management, and ongoing maintenance post-launch.',
    'icon': Icons.trending_up,
  },
];

const List<Stat> stats = [
  Stat("12+", "Years of\nExperience"),
  Stat("50+", "Completed\nProjects"),
  Stat("100%", "Client\nCommitment"),
  Stat("Agile", "Fast\nDelivery", isNumeric: false),
];

const List<SocialLink> socialLinks = [
  SocialLink(
    icon: FontAwesomeIcons.linkedinIn,
    url: "https://www.linkedin.com/in/thant-zin-9a855524/",
    brandColor: kLinkedIn,
  ),
  SocialLink(
    icon: FontAwesomeIcons.facebook,
    url: "https://facebook.com/codespheremm/",
    brandColor: kFacebook,
  ),
  SocialLink(
    icon: FontAwesomeIcons.code,
    url: "https://devthantzin.com",
    brandColor: kPortfolio,
  ),
];

const String kEmail = "codesphere.mm@gmail.com";
const String kPhoneViber = "+959751864449";
const String kPhoneWhatsApp = "+6692525257";
