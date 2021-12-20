import 'package:equatable/equatable.dart';

abstract class AstroState<T> extends Equatable {
  final T data;

  const AstroState(this.data);

  @override
  List<Object?> get props => [data];
}

class InitialState extends AstroState {
  const InitialState(data) : super(data);
}
