class PanchangData {
  PanchangInfo? data;

  PanchangData({required this.data});

  PanchangData.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? PanchangInfo.fromJson(json['data']) : null)!;
  }
}

class PanchangInfo {
  String? day;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? vedicSunrise;
  String? vedicSunset;
  Tithi? tithi;
  Nakshatra? nakshatra;
  Yog? yog;
  Karan? karan;
  HinduMaah? hinduMaah;
  String? paksha;
  String? ritu;
  String? sunSign;
  String? moonSign;
  String? ayana;
  String? panchangYog;
  int? vikramSamvat;
  int? shakaSamvat;
  String? vkramSamvatName;
  String? shakaSamvatName;
  String? dishaShool;
  String? dishaShoolRemedies;
  NakShool? nakShool;
  String? moonNivas;
  AbhijitMuhurta? abhijitMuhurta;
  AbhijitMuhurta? rahukaal;
  AbhijitMuhurta? guliKaal;
  AbhijitMuhurta? yamghantKaal;

  PanchangInfo(
      {this.day,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.vedicSunrise,
      this.vedicSunset,
      this.tithi,
      this.nakshatra,
      this.yog,
      this.karan,
      this.hinduMaah,
      this.paksha,
      this.ritu,
      this.sunSign,
      this.moonSign,
      this.ayana,
      this.panchangYog,
      this.vikramSamvat,
      this.shakaSamvat,
      this.vkramSamvatName,
      this.shakaSamvatName,
      this.dishaShool,
      this.dishaShoolRemedies,
      this.nakShool,
      this.moonNivas,
      this.abhijitMuhurta,
      this.rahukaal,
      this.guliKaal,
      this.yamghantKaal});

  PanchangInfo.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    vedicSunrise = json['vedic_sunrise'];
    vedicSunset = json['vedic_sunset'];
    tithi = json['tithi'] != null ? Tithi.fromJson(json['tithi']) : null;
    nakshatra = json['nakshatra'] != null
        ? Nakshatra.fromJson(json['nakshatra'])
        : null;
    yog = json['yog'] != null ? Yog.fromJson(json['yog']) : null;
    karan = json['karan'] != null ? Karan.fromJson(json['karan']) : null;
    hinduMaah = json['hindu_maah'] != null
        ? HinduMaah.fromJson(json['hindu_maah'])
        : null;
    paksha = json['paksha'];
    ritu = json['ritu'];
    sunSign = json['sun_sign'];
    moonSign = json['moon_sign'];
    ayana = json['ayana'];
    panchangYog = json['panchang_yog'];
    vikramSamvat = json['vikram_samvat'];
    shakaSamvat = json['shaka_samvat'];
    vkramSamvatName = json['vkram_samvat_name'];
    shakaSamvatName = json['shaka_samvat_name'];
    dishaShool = json['disha_shool'];
    dishaShoolRemedies = json['disha_shool_remedies'];
    nakShool =
        json['nak_shool'] != null ? NakShool.fromJson(json['nak_shool']) : null;
    moonNivas = json['moon_nivas'];
    abhijitMuhurta = json['abhijit_muhurta'] != null
        ? AbhijitMuhurta.fromJson(json['abhijit_muhurta'])
        : null;
    rahukaal = json['rahukaal'] != null
        ? AbhijitMuhurta.fromJson(json['rahukaal'])
        : null;
    guliKaal = json['guliKaal'] != null
        ? AbhijitMuhurta.fromJson(json['guliKaal'])
        : null;
    yamghantKaal = json['yamghant_kaal'] != null
        ? AbhijitMuhurta.fromJson(json['yamghant_kaal'])
        : null;
  }
}

class Tithi {
  TithiDetails? details;
  EndTime? endTime;
  int? endTimeMs;

  Tithi({this.details, this.endTime, this.endTimeMs});

  Tithi.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? TithiDetails.fromJson(json['details']) : null;
    endTime =
        json['end_time'] != null ? EndTime.fromJson(json['end_time']) : null;
    endTimeMs = json['end_time_ms'];
  }
}

