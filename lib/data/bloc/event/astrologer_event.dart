import 'package:astro_talk/common/enums.dart';
import 'package:astro_talk/data/repo/entities/astrologer_data.dart';

import 'astro_event.dart';

class GetAstrologerEvent extends AstroEvent {
  GetAstrologerEvent();
}

class ShowSearchBarEvent extends AstroEvent {
  final bool visibility;

  ShowSearchBarEvent({this.visibility = false});
}

class ShowSearchResultEvent extends AstroEvent {
  final List<AstrologerInfo> astrologerList;

  ShowSearchResultEvent({required this.astrologerList});
}

class SortAstrologerEvent extends AstroEvent {
  final SortOption sortOption;

  SortAstrologerEvent({required this.sortOption});
}

class FilterAstrologerEvent extends AstroEvent {
  final List<String> skills;
  final List<String> languages;

  FilterAstrologerEvent({required this.skills, required this.languages});
}
