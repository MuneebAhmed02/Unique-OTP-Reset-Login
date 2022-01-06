import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/pages.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => LoginPage(),
        ),
      ];
}
