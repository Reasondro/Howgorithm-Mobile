import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(
      {required String email, required String password}) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUpWithEmailPassword(
      {required String email, required String password}) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    return await supabase.auth.signOut();
  }

  String? getCurrentUserEmail() {
    final Session? session = supabase.auth.currentSession;
    final User? user = session?.user;
    return user?.email;
  }

  String? getCurrentUserId() {
    final Session? session = supabase.auth.currentSession;
    final User? user = session?.user;
    return user?.id;
  }
}
