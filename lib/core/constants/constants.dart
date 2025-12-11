import 'package:flutter/material.dart';

import '../../models/nav_item.dart';

final GlobalKey heroSectionKey = GlobalKey();
final GlobalKey aboutSectionKey = GlobalKey();
final GlobalKey planningSectionKey = GlobalKey();
final GlobalKey whatWeDoSectionKey = GlobalKey();
final GlobalKey servicesSectionKey = GlobalKey();
final GlobalKey contactSectionKey = GlobalKey();

final Map<String, GlobalKey> sectionKeys = {
  'home': heroSectionKey,
  'about': aboutSectionKey,
  'planning': planningSectionKey,
  'wwd': whatWeDoSectionKey,
  'services': servicesSectionKey,
  'contact': contactSectionKey,
};

const List<NavItem> navItems = [
  NavItem(label: 'Home', hash: 'home'),
  NavItem(label: 'About Us', hash: 'about'),
  NavItem(label: 'Services', hash: 'services'),
  NavItem(label: 'Contact Us', hash: 'contact'),
];
