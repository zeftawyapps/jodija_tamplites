# 📸 ودجات وإدارة الصور (BlocImagePicker & ImageLoader)

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (IMAGE_PICKER_AND_LOADER.md)**](IMAGE_PICKER_AND_LOADER.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. نظرة عامة
توفر الحزمة ودجات متطورة لمعالجة واختيار وعرض الصور:
- **`BlocImagePicker`**: ودجة تفاعلية تتيح للمستخدم التقاط الصور من الكاميرا أو اختيارها من المعرض، مع دعم مدمج لقص الصور (`image_cropper`).
- **`ImageLoader`**: عارض صور ذكي يتعامل مع الصور المحلية (Assets) وروابط الإنترنت مع مؤشر تحميل مدمج ومعالجة الأخطاء.

---

## 2. كود تطبيقي لاختيار وقص الصور (BlocImagePicker)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class ProfileImageUploadWidget extends StatefulWidget {
  const ProfileImageUploadWidget({super.key});

  @override
  State<ProfileImageUploadWidget> createState() => _ProfileImageUploadWidgetState();
}

class _ProfileImageUploadWidgetState extends State<ProfileImageUploadWidget> {
  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocImagePicker(
          width: 120,
          height: 120,
          borderRadius: 60, // شكل دائري لصورة الحساب
          onImageSelected: (path) {
            setState(() => selectedImagePath = path);
            print("مسار الصورة المحددة: $path");
          },
        ),
        const SizedBox(height: 8),
        const Text("اضغط لتغيير الصورة الشخصية"),
      ],
    );
  }
}
```
