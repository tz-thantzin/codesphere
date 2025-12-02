import 'package:flutter/material.dart';

final GlobalKey aboutSectionKey = GlobalKey();
final GlobalKey servicesSectionKey = GlobalKey();
final GlobalKey contactSectionKey = GlobalKey();

final Map<String, GlobalKey> sectionKeys = {
  'about': aboutSectionKey,
  'services': servicesSectionKey,
  'contact': contactSectionKey,
};
