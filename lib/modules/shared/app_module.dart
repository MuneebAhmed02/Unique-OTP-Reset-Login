import 'package:flutter_modular/flutter_modular.dart';
import 'package:unique/modules/shared/controllers/app_controller.dart';
import '../login/login_module.dart';
import 'presentation/pages/pages.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashPage()),
        ModuleRoute('/login', module: LoginModule()),
      ];
}
