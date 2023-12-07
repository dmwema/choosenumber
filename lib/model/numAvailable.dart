class NumAvailable {
  String? msisdn;
  String? category;
  String? status;
  bool? selected;
  NumAvailable({this.msisdn, this.category, this.status, this.selected});

  factory NumAvailable.fromJson(Map<String, dynamic> json) {
    return NumAvailable(
        msisdn: json['msisdn'],
        category: json['category'],
        status: json['status'],
        selected: false);
  }
  Map<String, dynamic> tJson() {
    return {'msisdn': msisdn, 'category': category, 'status': status};
  }

  static Future<List<NumAvailable>> numsfromJson(List<dynamic> data) async {
    return data.map((element) => NumAvailable.fromJson(element)).toList();
  }

  static Future<List<Map<String, dynamic>>> numsToJson(
      List<NumAvailable> data) async {
    return data.map((element) => element.tJson()).toList();
  }
}
