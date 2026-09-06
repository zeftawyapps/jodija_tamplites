# ⚙️ CellFieldBuilder & Dynamic Form Binding - Comprehensive Guide

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (CELL_FIELD_BUILDER.ar.md)**](CELL_FIELD_BUILDER.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. What is `CellFieldBuilder`?
**`CellFieldBuilder`** is the dynamic form generation engine in `JoDija Templates` that translates model `Cell` definitions directly into interactive UI input widgets (`Field` and `TextFormValidation`) bound to a central `ValidationsForm`.

Instead of manually wiring dozens of `TextEditingController` instances, focus nodes, and validation predicates, `CellFieldBuilder` reads:
- `CellDataType` to render the correct input widget (text, numeric, calendar date, or select dropdown).
- `isRequired` flag to automatically attach `RequiredValidator`.
- `caption` and `hint` to construct consistent InputDecoration styling.

---

## 2. API & Method Reference

| Method | Parameters | Description |
| :--- | :--- | :--- |
| `buildField(...)` | `Cell, ValidationsForm, onChanged` | Builds a single reactive `Field` container bound to the form manager. |
| `buildFormFields(...)` | `List<Cell>, ValidationsForm` | Batch-generates form input widgets for an entire row of cells. |

---

## 3. Full Runnable Example

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

class CustomerEntryFormScreen extends StatefulWidget {
  const CustomerEntryFormScreen({super.key});

  @override
  State<CustomerEntryFormScreen> createState() => _CustomerEntryFormScreenState();
}

class _CustomerEntryFormScreenState extends State<CustomerEntryFormScreen> {
  final formManager = ValidationsForm();

  late final Field nameField;
  late final Field phoneField;
  late final Field countryField;

  @override
  void initState() {
    super.initState();

    // 1. Generate fields via CellFieldBuilder
    nameField = CellFieldBuilder.buildField(
      cell: Cell<String>(
        "customer_name",
        caption: "Customer Name",
        isRequired: true,
        hint: "Enter full customer name",
      ),
      form: formManager,
    );

    phoneField = CellFieldBuilder.buildField(
      cell: Cell<String>(
        "phone",
        caption: "Phone Number",
        type: CellDataType.number,
        isRequired: true,
        hint: "+1 (555) 000-0000",
      ),
      form: formManager,
    );

    countryField = CellFieldBuilder.buildField(
      cell: Cell<String>(
        "country",
        caption: "Country",
        type: CellDataType.dropdown,
        options: ["United States", "United Kingdom", "Egypt", "Saudi Arabia"],
        value: "United States",
        isRequired: true,
      ),
      form: formManager,
    );
  }

  void submitForm() {
    // 2. Validate all bound fields in one invocation
    if (formManager.valdate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All inputs valid! Form submitted successfully.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please correct invalid form fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Customer")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            nameField.textFormValidation,
            const SizedBox(height: 16),
            phoneField.textFormValidation,
            const SizedBox(height: 16),
            countryField.textFormValidation,
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: submitForm,
                child: const Text("Save Customer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
