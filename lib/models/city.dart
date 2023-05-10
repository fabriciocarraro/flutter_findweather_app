class City {
  final int id;
  final String name;
  final String region;
  final String country;

  City(
      {required this.id,
      required this.name,
      required this.region,
      required this.country});

  City.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        region = map["region"],
        country = map["country"];
}
