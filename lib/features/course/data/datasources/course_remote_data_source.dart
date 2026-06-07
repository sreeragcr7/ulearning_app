import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ulearning_app/features/course/data/models/course_model.dart';
// import 'package:ulearning_app/features/course/data/models/lesson_model.dart';

abstract interface class CourseRemoteDataSource {
  Future<List<CourseModel>> getAllCourses();
  Future<List<CourseModel>> getPopularCourses();
  Future<List<CourseModel>> getNewestCourses();
  Future<CourseModel> getCourseById(String courseId);
  // Future<List<LessonModel>> getLessons(String courseId);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  const CourseRemoteDataSourceImpl(this.supabase);
  final SupabaseClient supabase;
  @override
  Future<List<CourseModel>> getAllCourses() async {
    final response = await supabase
        .from('courses')
        .select()
        .eq('is_published', true)
        .order('created_at', ascending: false);
    return response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<CourseModel> getCourseById(String courseId) async {
    final response = await supabase.from('courses').select().eq('id', courseId).single();
    return CourseModel.fromJson(response);
  }

  // @override
  // Future<List<LessonModel>> getLessons(String courseId) async {
  //   final response = await supabase
  //       .from('sources')
  //       .select()
  //       .eq('course_id', courseId)
  //       .order('lesson_order', ascending: true);

  //   return response.map<LessonModel>((e) => LessonModel.fromJson(e)).toList();
  // }

  @override
  Future<List<CourseModel>> getNewestCourses() async {
    final response = await supabase
        .from('courses')
        .select()
        .eq('is_published', true)
        .order('created_at', ascending: false);

    return response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();
  }

  @override
  Future<List<CourseModel>> getPopularCourses() async {
    final response = await supabase.from('courses').select().eq('is_published', true).eq('is_popular', true);
    return response.map<CourseModel>((e) => CourseModel.fromJson(e)).toList();
  }
}
