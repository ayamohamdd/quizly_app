class SkillModel {
  int? id;
  int? unitId;
  String? name;
  SkillModel({this.id, this.name, this.unitId});

  factory SkillModel.fromDatabase(Map<String, dynamic> db) {
    return SkillModel(
      id: db['id'] as int?,
      unitId: db["unit_id"] as int?,
      name: db['name'] as String?,
    );
  }
}
