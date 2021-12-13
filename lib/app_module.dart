import 'package:flutter_modular/flutter_modular.dart';
import 'package:payment_gateway/pages/home_page.dart';
import 'package:payment_gateway/utils/app_string.dart';

class AppModule extends Module{
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(AppString.homePage,child: (context, args) => const HomePage()),
  ];
}