import 'package:JoDija_tamplites/util/data_souce_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class blocs extends StatefulWidget {
  const blocs({super.key});

  @override
  State<blocs> createState() => _blocsState();
}

class _blocsState extends State<blocs> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DataSourceBloc(), child: Container());
  }
}
