import 'package:astro_talk/network/app_exception.dart';

import 'astro_state.dart';

class PanchangStateCompleted extends AstroState {
  const PanchangStateCompleted(data) : super(data);
}

class PanchangStateLoading extends AstroState {
  const PanchangStateLoading(String data) : super(data);
}

class PanchangStateError extends AstroState<AppException> {
  const PanchangStateError(data) : super(data);
}
