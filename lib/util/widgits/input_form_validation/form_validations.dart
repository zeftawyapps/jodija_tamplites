import 'package:flutter/material.dart';

import 'input_validation_item.dart';

/// فئة مساعدة لإدارة نماذج الإدخال والتحقق من صحتها بسهولة.
/// A helper class to manage input forms and their validations easily.
class ValidationsForm {
  ValidationsForm(){

  }
  /// قائمة تحتوي على حقول الإدخال المرتبطة بهذا النموذج والتي تحتاج إلى تحقق.
  /// A list of input form fields associated with this form that need validation.
  List<InputValidationForm> inputValidationForm = [];
  
  /// خريطة لتخزين البيانات المستخرجة من النموذج بعد التحقق بنجاح.
  /// A map storing the extracted data from the form after successful validation.
  Map<String, dynamic>? dataMap;
  
  /// مفتاح عام للنموذج (FormKey) للتحكم في حالته (حفظ، تحقق، إلخ).
  /// A global key for the form to control its state (save, validate, etc.).
  GlobalKey<FormState> form = GlobalKey();


  /// يبني واجهة النموذج ويغلف العنصر (Widget) الممرر بداخله بـ Form.
  /// Builds the form interface and wraps the provided child widget with a Form.
  Widget build(
      BuildContext context, { required  Widget child}) {
    inputValidationForm.clear();
    return Container(
      child: Form(
        key: form,
        child:  child,
      ),
    );
  }

  /// يبني واجهة النموذج كـ عمود (Column) يحتوي على قائمة من العناصر، ويغلفها بـ Form.
  /// Builds the form interface as a Column containing a list of children, wrapped with a Form.
  Widget buildChildrenWithColumn(
      {required BuildContext context,
      required List<Widget> children,
      MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.center ,
      CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center,
      }) {
    inputValidationForm.clear();
    return Container(
      child: Form(
        key: form,
        child: Container(
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
           crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,

            children: children,
          ),
        ),
      ),
    );
  }
  /// يقوم بالتحقق من صحة المدخلات (Validate)، وإذا كانت صحيحة يقوم بحفظها وإرجاعها كخريطة (Map).
  /// Validates the inputs, and if valid, saves them and returns the data as a Map.
  Map<String, dynamic> getInputData() {
    Map<String, dynamic> dataMap = Map();
    if (form.currentState!.validate()) {
      form.currentState!.save();
      inputValidationForm.map((e) {
        if (e.mapValue != null) {
          dataMap[e.keyData] = e.mapValue![e.keyData];
        }
      }).toList();
    } else {
      debugPrint("================ ValidationsForm Error ================");
      debugPrint("Validation failed for the form.");
      debugPrint("Checking fields state:");
      for (var field in inputValidationForm) {
        debugPrint("Field Key: ${field.keyData}");
        debugPrint("Label: ${field.labalText}");
        debugPrint("Current Value in map: ${field.mapValue?[field.keyData]}");
        debugPrint("-------------------------------------------------------");
      }
      debugPrint("=======================================================");
    }

    return dataMap;
  }
  /// مسح جميع البيانات المدخلة في النموذج وإعادة تعيين الحقول.
  /// Clear all entered data in the form and reset the fields.
  void clearData() {
    inputValidationForm.map((e) {
      if (e.mapValue != null) {
        e.mapValue![e.keyData] = null;
      }
    }).toList();
    dataMap = null;
  }
}
