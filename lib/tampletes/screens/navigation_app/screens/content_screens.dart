import 'package:flutter/material.dart';

/// شاشة المحتوى الرئيسية
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 80, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              "الصفحة الرئيسية",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("مرحبا بك في الصفحة الرئيسية", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/// شاشة محتوى الملف الشخصي
class ProfileContent extends StatelessWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade50,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text(
              "الملف الشخصي",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "هنا يمكنك عرض وتعديل معلوماتك الشخصية",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

/// شاشة محتوى الإعدادات
class SettingsContent extends StatelessWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple.shade50,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 80, color: Colors.purple),
            SizedBox(height: 16),
            Text(
              "الإعدادات",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "يمكنك تخصيص إعدادات التطبيق هنا",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

/// شاشة محتوى الإشعارات
class NotificationsContent extends StatelessWidget {
  const NotificationsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade50,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications, size: 80, color: Colors.amber),
            SizedBox(height: 16),
            Text(
              "الإشعارات",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("هنا ستجد كل إشعاراتك", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/// شاشة محتوى الرسائل
class MessagesContent extends StatelessWidget {
  const MessagesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 80, color: Colors.red),
            SizedBox(height: 16),
            Text(
              "الرسائل",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "يمكنك هنا قراءة وإرسال الرسائل",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
