import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get title => 'مركز المساعدة';

  @override
  String get message_input_hint => 'إسال شيأ...';

  @override
  String get end_chat => 'إنهاء المحادثة';

  @override
  String get end_chat_desc => 'هل أنت متأكيد من إنهاء المحادثة؟';

  @override
  String get chat_button => 'تواصل معنا';

  @override
  String get ai_loading => 'نقوم بمعالجة طلبك...';

  @override
  String get active_chat => 'محادثة نشطة';

  @override
  String get active_chat_desc => 'لديك بالفعل محادثة نشطة، هل تريد إغلاقها؟';

  @override
  String get close => 'إغلاق';

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';
}
