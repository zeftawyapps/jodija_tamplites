# 🧩 كلاس DataSourceBloc وإدارة الحالة - الدليل التطبيقي الكامل

---

### 🌐 اللغة / Language
[🇺🇸 **English Version (DATA_SOURCE_BLOC.md)**](DATA_SOURCE_BLOC.md) • [📖 **دليل الاستخدام (HOW_TO_USE.ar.md)**](../HOW_TO_USE.ar.md) • [📚 **بوابة التوثيق (README.ar.md)**](../README.ar.md)

---

## 1. ما هو كلاس `DataSourceBloc`؟
**`DataSourceBloc<T>`** هو كلاس Cubit متخصص مبني فوق مكتبة `flutter_bloc` لإلغاء التعقيد وتكرار الكود عند التعامل مع مصادر البيانات والعمليات غير المتزامنة (Async operations).

بدلاً من كتابة أحداث (Events) وحالات مخصصة لكل شاشة، يوفر `DataSourceBloc` دورة حياة قياسية:
- **`init()`**: الحالة الأولية قبل بدء التحميل.
- **`loading()`**: حالة انتظار جلب أو تحديث البيانات (عرض المؤشر).
- **`success(data)`**: حالة النجاح مع تمرير البيانات من النوع `T`.
- **`failure(error, retryCallback)`**: حالة حدوث خطأ مع كائن الخطأ ودالة إعادة المحاولة تلقائياً.

---

## 2. كلاس الحالات المجمعة `FeaturDataSourceState`
للشاشات المعقدة التي تحتاج لمتابعة أكثر من عملية في نفس الوقت (مثل جلب قائمة + عملية حذف عنصر + إرسال نموذج)، يوفر كلاس `FeaturDataSourceState` ثلاث قنوات متزامنة:
1. `listState`: حالة قائمة العناصر المجمعة.
2. `itemState`: حالة عنصر محدد للعمليات الفردية.
3. `feadState`: حالة العمليات التفاعلية وردود الأفعال (Feedback).

---

## 3. دوال وطرق كلاس `DataSourceBloc<T>`

| الدالة | المعاملات | الوصف |
| :--- | :--- | :--- |
| `loadingState()` | لا يوجد | تصدر حالة `DataSourceBaseState.loading()`. |
| `successState([T? data])` | `T? data` | تصدر حالة `DataSourceBaseState.success(data)` وتحدث الكاش `data`. |
| `failedState(error, callback)` | `ErrorStateModel, VoidCallback` | تصدر حالة الفشل مع دالة إعادة المحاولة. |
| `data` (Getter) | لا يوجد | استرجاع البيانات المحفوظة حالياً دون الحاجة للاستماع للحالة. |

---

## 4. كود تطبيقي كامل جاهز للتشغيل (Full Runnable Example)

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

// 1. تعريف نموذج البيانات
class OrderModel extends BaseViewDataModel {
  final String customerName;
  final double totalAmount;

  OrderModel({
    required String id,
    required this.customerName,
    required this.totalAmount,
  }) : super(id);
}

// 2. شاشة عرض الطلبات
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final DataSourceBloc<List<OrderModel>> ordersBloc;

  @override
  void initState() {
    super.initState();
    ordersBloc = DataSourceBloc<List<OrderModel>>();
    fetchOrders();
  }

  void fetchOrders() {
    ordersBloc.loadingState();
    // محاكاة استدعاء API أو قاعدة بيانات
    Future.delayed(const Duration(milliseconds: 800), () {
      ordersBloc.successState([
        OrderModel(id: "101", customerName: "شركة الأمل للتجارة", totalAmount: 14500.0),
        OrderModel(id: "102", customerName: "مؤسسة النور الدولية", totalAmount: 8200.0),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة الطلبات")),
      body: BlocBuilder<DataSourceBloc<List<OrderModel>>, DataSourceBaseState<List<OrderModel>>>(
        bloc: ordersBloc,
        builder: (context, state) {
          return state.when(
            init: () => const Center(child: Text("في انتظار بدء التحميل...")),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (orders) {
              if (orders == null || orders.isEmpty) {
                return const Center(child: Text("لا توجد طلبات مسجلة"));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.receipt)),
                    title: Text(order.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("رقم الطلب: #${order.id}"),
                    trailing: Text("${order.totalAmount} ج.م", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  );
                },
              );
            },
            failure: (error, retry) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("حدث خطأ: ${error.message}"),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text("إعادة المحاولة"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

---

## 5. أفضل الممارسات
- **استخدام `state.when`**: تضمن معالجة كافة الحالات الأربع (`init`, `loading`, `success`, `failure`) دون إغفال أي حالة في واجهة المستخدم.
- **إعادة استخدام الـ Bloc**: يمكنك حفظ الـ Bloc في مزود `BlocProvider` لمشاركته عبر ودجات متعددة في نفس الشاشة.
