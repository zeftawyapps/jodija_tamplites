# ✅ Form Validation Architecture (ValidationsForm & Validators)

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (FORM_VALIDATION.ar.md)**](FORM_VALIDATION.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. Overview
The form validation subsystem in `JoDija Templates` decouples field validation from raw widget lifecycles:
- **`ValidationsForm`**: Form coordinator tracking all attached input items and triggering global validation via `form.valdate()`.
- **`BaseValidator`**: Abstract rule strategy interface facilitating easy implementation of custom validation criteria.
- **Built-in Validators**: `RequiredValidator`, `EmailValidator`, `PasswordValidator`, `NumperValidator`, and `DateValidator`.

---

## 2. Built-In Validator Reference

| Validator | Description | Parameters |
| :--- | :--- | :--- |
| `RequiredValidator` | Ensures string input is not empty or whitespace. | `customMessage` (optional) |
| `EmailValidator` | Enforces standard RFC email regex format. | `message` (optional) |
| `PasswordValidator` | Validates password character length constraints. | `minLength` (default: 6), `maxLength` (default: 20) |
| `NumperValidator` | Verifies value parses to valid numeric type. | `message` (optional) |

---

## 3. Full Runnable Example

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
    // Validate all registered input items in one invocation
    if (form.valdate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Validation passed! Logging in...")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please correct invalid input fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Authentication")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 1. Email field with chainable validators
            TextFormValidation(
              controller: emailController,
              label: "Email Address",
              hint: "user@example.com",
              validationsForm: form,
              validators: [
                RequiredValidator(customMessage: "Please enter your email address"),
                EmailValidator(),
              ],
            ),
            const SizedBox(height: 16),

            // 2. Password field
            TextFormValidation(
              controller: passwordController,
              label: "Password",
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
              child: const Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
```
