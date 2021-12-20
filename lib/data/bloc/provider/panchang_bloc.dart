import 'package:astro_talk/data/bloc/event/astro_event.dart';
import 'package:astro_talk/data/bloc/event/panchang_event.dart';
import 'package:astro_talk/data/bloc/state/astro_state.dart';
import 'package:astro_talk/data/bloc/state/panchang_state.dart';
import 'package:astro_talk/data/repo/api_data_repository.dart';
import 'package:astro_talk/network/model/base_reponse.dart';
import 'package:astro_talk/network/model/panchang_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PanchangBloc extends Bloc<AstroEvent, AstroState> {
  final ApiDataRepository _dataRepository = ApiDataRepository();

  BehaviorSubject<DateTime> selectedDate = BehaviorSubject();
  BehaviorSubject<String> selectedPlaceId = BehaviorSubject();

  PanchangBloc() : super(const InitialState('')) {
    selectedDate.add(DateTime.now());
    on<GetPanchangEvent>(onGetPanchang);
  }

  Future<void> onGetPanchang(
      GetPanchangEvent event, Emitter<AstroState> emit) async {
    emit(const PanchangStateLoading('Loading'));

    BaseResponse response = await _dataRepository.getDailyPanchang(
      request: event.requestData,
    );

    if ((response.success ?? false) && response.data != null) {
      emit(PanchangStateCompleted(response.data));
    } else {
      emit(PanchangStateError(response.exception));
    }
  }

  void getPanchang() {
    if (selectedDate.hasValue &&
        (selectedPlaceId.hasValue && selectedPlaceId.value.isNotEmpty)) {
      add(GetPanchangEvent(
          requestData: PanchangRequest(
        day: selectedDate.value.day,
        month: selectedDate.value.month,
        placeId: selectedPlaceId.value,
        year: selectedDate.value.year,
      )));
    }
  }
}
