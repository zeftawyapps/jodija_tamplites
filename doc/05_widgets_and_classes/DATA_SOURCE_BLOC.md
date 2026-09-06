# 🧩 DataSourceBloc & State Management - Comprehensive Class Guide

---

### 🌐 Language / اللغة
[🇸🇦 **النسخة العربية (DATA_SOURCE_BLOC.ar.md)**](DATA_SOURCE_BLOC.ar.md) • [📖 **Tutorial (HOW_TO_USE.md)**](../HOW_TO_USE.md) • [📚 **Documentation Portal (README.md)**](../README.md)

---

## 1. What is `DataSourceBloc`?
**`DataSourceBloc<T>`** is a specialized Cubit state controller built upon `flutter_bloc` designed to eliminate boilerplate when managing async data fetching, mutations, and caching lifecycles.

Instead of writing custom events and multiple state subclasses for each feature, `DataSourceBloc` provides a clean four-phase finite state machine:
- **`init()`**: Idle initial state before request execution.
- **`loading()`**: Loading/fetching state (triggers progress indicators).
- **`success(data)`**: Successful completion state carrying typed payload `T`.
- **`failure(error, retryCallback)`**: Error handling state providing the error entity and an automatic retry callback.

---

## 2. Multi-Channel `FeaturDataSourceState`
For sophisticated screens requiring simultaneous tracking of separate async pipelines (e.g., collection browsing + single-item deletion + form submission feedback), `FeaturDataSourceState` provides 3 synchronized channels:
1. `listState`: Collection fetching and pagination state.
2. `itemState`: Single-record mutation state.
3. `feadState`: Interactive user feedback and submission response state.

---

## 3. Method & API Reference for `DataSourceBloc<T>`

| Method | Parameters | Description |
| :--- | :--- | :--- |
| `loadingState()` | None | Transitions state to `DataSourceBaseState.loading()`. |
| `successState([T? data])` | `T? data` | Emits `DataSourceBaseState.success(data)` and updates internal cache. |
| `failedState(error, callback)` | `ErrorStateModel, VoidCallback` | Transitions state to `DataSourceBaseState.failure(error, callback)`. |
| `data` (Getter) | None | Direct synchronous accessor for the latest cached payload without listening. |

---

## 4. Full Runnable Example

```dart
import 'package:flutter/material.dart';
import 'package:JoDija_tamplites/JoDija_tamplites.dart';

// 1. Presentation Model Definition
class OrderModel extends BaseViewDataModel {
  final String customerName;
  final double totalAmount;

  OrderModel({
    required String id,
    required this.customerName,
    required this.totalAmount,
  }) : super(id);
}

// 2. Orders Consumer Screen
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
    // Simulate remote network API or SQLite read
    Future.delayed(const Duration(milliseconds: 800), () {
      ordersBloc.successState([
        OrderModel(id: "101", customerName: "Acme Logistics Corp", totalAmount: 14500.0),
        OrderModel(id: "102", customerName: "Global Trade Inc", totalAmount: 8200.0),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders Management")),
      body: BlocBuilder<DataSourceBloc<List<OrderModel>>, DataSourceBaseState<List<OrderModel>>>(
        bloc: ordersBloc,
        builder: (context, state) {
          return state.when(
            init: () => const Center(child: Text("Waiting to initialize...")),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (orders) {
              if (orders == null || orders.isEmpty) {
                return const Center(child: Text("No orders found."));
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
                    subtitle: Text("Order Ref: #${order.id}"),
                    trailing: Text("\$${order.totalAmount}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  );
                },
              );
            },
            failure: (error, retry) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("An error occurred: ${error.message}"),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Retry Connection"),
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

## 5. Best Practices
- **Exhaustive pattern matching with `state.when`**: Guarantees all lifecycle states (`init`, `loading`, `success`, `failure`) are handled gracefully in the widget tree.
- **Provide via `BlocProvider`**: Use standard `BlocProvider` to pass `DataSourceBloc` down widget subtrees for multi-widget coordination.
