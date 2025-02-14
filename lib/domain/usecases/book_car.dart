import 'package:url_launcher/url_launcher.dart';

class BookCar {
  Future<void> call(String phoneNo) async {
    final Uri dialerUri = Uri.parse('tel:$phoneNo');
    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      throw 'Could not launch dialer for $phoneNo';
    }
  }
}
