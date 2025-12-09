import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @hero_building_mobile_apps.
  ///
  /// In en, this message translates to:
  /// **'Building Mobile Apps, Quickly and Affordably'**
  String get hero_building_mobile_apps;

  /// No description provided for @hero_mobile_app_description.
  ///
  /// In en, this message translates to:
  /// **'We specialize in crafting high-quality mobile applications with expert developers, designers, and testers. Whether you need a full-scale product team or rapid feature development, we deliver scalable, long-term mobile solutions tailored to your business needs.'**
  String get hero_mobile_app_description;

  /// No description provided for @we_build_exceptional.
  ///
  /// In en, this message translates to:
  /// **'We Build Exceptional\nMobile Experiences'**
  String get we_build_exceptional;

  /// No description provided for @premium_android_ios_studio.
  ///
  /// In en, this message translates to:
  /// **'CodeSphere – Premium Android & iOS Development Studio'**
  String get premium_android_ios_studio;

  /// No description provided for @view_our_work.
  ///
  /// In en, this message translates to:
  /// **'View Our Work'**
  String get view_our_work;

  /// No description provided for @get_free_quote.
  ///
  /// In en, this message translates to:
  /// **'Get a Free Quote'**
  String get get_free_quote;

  /// No description provided for @section_title_about_us.
  ///
  /// In en, this message translates to:
  /// **'\\ About Us \\'**
  String get section_title_about_us;

  /// No description provided for @about_us_main_title.
  ///
  /// In en, this message translates to:
  /// **'Innovative IT Solutions Backed by a Decade of Expertise'**
  String get about_us_main_title;

  /// No description provided for @about_us_main_description.
  ///
  /// In en, this message translates to:
  /// **'At CodeSphere, we believe technology should not only solve problems — it should create possibilities. With over 10 years of industry experience, we deliver IT solutions that are fast, secure, and tailored to the unique needs of every business we work with.\nWhether you\'re a startup validating an idea or an enterprise optimizing performance, our solutions are built to scale with your growth.'**
  String get about_us_main_description;

  /// No description provided for @about_us_sub_title.
  ///
  /// In en, this message translates to:
  /// **'Crafting the Future of Mobile,\nOne App at a Time'**
  String get about_us_sub_title;

  /// No description provided for @about_us_sub_description.
  ///
  /// In en, this message translates to:
  /// **'At CodeSphere, we don’t just build apps — we architect digital experiences\nthat scale, perform, and delight. With experience in Flutter, Swift, Kotlin\nand modern UI engineering, we deliver reliable and beautiful solutions.'**
  String get about_us_sub_description;

  /// No description provided for @about_us_highlights.
  ///
  /// In en, this message translates to:
  /// **'High Quality, Fast Delivery, 24/7 Support, Fair Prices'**
  String get about_us_highlights;

  /// No description provided for @section_title_planning.
  ///
  /// In en, this message translates to:
  /// **'\\ Planning \\ '**
  String get section_title_planning;

  /// No description provided for @process_planning_title.
  ///
  /// In en, this message translates to:
  /// **'Our Process'**
  String get process_planning_title;

  /// No description provided for @process_planning_description.
  ///
  /// In en, this message translates to:
  /// **'We follow a proven agile methodology to transform your complex ideas into robust digital solutions, ensuring transparency and quality at every step of the journey.'**
  String get process_planning_description;

  /// No description provided for @what_we_build.
  ///
  /// In en, this message translates to:
  /// **'What We Build'**
  String get what_we_build;

  /// No description provided for @contact_title.
  ///
  /// In en, this message translates to:
  /// **'Let’s Build Something\nExtraordinary Together'**
  String get contact_title;

  /// No description provided for @contact_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Get in Touch'**
  String get contact_subtitle;

  /// No description provided for @contact_message_sent_successful.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully! We\'ll contact you soon.'**
  String get contact_message_sent_successful;

  /// No description provided for @contact_your_name.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get contact_your_name;

  /// No description provided for @contact_email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get contact_email_address;

  /// No description provided for @contact_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get contact_phone_number;

  /// No description provided for @contact_tell_about_prj.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your project...'**
  String get contact_tell_about_prj;

  /// No description provided for @contact_btn_sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get contact_btn_sending;

  /// No description provided for @contact_btn_send_message.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contact_btn_send_message;

  /// No description provided for @contact_warning_project_required.
  ///
  /// In en, this message translates to:
  /// **'Please tell us about your project.'**
  String get contact_warning_project_required;

  /// No description provided for @contact_warning_field_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get contact_warning_field_required;

  /// No description provided for @contact_warning_enter_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get contact_warning_enter_valid_email;

  /// No description provided for @contact_warning_enter_valid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number.'**
  String get contact_warning_enter_valid_phone_number;

  /// No description provided for @codesphere.
  ///
  /// In en, this message translates to:
  /// **'CodeSphere'**
  String get codesphere;

  /// No description provided for @footer_copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 CodeSphere.'**
  String get footer_copyright;

  /// No description provided for @footer_rights_reserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get footer_rights_reserved;

  /// No description provided for @footer_tagline.
  ///
  /// In en, this message translates to:
  /// **'Crafting exceptional mobile experiences.'**
  String get footer_tagline;

  /// No description provided for @page_not_found.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get page_not_found;

  /// No description provided for @the_page_you_are_looking_for_does_not_exist.
  ///
  /// In en, this message translates to:
  /// **'The page you\'re looking for doesn\'t exist or has been moved.'**
  String get the_page_you_are_looking_for_does_not_exist;

  /// No description provided for @go_back_home.
  ///
  /// In en, this message translates to:
  /// **'Go Back Home'**
  String get go_back_home;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
