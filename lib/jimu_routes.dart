import 'package:flutter/material.dart';

import 'package:alimentos/alimentos.dart';

Map<String, WidgetBuilder> jimuRoutes() {
  return <String, WidgetBuilder>{
    '/alimentos': (BuildContext context) => const AlimentosTela(),
  };
}
