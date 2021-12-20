import 'package:astro_talk/network/model/panchang_request.dart';

import 'astro_event.dart';

class GetLocationsEvent extends AstroEvent {
  final String inputPlace;

  GetLocationsEvent(this.inputPlace);
}
