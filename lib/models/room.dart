import 'dart:convert';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

String roomToJson(Room data) => json.encode(data.toJson());

class Room {
  Room(
      {this.id,
      this.user,
      this.name = "",
      this.description = "",
      this.position,
      this.totalPlants,
      this.totalAirs,
      this.totalLights,
      this.createdAt,
      this.updatedAt,
      this.wide = "",
      this.long = "",
      this.tall = "",
      this.timeOn = "",
      this.timeOff = "",
      this.co2 = false,
      this.co2Control = false,
      isRoute,
      init()});

  String user;
  String id;
  String name;
  int position;
  String description;
  String wide;
  String long;
  String tall;
  String timeOn;
  String timeOff;
  bool co2;
  bool co2Control;

  int totalPlants;
  int totalAirs;
  int totalLights;
  DateTime createdAt;
  DateTime updatedAt;

  factory Room.fromJson(Map<String, dynamic> json) => new Room(
      id: json["id"],
      user: json["user"],
      name: json["name"],
      position: json['position'],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      description: json["description"],
      wide: json["wide"],
      long: json["long"],
      tall: json["tall"],
      co2: json["co2"],
      co2Control: json["co2Control"],
      timeOn: json["timeOn"],
      timeOff: json["timeOff"],

      //products: List<Product>.from(json["products"].map((x) => x)),
      totalPlants: json["totalPlants"],
      totalAirs: json["totalAirs"],
      totalLights: json["totalLights"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "position": position,
        "description": description,
        "wide": wide,
        "long": long,
        "tall": tall,
        "co2": co2,
        "co2Control": co2Control,
        "timeOn": timeOn,
        "timeOff": timeOff,
        "totalPlants": totalPlants,
        "totalAirs": totalAirs,
        "totalLights": totalLights,
        //"products": List<dynamic>.from(products.map((x) => x)),
      };
}
