import 'package:equatable/equatable.dart';

abstract class JimuState extends Equatable {
  const JimuState();
}

abstract class JimuStateFalha extends JimuState {
  final String erroMsg;

  const JimuStateFalha(this.erroMsg);
}
