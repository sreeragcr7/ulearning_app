import 'package:ulearning_app/core/common/entities/entities.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.description,
    required super.videoUrl,
    required super.thumbnailUrl,
    required super.durationMinutes,
    required super.lessonOrder,
    required super.isPreview,
    required super.createdAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] ?? '',

      courseId: json['course_id'] ?? '',

      title: json['title'] ?? '',

      description: json['description'] ?? '',

      videoUrl: json['video_url'] ?? '',

      thumbnailUrl: json['thumbnail_url'],

      durationMinutes: json['duration_minutes'] ?? 0,

      lessonOrder: json['lesson_order'] ?? 0,

      isPreview: json['is_preview'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'duration_minutes': durationMinutes,
      'lesson_order': lessonOrder,
      'is_preview': isPreview,
      'created_at': createdAt.toIso8601String(),
    };
  }

  LessonModel copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    String? videoUrl,
    String? thumbnailUrl,
    int? durationMinutes,
    int? lessonOrder,
    bool? isPreview,
    DateTime? createdAt,
  }) {
    return LessonModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      lessonOrder: lessonOrder ?? this.lessonOrder,
      isPreview: isPreview ?? this.isPreview,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
