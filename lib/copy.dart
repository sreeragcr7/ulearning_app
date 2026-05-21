// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:supabase_flutter/supabase_flutter.dart'
//     as supabase hide User;

// import 'package:ulearning_app/core/common/cubit/app_user_cubit.dart';
// import 'package:ulearning_app/core/common/entities/user.dart';
// import 'package:ulearning_app/core/usecases/t_usecase.dart';

// import 'package:ulearning_app/features/auth/domain/usecases/auth_state_changes.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/current_user.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/logout.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/user_login.dart';
// import 'package:ulearning_app/features/auth/domain/usecases/user_signup.dart';

// import 'package:ulearning_app/features/navigation/presentation/bloc/nav_bloc.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
//   AuthBloc({
//     required UserLogin userLogin,
//     required UserSignup userSignup,
//     required CurrentUser currentUser,
//     required Logout logout,
//     required AppUserCubit appUserCubit,
//     required NavBloc navBloc,
//     required AuthStateChanges authStateChanges,
//   })  : _userLogin = userLogin,
//         _userSignup = userSignup,
//         _currentUser = currentUser,
//         _logout = logout,
//         _appUserCubit = appUserCubit,
//         _navBloc = navBloc,
//         _authStateChanges = authStateChanges,
//         super(AuthCheckingSession()) {

//     on<LogInEvent>(_onLoginEvent);
//     on<SignUpEvent>(_onSignupEvent);
//     on<LogoutEvent>(_onLogoutEvent);
//     on<CheckSessionEvent>(_onCheckSession);
//     on<AuthStateChangedEvent>(_onAuthStateChanged);

//     /// START LISTENER
//     _authSubscription =
//         _authStateChanges(NoParams())
//         .listen((data) {

//       add(
//         AuthStateChangedEvent(
//           data.session,
//         ),
//       );
//     });
//   }

//   final UserLogin _userLogin;
//   final UserSignup _userSignup;
//   final CurrentUser _currentUser;
//   final Logout _logout;
//   final AppUserCubit _appUserCubit;
//   final NavBloc _navBloc;
//   final AuthStateChanges _authStateChanges;

//   late final StreamSubscription<supabase.AuthState>
//       _authSubscription;

//   void _emitAuthSuccess(
//     User user,
//     Emitter<AuthBlocState> emit,
//   ) {
//     _appUserCubit.setUser(user);

//     emit(AuthSuccess());
//   }

//   Future<void> _onAuthStateChanged(
//     AuthStateChangedEvent event,
//     Emitter<AuthBlocState> emit,
//   ) async {

//     if (event.session == null) {

//       _appUserCubit.clearUser();

//       emit(AuthLoggedOut());

//     } else {

//       add(CheckSessionEvent());

//     }
//   }

//   Future<void> _onCheckSession(
//     CheckSessionEvent event,
//     Emitter<AuthBlocState> emit,
//   ) async {

//     emit(AuthCheckingSession());

//     final res =
//         await _currentUser(NoParams());

//     res.fold(
//       (_) {

//         _appUserCubit.clearUser();

//         emit(AuthInitial());

//       },
//       (user) {

//         _appUserCubit.setUser(user);

//         emit(AuthSuccess());

//       },
//     );
//   }

//   Future<void> _onLoginEvent(
//     LogInEvent event,
//     Emitter<AuthBlocState> emit,
//   ) async {

//     emit(AuthLoading());

//     final res = await _userLogin(
//       LoginParams(
//         email: event.email,
//         password: event.password,
//       ),
//     );

//     res.fold(
//       (error) =>
//           emit(AuthFailure(error.message)),
//       (user) =>
//           _emitAuthSuccess(user, emit),
//     );
//   }

//   Future<void> _onSignupEvent(
//     SignUpEvent event,
//     Emitter<AuthBlocState> emit,
//   ) async {

//     emit(AuthLoading());

//     final res = await _userSignup(
//       SignUpParams(
//         username: event.username,
//         email: event.email,
//         password: event.password,
//       ),
//     );

//     res.fold(
//       (error) =>
//           emit(AuthFailure(error.message)),
//       (user) =>
//           _emitAuthSuccess(user, emit),
//     );
//   }

//   Future<void> _onLogoutEvent(
//     LogoutEvent event,
//     Emitter<AuthBlocState> emit,
//   ) async {

//     emit(AuthLoading());

//     final res =
//         await _logout(NoParams());

//     res.fold(
//       (error) =>
//           emit(AuthFailure(error.message)),
//       (_) {

//         _appUserCubit.clearUser();

//         _navBloc.add(
//           NavResetEvent(),
//         );

//         emit(AuthLoggedOut());

