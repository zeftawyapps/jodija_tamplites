// add get it locator
import 'package:get_it/get_it.dart';

var joDijaLocator = GetIt.instance;

abstract class ILocator {
  Future<void> setupLocator() async {
    await _setUpBloc();

    //! Repo
    await _setUpRepository();
    //! DataSource
    await _setUpDatasource();
    //! Utils
    await _setUpUtils();
    //!External
    await _setUpExternal();
  }

  // add future to this method
  Future<void> _setUpBloc();
  Future<void> _setUpRepository();
  Future<void> _setUpDatasource();
  Future<void> _setUpUtils();
  Future<void> _setUpExternal();
}
