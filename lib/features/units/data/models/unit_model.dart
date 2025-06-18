class UnitModel {
  int? id;
  String? name;
  UnitModel({this.id, this.name});

  factory UnitModel.fromDatabase(Map<String, dynamic> db) {
    return UnitModel(id: db['id'] as int?, name: db['name'] as String?);
  }
}
