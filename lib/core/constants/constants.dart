import 'package:flutter/material.dart';

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
