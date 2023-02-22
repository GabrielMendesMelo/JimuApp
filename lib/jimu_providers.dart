import 'package:alimentos/alimentos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JimuProviders extends StatelessWidget {
  final Widget? child;

  const JimuProviders({
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ignore: always_specify_types
      providers: [
        BlocProvider<AlimentosBloc>(
          create: (BuildContext context) => AlimentosBloc()
            ..add(
              AlimentosCarregouAlimentos(),
            ),
        ),
      ],
      child: child ??
          const Scaffold(
            body: Center(
              child: Text('ERRO EM PROVIDERS'),
            ),
          ),
    );
  }
}
