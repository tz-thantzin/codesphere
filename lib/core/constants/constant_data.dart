// lib/core/constants/constant_data.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/process_item_model.dart';
import '../../models/service_model.dart';
import '../../models/social_link_model.dart';
import '../../models/stat_model.dart';
import 'constant_colors.dart';
import 'constant_images.dart';

final List<ServiceModel> serviceData = [
  const ServiceModel(
    title: 'Native iOS Development',
    description:
        'Crafting swift, beautiful, and secure applications using Swift and SwiftUI.',
    icon: Icons.phone_iphone,
  ),
  const ServiceModel(
    title: 'Native Android Development',
    description: 'Leveraging Kotlin for powerful, modern Android experiences.',
    icon: Icons.phone_android,
  ),
  const ServiceModel(
    title: 'Cross-Platform Solutions',
    description: 'Efficient development using Flutter for unified codebases.',
    icon: Icons.devices_other,
  ),
  const ServiceModel(
    title: 'HRM & ERP Systems',
    description:
        'Enterprise-grade mobile apps for internal management and resource planning.',
    icon: Icons.business_center,
  ),
  const ServiceModel(
    title: 'E-Commerce Mobile Apps',
    description:
        'Building fast, reliable mobile storefronts that maximize conversion.',
    icon: Icons.shopping_cart,
  ),
  const ServiceModel(
    title: 'Real Estate Platforms',
    description: 'Mapping, and secure transaction handling for property tech.',
    icon: Icons.home,
  ),
  const ServiceModel(
    title: 'Custom Feature Development',
    description:
        'Building unique, complex features and Minimum Viable Products (MVPs).',
    icon: Icons.code,
  ),
  const ServiceModel(
    title: 'UI/UX Design & Prototyping',
    description:
        'Wireframe, high-fidelity mockups, and user testing for perfect flows.',
    icon: Icons.design_services,
  ),
  const ServiceModel(
    title: 'App Store Optimization',
    description:
        'Visibility strategy, listing management, and ongoing maintenance post-launch.',
    icon: Icons.trending_up,
  ),
];

const List<StatModel> stats = [
  StatModel("11+", "Years Building Apps"),
  StatModel("50+", "Projects Delivered"),
  StatModel("4.5/5", "Client Rating", isNumeric: false),
  StatModel("99%", "On-Time Delivery"),
];

const List<SocialLinkModel> socialLinks = [
  SocialLinkModel(
    icon: FontAwesomeIcons.linkedinIn,
    url: "https://www.linkedin.com/m/in/code-sphere-054226393/",
    brandColor: kLinkedIn,
  ),
  SocialLinkModel(
    icon: FontAwesomeIcons.facebook,
    url: "https://facebook.com/codespheremm/",
    brandColor: kFacebook,
  ),
  SocialLinkModel(
    icon: FontAwesomeIcons.tiktok,
    url: "https://www.tiktok.com/@codespheremm",
    brandColor: kTiktok,
  ),
  SocialLinkModel(
    icon: FontAwesomeIcons.code,
    url: "https://devthantzin.com",
    brandColor: kPortfolio,
  ),
];

final List<ProcessItemModel> processes = [
  ProcessItemModel(
    title: "Research",
    iconPath: kResearchIcon,
    description:
        "We analyze market trends, user needs, and technical requirements to build a solid foundation for your project.",
  ),
  ProcessItemModel(
    title: "Design",
    iconPath: kDesignIcon,
    description:
        "Our team prototypes intuitive interfaces and engaging user experiences that align perfectly with your brand identity.",
  ),
  ProcessItemModel(
    title: "Develop",
    iconPath: kDevelopIcon,
    description:
        "We write clean, scalable, and efficient code using cutting-edge technologies to bring the designs to life.",
  ),
  ProcessItemModel(
    title: "Test",
    iconPath: kTestIcon,
    description:
        "Rigorous quality assurance ensures high performance, security, and a bug-free experience across all devices.",
  ),
];

const String kEmail = "codesphere.mm@gmail.com";
const String kPhoneViber = "+959751864449";
const String kPhoneWhatsApp = "+6692525257";
