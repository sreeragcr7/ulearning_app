import 'package:equatable/equatable.dart';

class Section extends Equatable {
  const Section({required this.id, required this.courseId, required this.title, required this.position});

  final String id;
  final String courseId;
  final String title;
  final int position;

  @override
  List<Object?> get props => [id, courseId, title, position];
}
