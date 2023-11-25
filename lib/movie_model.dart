// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<Welcome> welcomeFromMap(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromMap(x)));

String welcomeToMap(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Welcome {
  double score;
  Show show;

  Welcome({
    required this.score,
    required this.show,
  });

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        score: json["score"]?.toDouble(),
        show: Show.fromMap(json["show"]),
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "show": show.toMap(),
      };
}

class Show {
  int id;
  String url;
  String name;
  Type type;
  Language language;
  List<String> genres;
  Status status;
  int? runtime;
  int? averageRuntime;
  DateTime? premiered;
  DateTime? ended;
  String? officialSite;
  Schedule schedule;
  Rating rating;
  int weight;
  Network? network;
  Network? webChannel;
  dynamic dvdCountry;
  Externals externals;
  MovieImage? image;
  String summary;
  int updated;
  Links links;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.averageRuntime,
    required this.premiered,
    required this.ended,
    required this.officialSite,
    required this.schedule,
    required this.rating,
    required this.weight,
    required this.network,
    required this.webChannel,
    required this.dvdCountry,
    required this.externals,
    required this.image,
    required this.summary,
    required this.updated,
    required this.links,
  });

  factory Show.fromMap(Map<String, dynamic> json) => Show(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: typeValues.map[json["type"]]!,
        language: languageValues.map[json["language"]]!,
        genres: List<String>.from(json["genres"].map((x) => x)),
        status: statusValues.map[json["status"]]!,
        runtime: json["runtime"],
        averageRuntime: json["averageRuntime"],
        premiered: json["premiered"] == null
            ? null
            : DateTime.parse(json["premiered"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        officialSite: json["officialSite"],
        schedule: Schedule.fromMap(json["schedule"]),
        rating: Rating.fromMap(json["rating"]),
        weight: json["weight"],
        network:
            json["network"] == null ? null : Network.fromMap(json["network"]),
        webChannel: json["webChannel"] == null
            ? null
            : Network.fromMap(json["webChannel"]),
        dvdCountry: json["dvdCountry"],
        externals: Externals.fromMap(json["externals"]),
        image: json["image"] == null ? null : MovieImage.fromMap(json["image"]),
        summary: json["summary"],
        updated: json["updated"],
        links: Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "name": name,
        "type": typeValues.reverse[type],
        "language": languageValues.reverse[language],
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "status": statusValues.reverse[status],
        "runtime": runtime,
        "averageRuntime": averageRuntime,
        "premiered":
            "${premiered!.year.toString().padLeft(4, '0')}-${premiered!.month.toString().padLeft(2, '0')}-${premiered!.day.toString().padLeft(2, '0')}",
        "ended":
            "${ended!.year.toString().padLeft(4, '0')}-${ended!.month.toString().padLeft(2, '0')}-${ended!.day.toString().padLeft(2, '0')}",
        "officialSite": officialSite,
        "schedule": schedule.toMap(),
        "rating": rating.toMap(),
        "weight": weight,
        "network": network?.toMap(),
        "webChannel": webChannel?.toMap(),
        "dvdCountry": dvdCountry,
        "externals": externals.toMap(),
        "image": image?.toMap(),
        "summary": summary,
        "updated": updated,
        "_links": links.toMap(),
      };
}

class Externals {
  dynamic tvrage;
  int thetvdb;
  String? imdb;

  Externals({
    required this.tvrage,
    required this.thetvdb,
    required this.imdb,
  });

  factory Externals.fromMap(Map<String, dynamic> json) => Externals(
        tvrage: json["tvrage"],
        thetvdb: json["thetvdb"],
        imdb: json["imdb"],
      );

  Map<String, dynamic> toMap() => {
        "tvrage": tvrage,
        "thetvdb": thetvdb,
        "imdb": imdb,
      };
}

class MovieImage {
  String medium;
  String original;

  MovieImage({
    required this.medium,
    required this.original,
  });

  factory MovieImage.fromMap(Map<String, dynamic> json) => MovieImage(
        medium: json["medium"],
        original: json["original"],
      );

  Map<String, dynamic> toMap() => {
        "medium": medium,
        "original": original,
      };
}

enum Language { BULGARIAN, ENGLISH, KOREAN }

final languageValues = EnumValues({
  "Bulgarian": Language.BULGARIAN,
  "English": Language.ENGLISH,
  "Korean": Language.KOREAN
});

class Links {
  Self self;
  Self? previousepisode;

  Links({
    required this.self,
    this.previousepisode,
  });

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        self: Self.fromMap(json["self"]),
        previousepisode: json["previousepisode"] == null
            ? null
            : Self.fromMap(json["previousepisode"]),
      );

  Map<String, dynamic> toMap() => {
        "self": self.toMap(),
        "previousepisode": previousepisode?.toMap(),
      };
}

class Self {
  String href;

  Self({
    required this.href,
  });

  factory Self.fromMap(Map<String, dynamic> json) => Self(
        href: json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
      };
}

class Network {
  int id;
  String name;
  Country? country;
  String? officialSite;

  Network({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        id: json["id"],
        name: json["name"],
        country:
            json["country"] == null ? null : Country.fromMap(json["country"]),
        officialSite: json["officialSite"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "country": country?.toMap(),
        "officialSite": officialSite,
      };
}

class Country {
  String name;
  String code;
  String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
        "timezone": timezone,
      };
}

class Rating {
  double? average;

  Rating({
    required this.average,
  });

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        average: json["average"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "average": average,
      };
}

class Schedule {
  String time;
  List<String> days;

  Schedule({
    required this.time,
    required this.days,
  });

  factory Schedule.fromMap(Map<String, dynamic> json) => Schedule(
        time: json["time"],
        days: List<String>.from(json["days"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "time": time,
        "days": List<dynamic>.from(days.map((x) => x)),
      };
}

enum Status { ENDED, IN_DEVELOPMENT, RUNNING }

final statusValues = EnumValues({
  "Ended": Status.ENDED,
  "In Development": Status.IN_DEVELOPMENT,
  "Running": Status.RUNNING
});

enum Type { DOCUMENTARY, SCRIPTED, VARIETY }

final typeValues = EnumValues({
  "Documentary": Type.DOCUMENTARY,
  "Scripted": Type.SCRIPTED,
  "Variety": Type.VARIETY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
