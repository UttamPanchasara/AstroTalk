import 'package:astro_talk/data/bloc/event/astro_event.dart';
import 'package:astro_talk/data/bloc/event/location_event.dart';
import 'package:astro_talk/data/bloc/state/astro_state.dart';
import 'package:astro_talk/data/bloc/state/location_state.dart';
import 'package:astro_talk/data/repo/api_data_repository.dart';
import 'package:astro_talk/network/model/base_reponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LocationBloc extends Bloc<AstroEvent, AstroState> {
  final ApiDataRepository _dataRepository = ApiDataRepository();
  PublishSubject<String> locationInputQuery = PublishSubject();

  LocationBloc() : super(const InitialState('')) {
    inputQueryListener();
    on<GetLocationsEvent>(onGetLocations);
  }

  void inputQueryListener() {
    locationInputQuery
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((query) {
      add(GetLocationsEvent(query));
    });
  }

  Future<void> onGetLocations(
      GetLocationsEvent event, Emitter<AstroState> emit) async {
    emit(const LocationStateLoading('Loading'));

    BaseResponse response = await _dataRepository.getLocation(
      inputPlace: event.inputPlace,
    );

    if ((response.success ?? false) && response.data != null) {
      emit(LocationStateCompleted(response.data));
    } else {
      emit(LocationStateError(response.exception));
    }
  }
}
