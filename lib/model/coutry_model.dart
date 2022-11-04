class Country {
  final String name;

  final String flag;
  List<String> callingCodes;

  Country({this.name, this.flag, this.callingCodes});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      flag: json['flag'],
      callingCodes: List<String>.from(json["callingCodes"].map((x) => x)),
    );
  }
}
