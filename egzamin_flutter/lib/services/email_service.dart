import 'package:egzamin_flutter/constants.dart';
import 'package:egzamin_flutter/services/notification_service.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  Future sendData(String data) async {
    String username = Constants.emailUser;
    String password = Constants.emailPassword;

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username,)
      ..recipients.add('tomisltu@gmail.com')
      ..ccRecipients.addAll(['darius.zabulionis@gmail.com',])
      ..subject = 'Test Ismanieji Egzaminas. T.B. :: 😀 :: ${DateTime.now()}'
      ..text = data;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      LocalNotifications notifications = LocalNotifications();
      notifications.notifyEmailSent();
    } on MailerException catch (e) {
      print(e.toString());
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}