//       },
//     );
//   }

//   @override
//   Future<void> close() {

//     _authSubscription.cancel();

//     return super.close();
//   }
// },  part of 'auth_bloc.dart';

// @immutable
// sealed class AuthEvent {}

// final class CheckSessionEvent extends AuthEvent {}

// final class AuthStateChangedEvent extends AuthEvent {
//   AuthStateChangedEvent(this.session);
//   final supabase.Session? session;
// }

// final class LogInEvent extends AuthEvent {
//   LogInEvent({required this.email, required this.password});
//   final String email;
//   final String password;
// }

// final class SignUpEvent extends AuthEvent {
//   SignUpEvent({required this.email, required this.username, required this.password});
//   final String username;
//   final String email;
//   final String password;
// }

// final class LogoutEvent extends AuthEvent {}

// // final class AuthUserLoggedInEvent extends AuthEvent {}
// ,  part of 'auth_bloc.dart';

// @immutable
// sealed class AuthBlocState {}

// final class AuthInitial extends AuthBlocState {}

// final class AuthCheckingSession extends AuthBlocState {}

// final class AuthLoading extends AuthBlocState {}

// final class AuthSuccess extends AuthBlocState {}

// final class AuthFailure extends AuthBlocState {
//   AuthFailure(this.message);
//   final String message;
// }

// final class AuthLoggedOut extends AuthBlocState {}
// ,  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ulearning_app/core/common/widgets/common_button.dart';
// import 'package:ulearning_app/core/routes/app_routes.dart';
// import 'package:ulearning_app/core/utils/constants/sizes.dart';
// import 'package:ulearning_app/core/utils/snack_bar.dart';
// import 'package:ulearning_app/core/utils/validators.dart';
// import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/auth_field.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/auth_layout.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/auth_switch_text.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/third_party_login.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = context.read<AuthBloc>();
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       extendBodyBehindAppBar: true,
//       body: BlocConsumer<AuthBloc, AuthBlocState>(
//         listener: (context, state) {
//           if (state is AuthFailure) {
//             snackBar(context, state.message);
//           }

//         },
//         builder: (context, state) {
//           return AuthLayout(
//             bgImage: 'assets/images/loginbg.png',

//             titleColor: Colors.white,
//             isLoading: state is AuthLoading,

//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Text(
//                     'Log In',
//                     style: Theme.of(
//                       context,
//                     ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
//                   ),
//                   SizedBox(height: TSizes.btwSection),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ThirdPartyLogin(iconPath: 'assets/icons/google.png', onTap: () {}),
//                       SizedBox(width: 30.w),
//                       ThirdPartyLogin(iconPath: 'assets/icons/apple.png', onTap: () {}),
//                       SizedBox(width: 30.w),
//                       ThirdPartyLogin(iconPath: 'assets/icons/facebook.png', onTap: () {}),
//                     ],
//                   ),

//                   SizedBox(height: TSizes.btwSection - 5),

//                   Text(
//                     'Or use your email account login',
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                       color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
//                     ),
//                   ),

//                   SizedBox(height: TSizes.btwSection),

//                   Column(
//                     children: [
//                       TAuthField(
//                         validator: AppValidators.validateEmail,
//                         controller: emailController,
//                         hintText: 'Eg: abc@gmail.com',
//                         labelText: 'Email',
//                         prefixIcon: Iconsax.sms,
//                         prefixIconFilled: Iconsax.sms5,
//                       ),

//                       SizedBox(height: TSizes.btwItems),

//                       TAuthField(
//                         validator: AppValidators.validatePassword,
//                         controller: passwordController,
//                         hintText: 'Enter password',
//                         labelText: 'Password',
//                         prefixIcon: Iconsax.password_check,
//                         prefixIconFilled: Iconsax.password_check5,
//                         isPassword: true,
//                       ),

//                       SizedBox(height: TSizes.btwSection),

