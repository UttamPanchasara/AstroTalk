class AstrologerData {
  List<AstrologerInfo>? data;

  AstrologerData({required this.data});

  AstrologerData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AstrologerInfo>[];
      json['data'].forEach((v) {
        data?.add(AstrologerInfo.fromJson(v));
      });
    }
  }
}

class AstrologerInfo {
  int? id;
  String? urlSlug;
  String? namePrefix;
  String? firstName;
  String? lastName;
  String? aboutMe;
  String? profliePicUrl;
  double? experience;
  List<Languages>? languages;
  int? minimumCallDuration;
  double? minimumCallDurationCharges;
  double? additionalPerMinuteCharges;
  bool? isAvailable;
  double? rating;
  List<Skills>? skills;
  bool? isOnCall;
  int? freeMinutes;
  int? additionalMinute;
  Images? images;
  Availability? availability;

  AstrologerInfo(
      {this.id,
      this.urlSlug,
      this.namePrefix,
      this.firstName,
      this.lastName,
      this.aboutMe,
      this.profliePicUrl,
      this.experience,
      this.languages,
      this.minimumCallDuration,
      this.minimumCallDurationCharges,
      this.additionalPerMinuteCharges,
      this.isAvailable,
      this.rating,
      this.skills,
      this.isOnCall,
      this.freeMinutes,
      this.additionalMinute,
      this.images,
      this.availability});

  AstrologerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urlSlug = json['urlSlug'];
    namePrefix = json['namePrefix'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    aboutMe = json['aboutMe'];
    profliePicUrl = json['profliePicUrl'];
    experience = json['experience'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
    minimumCallDuration = json['minimumCallDuration'];
    minimumCallDurationCharges = json['minimumCallDurationCharges'];
    additionalPerMinuteCharges = json['additionalPerMinuteCharges'];
    isAvailable = json['isAvailable'];
    rating = json['rating'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills?.add(Skills.fromJson(v));
      });
    }
    isOnCall = json['isOnCall'];
    freeMinutes = json['freeMinutes'];
    additionalMinute = json['additionalMinute'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
    availability = json['availability'] != null
        ? Availability.fromJson(json['availability'])
        : null;
  }

  int getMinimumCallDurationCharges() {
    try {
      return (minimumCallDurationCharges ?? 0).toInt();
    } catch (e) {
      return 0;
    }
  }

  int getExperience() {
    try {
      return (experience ?? 0).toInt();
    } catch (e) {
      return 0;
    }
  }
}

class Languages {
  int? id;
  String? name;

  Languages({this.id, this.name});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Skills {
  int? id;
  String? name;
  String? description;

  Skills({this.id, this.name, this.description});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
}

class Images {
  Small? small;
  Large? large;
  Large? medium;

  Images({this.small, this.large, this.medium});

  Images.fromJson(Map<String, dynamic> json) {
    small = json['small'] != null ? Small.fromJson(json['small']) : null;
    large = json['large'] != null ? Large.fromJson(json['large']) : null;
    medium = json['medium'] != null ? Large.fromJson(json['medium']) : null;
  }
}

class Small {
  String? imageUrl;
  int? id;

  Small({this.imageUrl, this.id});

  Small.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }
}

class Large {
  String? imageUrl;
  int? id;

  Large({this.imageUrl, this.id});

  Large.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }
}

class Availability {
  List<String>? days;
  Slot? slot;

  Availability({this.days, this.slot});

  Availability.fromJson(Map<String, dynamic> json) {
    days = json['days'].cast<String>();
    slot = json['slot'] != null ? Slot.fromJson(json['slot']) : null;
  }
}

class Slot {
  String? toFormat;
  String? fromFormat;
  String? from;
  String? to;

  Slot({this.toFormat, this.fromFormat, this.from, this.to});

  Slot.fromJson(Map<String, dynamic> json) {
    toFormat = json['toFormat'];
    fromFormat = json['fromFormat'];
    from = json['from'];
    to = json['to'];
  }
}
