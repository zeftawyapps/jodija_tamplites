# ✅ نظام التحقق من صحة النماذج (ValidationsForm & Validators)

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (FORM_VALIDATION.md)**](FORM_VALIDATION.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. نظرة عامة
توفر الحزمة نظاماً معمارياً مرناً للتحقق من المدخلات يعتمد على:
- **`ValidationsForm`**: مدير النموذج الذي يحتفظ بكافة الحقول ويقوم بفحصها بضغطة زر واحدة عبر `form.valdate()`.
- **`BaseValidator`**: الواجهة التجريدية التي ترث منها كافة المحققات وتسمح ببناء قواعد تحقق مخصصة.
- المحققات الجاهزة: `RequiredValidator`, `EmailValidator`, `PasswordValidator`, `NumperValidator`, و `DateValidator`.

---

## 2. جدول المحققات الجاهزة (Built-In Validators)

| المحقق | الوصف | المعاملات |
| :--- | :--- | :--- |
| `RequiredValidator` | التحقق من عدم ترك الحقل فارغاً. | `customMessage` (اختياري) |
| `EmailValidator` | التحقق من مطابقة نمط البريد الإلكتروني. | `message` (اختياري) |
| `PasswordValidator` | التحقق من طول وقوة كلمة المرور. | `minLength` (افتراضي 6), `maxLength` (افتراضي 20) |
| `NumperValidator` | التحقق من أن القيمة المدخلة رقم صالح. | `message` (اختياري) |

---

## 3. كود تطبيقي كامل جاهز للتشغيل (Full Runnable Example)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final form = ValidationsForm();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin() {
    // فحص كافة الحقول المسجلة في النموذج دفعة واحدة
    if (form.valdate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("البيانات صحيحة تماماً! جاري تسجيل الدخول...")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى مراجعة البيانات المدخلة وتصحيح الأخطاء")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل الدخول")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 1. حقل البريد مع محققات مدمجة
            TextFormValidation(
              controller: emailController,
              label: "البريد الإلكتروني",
              hint: "user@example.com",
              validationsForm: form,
              validators: [
                RequiredValidator(customMessage: "يرجى كتابة البريد الإلكتروني"),
                EmailValidator(),
              ],
            ),
            const SizedBox(height: 16),

            // 2. حقل كلمة المرور
            TextFormValidation(
              controller: passwordController,
              label: "كلمة المرور",
              isPassword: true,
              validationsForm: form,
              validators: [
                RequiredValidator(),
                PasswordValidator(minLength: 8),
              ],
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: handleLogin,
              child: const Text("تسجيل الدخول"),
            ),
          ],
        ),
      ),
    );
  }
}
```
