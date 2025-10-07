import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of MyLocalizations
/// returned by `MyLocalizations.of(context)`.
///
/// Applications need to include `MyLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MyLocalizations.localizationsDelegates,
///   supportedLocales: MyLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MyLocalizations.supportedLocales
/// property.
abstract class MyLocalizations {
  MyLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MyLocalizations? of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  static const LocalizationsDelegate<MyLocalizations> delegate =
      _MyLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// Bu signUp button
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get create_an_account;

  /// Bu signupni title2
  ///
  /// In en, this message translates to:
  /// **'Let’s create your account.'**
  String get lets_create_your_account;

  /// Bu textField fullName
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// Bu textField fullName hitn
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enter_your_full_name;

  /// Bu textField Email
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Bu textField fullName hitn
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enter_your_email_address;

  /// Bu textField Password
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Bu textField fullName hitn
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// yoki
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// va
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// Bu signUpdan loginga otish title
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// Bu signUpdan loginga otish
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get log_in;

  /// Bu button google uchun
  ///
  /// In en, this message translates to:
  /// **'Sign Up with Google'**
  String get google;

  /// Bu button facebook uchun
  ///
  /// In en, this message translates to:
  /// **'Sign Up with Facebook'**
  String get facebook;

  /// Bu signUp text
  ///
  /// In en, this message translates to:
  /// **'By signing up you agree to our'**
  String get signup_text;

  /// Bu login title1
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get login_to_your_account;

  /// Bu login title2
  ///
  /// In en, this message translates to:
  /// **'It’s great to see you again.'**
  String get its_great_to_see_you_again;

  /// Bu login text
  ///
  /// In en, this message translates to:
  /// **'Forgot your password? '**
  String get forgot_your_password;

  /// Bu logindan forgotga otish
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get reset_your_password;

  /// Bu button login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Bu logindan signUpga otish title
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dont_have_an_account;

  /// Bu logindan signUpga otish
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// Bu home appbar title
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// Bu search textfield
  ///
  /// In en, this message translates to:
  /// **'Search for clothes...'**
  String get search_for_clothes;

  /// Bu hammasi
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Bu bottomNavigationBar Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Bu bottomNavigationBar Search
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Bu bottomNavigationBar Saved
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// Bu bottomNavigationBar Cart
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// Bu bottomNavigationBar Account
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Bu notifications appbar title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Bu notifications title1
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Bu notifications title2
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Bu notifications title3
  ///
  /// In en, this message translates to:
  /// **'The Old Days'**
  String get the_old_days;

  /// Bu notifications yoq boldanidagi title1
  ///
  /// In en, this message translates to:
  /// **'You haven’t gotten any notifications yet!'**
  String get notifications_null_title1;

  /// Bu notifications yoq boldanidagi title2
  ///
  /// In en, this message translates to:
  /// **'We’ll alert you when something cool happens.'**
  String get notifications_null_title2;

  /// Bu saved appbar title
  ///
  /// In en, this message translates to:
  /// **'Saved Items'**
  String get saved_items;

  /// Bu saved yoq boldanidagi title1
  ///
  /// In en, this message translates to:
  /// **'No Saved Items!'**
  String get saved_null_title1;

  /// Bu saved yoq boldanidagi title2
  ///
  /// In en, this message translates to:
  /// **'You don’t have any saved items. Go to home and add some.'**
  String get saved_null_title2;

  /// Bu details appbar title
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Bu details button
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add_to_cart;

  /// Bu reviewsda reyting
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// Bu reviews
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Bu Accaunt title1
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// Bu Accaunt title2
  ///
  /// In en, this message translates to:
  /// **'My Details'**
  String get my_details;

  /// Bu Accaunt title3
  ///
  /// In en, this message translates to:
  /// **'Address Book'**
  String get address_book;

  /// Bu Accaunt title4
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get payment_methods;

  /// Bu Accaunt title5
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Bu Accaunt title6
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get f_a_qs;

  /// Bu Accaunt title7
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// Bu Accaunt title8
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Bu Accauntda diologada title
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switch_language;

  /// Bu detail sizes
  ///
  /// In en, this message translates to:
  /// **'Choose size'**
  String get choose_size;

  /// Bu detail price
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Siza'**
  String get size;

  /// Bu cartdagi title1
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get my_cart;

  /// No description provided for @sub_total.
  ///
  /// In en, this message translates to:
  /// **'Sub-total'**
  String get sub_total;

  /// Bu cartdagi title2
  ///
  /// In en, this message translates to:
  /// **'VAT (%)'**
  String get v_a_t;

  /// Bu cartdagi title3
  ///
  /// In en, this message translates to:
  /// **'Shipping fee'**
  String get shipping_fee;

  /// Bu cartdagi title4
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Bu cartdagi null title1
  ///
  /// In en, this message translates to:
  /// **'Your Cart Is Empty!'**
  String get your_cart_is_empty;

  /// Bu cartdagi null title2
  ///
  /// In en, this message translates to:
  /// **'When you add products, they’ll appear here.'**
  String get when_you_add_products_theyll_appear_here;

  /// Bu detail succes add to cart
  ///
  /// In en, this message translates to:
  /// **'The product has been added to the cart.'**
  String get the_product_been_added_the_cart;

  /// Bu settings notif
  ///
  /// In en, this message translates to:
  /// **'General Notifications'**
  String get general_notifications;

  /// Bu settings notif
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// Bu settings notif
  ///
  /// In en, this message translates to:
  /// **'Vibrate'**
  String get vibrate;

  /// Bu my cart button
  ///
  /// In en, this message translates to:
  /// **'Go To Checkout'**
  String get go_to_checkout;

