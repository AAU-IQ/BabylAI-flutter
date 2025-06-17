// ignore: unused_import
import 'package:intl/intl.dart' as intl;
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
  String get end_chat => 'مغادرة المحادثة؟ 👋';

  @override
  String get end_chat_desc => 'لا تقلق، يمكنك العودة في أي وقت. نحن دائماً هنا إذا كنت بحاجة إلى مساعدة أو لديك أسئلة.';

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

  @override
  String get error_message => 'حدثت مشكلة في الاتصال بالخدمة. يرجى التحقق من اتصالك والمحاولة مرة أخرى.';

  @override
  String get error_title => 'تعذر تحميل المحتوى';

  @override
  String get try_again => 'اعد المحاولة';
}
