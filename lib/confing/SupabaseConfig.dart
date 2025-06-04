import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://ceckhzfboykmsshamikv.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlY2toemZib3lrbXNzaGFtaWt2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg0MDU1NTYsImV4cCI6MjA1Mzk4MTU1Nn0.jFJxTniyNAq2cmDrYqFyZYvBVAQFVfkhOhHSms1f_Uk';
}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: kIsWeb
      ? 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com'
      : null, // 모바일은 null 가능
  scopes: ['email'],
);