import 'package:astro_talk/common/enums.dart';
import 'package:astro_talk/data/bloc/event/astro_event.dart';
import 'package:astro_talk/data/bloc/event/astrologer_event.dart';
import 'package:astro_talk/data/bloc/state/astro_state.dart';
import 'package:astro_talk/data/bloc/state/astrologer_state.dart';
import 'package:astro_talk/data/repo/api_data_repository.dart';
import 'package:astro_talk/data/repo/entities/astrologer_data.dart';
import 'package:astro_talk/network/model/base_reponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AstrologerBloc extends Bloc<AstroEvent, AstroState> {
  final ApiDataRepository _dataRepository = ApiDataRepository();

  final List<AstrologerInfo> _astrologerList = [];
  PublishSubject<String> astrologerSearchQuery = PublishSubject();

  AstrologerBloc() : super(const InitialState('')) {
    inputQueryListener();
    on<GetAstrologerEvent>(onGetAstrologer);
    on<ShowSearchBarEvent>(onShowSearchBar);
    on<SortAstrologerEvent>(onSortAstrologer);
    on<ShowSearchResultEvent>(onShowSearchResult);
    on<FilterAstrologerEvent>(onFilterAstrologer);
  }

  // Search Query Listener,
  // With debouncing and distinct logic implementation
  // To Perform search once after user stop writing with proper keywords
  void inputQueryListener() {
    astrologerSearchQuery
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen((searchQuery) {
      var query = searchQuery.trim().toLowerCase();

      List<AstrologerInfo> searchedList = _astrologerList.where((element) {
        var ifFName = (element.firstName ?? '').toLowerCase().contains(query);
        var ifLName = (element.lastName ?? '').toLowerCase().contains(query);
        var ifSkill = element.skills
                ?.where(
                    (skill) => (skill.name ?? '').toLowerCase().contains(query))
                .toList()
                .isNotEmpty ??
            false;
        var ifLanguage = element.languages
                ?.where((language) =>
                    (language.name ?? '').toLowerCase().contains(query))
                .toList()
                .isNotEmpty ??
            false;

        return ifFName || ifLName || ifSkill || ifLanguage;
      }).toList();

      add(ShowSearchResultEvent(astrologerList: searchedList));
    });
  }

  // This will find astrologer with max number of skills
  // To Prepare skill list for filter option
  List<Skills> getAllSkills() {
    AstrologerInfo astrologerInfo = _astrologerList.reduce(
        (a, b) => (a.skills ?? []).length > (b.skills ?? []).length ? a : b);
    return astrologerInfo.skills ?? [];
  }

  // This will find astrologer with max number of languages
  // To Prepare languages list for filter option
  List<Languages> getAllLanguages() {
    AstrologerInfo astrologerInfo = _astrologerList.reduce((a, b) =>
        (a.languages ?? []).length > (b.languages ?? []).length ? a : b);
    return astrologerInfo.languages ?? [];
  }

  Future<void> onGetAstrologer(
      GetAstrologerEvent event, Emitter<AstroState> emit) async {
    emit(const AstrologerStateLoading('Loading'));

    BaseResponse response = await _dataRepository.getAstrologer();

    if ((response.success ?? false) && response.data != null) {
      AstrologerData data = response.data;
      _astrologerList.clear();
      _astrologerList.addAll(data.data ?? []);
      emit(DisplayAstrologerState(_astrologerList, dateTime: DateTime.now()));
    } else {
      emit(AstrologerStateError(response.exception));
    }
  }

  Future<void> onShowSearchBar(
      ShowSearchBarEvent event, Emitter<AstroState> emit) async {
    if (!event.visibility) {
      // We are here means,
      // User wants to close search bar,
      // Hence will Clear Search Result
      emit(DisplayAstrologerState(_astrologerList, dateTime: DateTime.now()));
    }
    // Emitting search bar visibility state
    emit(ShowSearchBarState(event.visibility));
  }

  Future<void> onShowSearchResult(
      ShowSearchResultEvent event, Emitter<AstroState> emit) async {
    // Emitting searched (name, skills, language) astrologer list
    emit(
        DisplayAstrologerState(event.astrologerList, dateTime: DateTime.now()));
  }

  Future<void> onSortAstrologer(
      SortAstrologerEvent event, Emitter<AstroState> emit) async {
    List<AstrologerInfo> tempList = _astrologerList;

    // Here we have logic implementation,
    // To sort astrologer based on different sorting options

    if (event.sortOption == SortOption.priceHighToLow) {
      // Sorting Experience High => Low
      tempList.sort((a, b) => b
          .getMinimumCallDurationCharges()
          .compareTo(a.getMinimumCallDurationCharges()));
    } else if (event.sortOption == SortOption.priceLowToHigh) {
      // Sorting Price Low => High
      tempList.sort((a, b) => a
          .getMinimumCallDurationCharges()
          .compareTo(b.getMinimumCallDurationCharges()));
    } else if (event.sortOption == SortOption.experienceHighToLow) {
      // Sorting Experience High => Low
      tempList.sort((a, b) => b.getExperience().compareTo(a.getExperience()));
    } else if (event.sortOption == SortOption.experienceLowToHigh) {
      // Sorting Experience Low => High
      tempList.sort((a, b) => a.getExperience().compareTo(b.getExperience()));
    }

    // Emitting sorted astrologer list
    emit(DisplayAstrologerState(tempList, dateTime: DateTime.now()));
  }

  Future<void> onFilterAstrologer(
      FilterAstrologerEvent event, Emitter<AstroState> emit) async {
    List<AstrologerInfo> filteredList = _astrologerList.where((element) {
      // Here we have logic implementation,
      // To filter astrologer based on selected skills and language

      var ifLanguage = false;
      if (event.languages.isNotEmpty) {
        ifLanguage = (element.languages ?? [])
            .where((element) {
              return event.languages.contains(element.name);
            })
            .toList()
            .isNotEmpty;
      }

      var ifSkill = false;
      if (event.skills.isNotEmpty) {
        ifSkill = (element.skills ?? [])
            .where((element) {
              return event.skills.contains(element.name);
            })
            .toList()
            .isNotEmpty;
      }
      return ifSkill || ifLanguage;
    }).toList();

    // Emitting filtered astrologer list
    emit(DisplayAstrologerState(filteredList, dateTime: DateTime.now()));
  }
}
