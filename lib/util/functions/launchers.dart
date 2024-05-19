import 'package:url_launcher/url_launcher.dart';

class Loauncherurl {
  static void sendWhatsapp(String countryCode ,   String phoneNumber , String massage) {
    launch(
        'https://wa.me/$countryCode$phoneNumber?text=$massage');
  }
}