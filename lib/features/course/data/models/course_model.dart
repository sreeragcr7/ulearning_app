import 'package:ulearning_app/core/common/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.description,
    required super.thumbnailUrl,
    required super.instructorName,
    required super.price,
    required super.totalLessons,
    required super.totalHours,
    required super.studentsCount,
    required super.rating,
    required super.isPopular,
    required super.categoryId,
    required super.createdAt,
    required super.isPublished,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      categoryId: json['category_id'],
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      instructorName: json['instructor_name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      totalLessons: json['total_lessons'] ?? 0,
      totalHours: json['total_hours'] ?? 0,
      studentsCount: json['students_count'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isPopular: json['is_popular'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      isPublished: json['is_published'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'thumbnail_url': thumbnailUrl,
      'instructor_name': instructorName,
      'price': price,
      'total_lessons': totalLessons,
      'total_hours': totalHours,
      'students_count': studentsCount,
      'rating': rating,
      'is_popular': isPopular,
      'created_at': createdAt.toIso8601String(),
      'is_published': isPublished,
    };
  }

  CourseModel copyWith({
    String? id,
    int? categoryId,
    String? title,
    String? subtitle,
    String? description,
    String? thumbnailUrl,
    String? instructorName,
    double? price,
    int? totalLessons,
    int? totalHours,
    int? studentsCount,
    double? rating,
    bool? isPopular,
    DateTime? createdAt,
    bool? isPublished,
  }) {
    return CourseModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      instructorName: instructorName ?? this.instructorName,
      price: price ?? this.price,
      totalLessons: totalLessons ?? this.totalLessons,
      totalHours: totalHours ?? this.totalHours,
      studentsCount: studentsCount ?? this.studentsCount,
      rating: rating ?? this.rating,
      isPopular: isPopular ?? this.isPopular,
      createdAt: createdAt ?? this.createdAt,
      isPublished: isPublished ?? this.isPublished,
    );
  }
}