//                       CommonBtn(
//                         btn: 'Log In',
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             authBloc.add(
//                               LogInEvent(email: emailController.text.trim(), password: passwordController.text.trim()),
//                             );
//                           }
//                         },
//                       ),

//                       SizedBox(height: TSizes.btwSection - 15),

//                       AuthSwitchText(
//                         title: 'Dont have an account?',
//                         buttonText: 'Sign Up',
//                         onPressed: () {
//                           Navigator.pushReplacementNamed(context, AppRoutes.signup);
//                         },
//                       ),

//                       SizedBox(height: TSizes.btwItems),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// ,  ,  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:ulearning_app/core/common/widgets/common_button.dart';
// import 'package:ulearning_app/core/routes/app_routes.dart';
// import 'package:ulearning_app/core/utils/constants/sizes.dart';
// import 'package:ulearning_app/core/utils/snack_bar.dart';
// import 'package:ulearning_app/core/utils/validators.dart';
// import 'package:ulearning_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/auth_field.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/auth_layout.dart';
// import 'package:ulearning_app/features/auth/presentation/widgets/auth_switch_text.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final usernameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPwdController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     usernameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPwdController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = context.read<AuthBloc>();
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       extendBodyBehindAppBar: true,

//       body: BlocConsumer<AuthBloc, AuthBlocState>(
//         listener: (context, state) {
//           if (state is AuthFailure) {
//             snackBar(context, state.message);
//           }

         
//         },

//         builder: (context, state) {
//           return AuthLayout(
//             bgImage: 'assets/images/signupbg.png',
//             isLoading: state is AuthLoading,
//             titleColor: Colors.white,

//             child: Form(
//               key: _formKey,

//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),

//                   /// TITLE
//                   Text('Sign Up', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface)),

//                   SizedBox(height: TSizes.btwSection),

//                   /// SUBTITLE
//                   Text(
//                     'Enter your details below & sign up for free',

//                     textAlign: TextAlign.center,

//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
//                     ),
//                   ),

//                   SizedBox(height: TSizes.btwSection),

//                   /// FORM
//                   Column(
//                     children: [
//                       /// USERNAME
//                       TAuthField(
//                         controller: usernameController,

//                         validator: (value) => AppValidators.required(value, 'Username'),

//                         hintText: 'Enter username',
//                         labelText: 'Username',

//                         prefixIcon: Iconsax.user,
//                         prefixIconFilled: Iconsax.user5,
//                       ),

//                       SizedBox(height: TSizes.btwItems),

//                       /// EMAIL
//                       TAuthField(
//                         controller: emailController,

//                         validator: AppValidators.validateEmail,

//                         hintText: 'Enter email',
//                         labelText: 'Email',

//                         prefixIcon: Iconsax.sms,
//                         prefixIconFilled: Iconsax.sms5,
//                       ),

//                       SizedBox(height: TSizes.btwItems),

//                       /// PASSWORD
//                       TAuthField(
//                         controller: passwordController,
//                         isPassword: true,

//                         onChanged: (_) => _formKey.currentState?.validate(),

//                         validator: AppValidators.validatePassword,

//                         hintText: 'Enter password',
//                         labelText: 'Password',

//                         prefixIcon: Iconsax.password_check,
//                         prefixIconFilled: Iconsax.password_check5,
//                       ),

//                       SizedBox(height: TSizes.btwItems),

//                       /// CONFIRM PASSWORD
//                       TAuthField(
//                         controller: confirmPwdController,
//                         isPassword: true,

//                         onChanged: (_) => _formKey.currentState?.validate(),

//                         validator: (value) => AppValidators.confirmPassword(value, passwordController.text),

//                         hintText: 'Confirm password',
//                         labelText: 'Confirm Password',

//                         prefixIcon: Iconsax.check,
//                         prefixIconFilled: Iconsax.tick_circle5,
//                       ),

//                       SizedBox(height: TSizes.btwSection),

//                       /// SIGN UP BUTTON
//                       CommonBtn(
//                         btn: 'Sign Up',

//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             authBloc.add(
//                               SignUpEvent(
//                                 email: emailController.text.trim(),

//                                 username: usernameController.text.trim(),

//                                 password: passwordController.text.trim(),
//                               ),
//                             );
//                           }
//                         },
//                       ),

//                       SizedBox(height: TSizes.btwSection - 15),

//                       /// SWITCH AUTH
//                       AuthSwitchText(
//                         title: 'Already have an account?',

//                         buttonText: 'Log In',

//                         onPressed: () {
//                           Navigator.pushReplacementNamed(context, AppRoutes.login);
//                         },
//                       ),

//                       SizedBox(height: TSizes.btwItems),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// ,  import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ulearning_app/core/common/entities/user.dart';

// part 'app_user_state.dart';

// class AppUserCubit extends Cubit<AppUserState> {
//   AppUserCubit() : super(AppUserInitial());

//   void setUser(User user) {
//     emit(AppUserAuthenticated(user));
//   }

//   void clearUser() {
//     emit(AppUserUnauthenticated());
//   }
// }
// ,  part of 'app_user_cubit.dart';

// @immutable
// sealed class AppUserState {}

// final class AppUserInitial extends AppUserState {}

// final class AppUserAuthenticated extends AppUserState {
//   AppUserAuthenticated(this.user);
//   final User user;
// }

// final class AppUserUnauthenticated extends AppUserState {}

// ,   