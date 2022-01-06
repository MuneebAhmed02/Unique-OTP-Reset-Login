import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  _AppControllerBase() {
    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.pushReplacementNamed('/login');
    });
  }
}
