# 📸 Image Management Widgets (BlocImagePicker & ImageLoader)

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (IMAGE_PICKER_AND_LOADER.ar.md)**](IMAGE_PICKER_AND_LOADER.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. Overview
`JoDija Templates` provides streamlined widgets for image acquisition, cropping, and resilient network loading:
- **`BlocImagePicker`**: Interactive widget facilitating image capture via device camera or gallery, bundled with integrated cropping workflows (`image_cropper`).
- **`ImageLoader`**: Resilient image widget handling local asset bundles and remote URLs with integrated loading indicators and error fallback widgets.

---

## 2. Full Runnable Example: Profile Avatar Capture

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
          borderRadius: 60, // Circular profile avatar
          onImageSelected: (path) {
            setState(() => selectedImagePath = path);
            print("Selected Image File Path: $path");
          },
        ),
        const SizedBox(height: 8),
        const Text("Tap to select and crop avatar"),
      ],
    );
  }
}
```
