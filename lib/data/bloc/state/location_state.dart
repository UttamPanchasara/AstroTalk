import 'astro_state.dart';

class LocationStateCompleted extends AstroState {
  const LocationStateCompleted(data) : super(data);
}

class LocationStateLoading extends AstroState<String> {
  const LocationStateLoading(String data) : super(data);
}

class LocationStateError extends AstroState<String> {
  const LocationStateError(data) : super(data);
}
