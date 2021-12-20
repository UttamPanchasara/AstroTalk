import 'package:astro_talk/network/model/panchang_request.dart';

import 'astro_event.dart';

class GetPanchangEvent extends AstroEvent {
  final PanchangRequest requestData;

  GetPanchangEvent({required this.requestData});
}