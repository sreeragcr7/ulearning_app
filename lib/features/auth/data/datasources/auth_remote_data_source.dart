import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ulearning_app/core/error/exceptions.dart';
import 'package:ulearning_app/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  //User session
  Session? get currentUserSession;

  Stream<AuthState> get authStateChanges;

  Future<UserModel?> getCurrentUserData();
  //Login
  Future<UserModel> logInEmailAndPassword({required String email, required String password});

  //Signup
  Future<void> signUpEmailAndPassword({required String email, required String password, required String username});

  //Logout
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  //Supabase
  final SupabaseClient supabaseClient;

  //Session
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Stream<AuthState> get authStateChanges => supabaseClient.auth.onAuthStateChange;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final session = currentUserSession;
      if (session == null) return null;
      final userData = await supabaseClient.from('profiles').select().eq('id', session.user.id).single();
      return UserModel.fromJson(userData).copyWith(email: session.user.email);
    } on AuthException catch (e) {
      throw AuthExceptions(e.message);
    } catch (e) {
      throw const ServerExceptions('Failed to fetch current user data.');
    }
  }

  //Login
  @override
  Future<UserModel> logInEmailAndPassword({required String email, required String password}) async {
    try {
      //Login
      final res = await supabaseClient.auth.signInWithPassword(password: password, email: email);

      final user = res.user;
      if (user == null) {
        throw const ServerExceptions('User is Null');
      }

      // 3. Fetch the profile from 'profiles' table using user.id
      final profile = await supabaseClient.from('profiles').select().eq('id', user.id).single();

      return UserModel.fromJson(profile).copyWith(email: user.email);
    } on AuthException catch (e) {
      throw AuthExceptions(e.message);
    } catch (e) {
      throw const ServerExceptions('Something went wrong during login.');
    }
  }

  //Logout
  @override
  Future<void> signUpEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final res = await supabaseClient.auth.signUp(password: password, email: email, data: {'username': username});

      final user = res.user;
      if (user == null) {
        throw const ServerExceptions('Unable to create account.');
      }

      // return UserModel.fromJson(user.toJson()).copyWith(email: currentUserSession!.user.email);
    } on AuthException catch (e) {
      throw AuthExceptions(e.message);
    } catch (e) {
      throw const ServerExceptions('Something went wrong during signup.');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw AuthExceptions(e.message);
    } catch (e) {
      throw const ServerExceptions('Something went wrong during logout.');
    }
  }
}
