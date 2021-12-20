import 'package:astro_talk/network/app_exception.dart';

import 'astro_state.dart';

class DisplayAstrologerState extends AstroState {
  final DateTime? dateTime;

  const DisplayAstrologerState(data, {this.dateTime}) : super(data);

  @override
  List<Object?> get props => [data, dateTime];
}

class AstrologerStateLoading extends AstroState<String> {
  const AstrologerStateLoading(String data) : super(data);
}

class AstrologerStateError extends AstroState<AppException> {
  const AstrologerStateError(data) : super(data);
}

class ShowSearchBarState extends AstroState<bool> {
  const ShowSearchBarState(data) : super(data);
}
