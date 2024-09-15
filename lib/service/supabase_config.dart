import 'package:supabase/supabase.dart';

class SupabaseConfig {
  static final SupabaseClient client = SupabaseClient(
    'https://cuzcsrkylfnaathhnfgg.supabase.co', 
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1emNzcmt5bGZuYWF0aGhuZmdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjU4MzYwMjcsImV4cCI6MjA0MTQxMjAyN30.aMA2g6otYp0FXpt7JVTyw3LiEXluZj59ZmMChtvNtYY', // استبدله بـ anon-key الخاص بك
  );
}