class TithiDetails {
  int? tithiNumber;
  String? tithiName;
  String? special;
  String? summary;
  String? deity;

  TithiDetails(
      {this.tithiNumber,
      this.tithiName,
      this.special,
      this.summary,
      this.deity});

  TithiDetails.fromJson(Map<String, dynamic> json) {
    tithiNumber = json['tithi_number'];
    tithiName = json['tithi_name'];
    special = json['special'];
    summary = json['summary'];
    deity = json['deity'];
  }
}

class Nakshatra {
  NakDetails? details;
  EndTime? endTime;
  int? endTimeMs;

  Nakshatra({this.details, this.endTime, this.endTimeMs});

  Nakshatra.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? NakDetails.fromJson(json['details']) : null;
    endTime =
        json['end_time'] != null ? EndTime.fromJson(json['end_time']) : null;
    endTimeMs = json['end_time_ms'];
  }
}

class NakDetails {
  int? nakNumber;
  String? nakName;
  String? ruler;
  String? deity;
  String? special;
  String? summary;

  NakDetails(
      {this.nakNumber,
      this.nakName,
      this.ruler,
      this.deity,
      this.special,
      this.summary});

  NakDetails.fromJson(Map<String, dynamic> json) {
    nakNumber = json['nak_number'];
    nakName = json['nak_name'];
    ruler = json['ruler'];
    deity = json['deity'];
    special = json['special'];
    summary = json['summary'];
  }
}

class Yog {
  YogDetails? details;
  EndTime? endTime;
  int? endTimeMs;

  Yog({this.details, this.endTime, this.endTimeMs});

  Yog.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? YogDetails.fromJson(json['details']) : null;
    endTime =
        json['end_time'] != null ? EndTime.fromJson(json['end_time']) : null;
    endTimeMs = json['end_time_ms'];
  }
}

class YogDetails {
  int? yogNumber;
  String? yogName;
  String? special;
  String? meaning;

  YogDetails({this.yogNumber, this.yogName, this.special, this.meaning});

  YogDetails.fromJson(Map<String, dynamic> json) {
    yogNumber = json['yog_number'];
    yogName = json['yog_name'];
    special = json['special'];
    meaning = json['meaning'];
  }
}

class Karan {
  KaranDetails? details;
  EndTime? endTime;
  int? endTimeMs;

  Karan({this.details, this.endTime, this.endTimeMs});

  Karan.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? KaranDetails.fromJson(json['details']) : null;
    endTime =
        json['end_time'] != null ? EndTime.fromJson(json['end_time']) : null;
    endTimeMs = json['end_time_ms'];
  }
}

class KaranDetails {
  int? karanNumber;
  String? karanName;
  String? special;
  String? deity;

  KaranDetails({this.karanNumber, this.karanName, this.special, this.deity});

  KaranDetails.fromJson(Map<String, dynamic> json) {
    karanNumber = json['karan_number'];
    karanName = json['karan_name'];
    special = json['special'];
    deity = json['deity'];
  }
}

class EndTime {
  int? hour;
  int? minute;
  int? second;

  EndTime({this.hour, this.minute, this.second});

  EndTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
  }
}

class HinduMaah {
  bool? adhikStatus;
  String? purnimanta;
  String? amanta;
  int? amantaId;
  int? purnimantaId;

  HinduMaah(
      {this.adhikStatus,
      this.purnimanta,
      this.amanta,
      this.amantaId,
      this.purnimantaId});

  HinduMaah.fromJson(Map<String, dynamic> json) {
    adhikStatus = json['adhik_status'];
    purnimanta = json['purnimanta'];
    amanta = json['amanta'];
    amantaId = json['amanta_id'];
    purnimantaId = json['purnimanta_id'];
  }
}

class NakShool {
  String? direction;
  String? remedies;

  NakShool({this.direction, this.remedies});

  NakShool.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    remedies = json['remedies'];
  }
}

class AbhijitMuhurta {
  String? start;
  String? end;

  AbhijitMuhurta({this.start, this.end});

  AbhijitMuhurta.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }
}