  /// Bu onb title
  ///
  /// In en, this message translates to:
  /// **'Define yourself in your unique way.'**
  String get onboarding;

  /// Bu Checkout title2
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// Bu card title
  ///
  /// In en, this message translates to:
  /// **'Saved Cards'**
  String get saved_cards;

  /// Bu card default
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get default_card;

  /// Bu add card button
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get add_new_card;

  /// Bu card succes
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Bu new card appbar
  ///
  /// In en, this message translates to:
  /// **'New Card'**
  String get new_card;

  /// Bu newc title
  ///
  /// In en, this message translates to:
  /// **'Add Debit or Credit Card'**
  String get add_debit_credit_card;

  /// Bu newc card numger
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get card_number;

  /// Bu newc data
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiry_date;

  /// Bu newc cvc
  ///
  /// In en, this message translates to:
  /// **'Security Code'**
  String get security_code;

  /// Bu newc hitn
  ///
  /// In en, this message translates to:
  /// **'Enter your card number'**
  String get enter_your_card_number;

  /// Bu newc succes
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get add_card;

  /// Bu logout dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get are_you_sure_you_want_logout;

  /// Bu logout dialog
  ///
  /// In en, this message translates to:
  /// **'Yes, Logout'**
  String get yes_logout;

  /// Bu logout dialog
  ///
  /// In en, this message translates to:
  /// **'No, Cancel'**
  String get no_cancel;

  /// Bu my detail data
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get date_of_birth;

  /// Bu my detail data hitn
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get select_date;

  /// Bu my detail Gender
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Bu my detail Gender hitn
  ///
  /// In en, this message translates to:
  /// **'Select Gender'**
  String get select_gender;

  /// Bu my detail phone number
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// Bu my detail submit
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Bu forgot password title1
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgot_password;

  /// Bu forgot password title2
  ///
  /// In en, this message translates to:
  /// **'Enter your email for the verification process. We will send 4 digits code to your email.'**
  String get forgot_password_title;

  /// Bu forgot password succes
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get send_code;

  /// Bu edc title1
  ///
  /// In en, this message translates to:
  /// **'Enter 4 Digit Code'**
  String get enter_digit_code;

  /// Bu edc title2
  ///
  /// In en, this message translates to:
  /// **'Enter 4 digit code that your receive on your email '**
  String get edc_title;

  /// Bu edc email not code
  ///
  /// In en, this message translates to:
  /// **'Email not received?'**
  String get email_not_received;

  /// Bu edc email not code
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resend_code;

  /// Bu edc succes
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_button;

  /// Bu reset password title1
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// Bu reset password title2
  ///
  /// In en, this message translates to:
  /// **'Set the new password for your account so you can login and access all the features.'**
  String get reset_password_title;

  /// Bu reset password
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// Bu reset password
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// Bu reset password diolog title1
  ///
  /// In en, this message translates to:
  /// **'Password Changed!'**
  String get password_changed;

  /// Bu reset password diolog title2
  ///
  /// In en, this message translates to:
  /// **'Your can now use your new password to login to your account.'**
  String get fp_diolog_title;

  /// Bu forgot passvord hitn
  ///
  /// In en, this message translates to:
  /// **'Forgot Email'**
  String get forgot_email;

  /// Bu Checkout appbar title
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// Bu Checkout title1
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get delivery_address;

  /// Bu Checkout address go
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// Bu Checkout title3
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get order_summary;

  /// Bu Checkout promo code
  ///
  /// In en, this message translates to:
  /// **'Enter promo code'**
  String get enter_promo_code;

  /// Bu Checkout promo code add
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Bu Checkout succes
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get place_order;

  /// Bu FAQs search
  ///
  /// In en, this message translates to:
  /// **'Search for questions...'**
  String get search_for_questions;

  /// Bu address appbar title
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Bu address title1
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get saved_address;

  /// Bu address add
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get add_new_address;

  /// Bu new addres title
  ///
  /// In en, this message translates to:
  /// **'New Address'**
  String get new_address;

  /// Bu new addres nikname
  ///
  /// In en, this message translates to:
  /// **'Address Nickname'**
  String get address_nickname;

  /// Bu new addres name hitn
  ///
  /// In en, this message translates to:
  /// **'Give a name to the address'**
  String get give_name_the_address;

  /// Bu new addres full
  ///
  /// In en, this message translates to:
  /// **'Full Address'**
  String get full_address;

  /// Bu new addres full hitn
  ///
  /// In en, this message translates to:
  /// **'Enter your full address...'**
  String get enter_your_full_address;

  /// Bu new addres default title
  ///
  /// In en, this message translates to:
  /// **'Make this as a default address'**
  String get make_this_default_address;

  /// Bu diolog title
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// Bu new addres diolog title
  ///
  /// In en, this message translates to:
  /// **'Your new address has been added.'**
  String get your_new_address_been_added;

  /// Bu new card diolog title
  ///
  /// In en, this message translates to:
  /// **'Your new card has been added.'**
  String get your_new_card_been_added;

  /// Bu checkout diolog title
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed.'**
  String get your_order_been_placed;

  /// Bu diolog succes Thanks
  ///
  /// In en, this message translates to:
  /// **'Thanks'**
  String get thanks;

  /// Bu new addres
  ///
  /// In en, this message translates to:
  /// **'Track Your Order'**
  String get track_your_order;
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const _MyLocalizationsDelegate();

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(lookupMyLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_MyLocalizationsDelegate old) => false;
}

MyLocalizations lookupMyLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return MyLocalizationsEn();
    case 'ru':
      return MyLocalizationsRu();
    case 'uz':
      return MyLocalizationsUz();
  }

  throw FlutterError(
    'MyLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
