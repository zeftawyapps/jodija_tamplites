import 'package:JoDija_view/util/data_souce_bloc/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScreenStateBlocNotifier extends ChangeNotifier {
  late BuildContext context;
  late Function fuction;
  List<DataSourceBloc>blocs = [];

  @override
  void createproviers(BuildContext contxt);


List<BlocProvider> blocProviders = [];



  void notify(){
    notifyListeners();
  }



}
