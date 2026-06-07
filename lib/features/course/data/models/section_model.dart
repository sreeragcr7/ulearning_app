import 'package:ulearning_app/core/common/entities/section.dart';

class SectionModel extends Section {
  const SectionModel({required super.id, required super.courseId, required super.title, required super.position});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      title: json['title'] as String,
      position: json['position'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'course_id': courseId, 'title': title, 'position': position};
  }
}
