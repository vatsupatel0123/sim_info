class SimInfoDetails {
  int? slot;
  String? carrier;
  String? simNumber;
  String? countryIso;

  SimInfoDetails({this.slot, this.carrier, this.simNumber, this.countryIso});

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'carrier': carrier,
      'simNumber': simNumber,
      'countryIso': countryIso,
    };
  }
}
