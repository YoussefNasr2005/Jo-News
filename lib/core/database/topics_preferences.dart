import 'package:shared_preferences/shared_preferences.dart';

class Topicspreferences {
  static const String _key = 'topic';

  static Future<void> saveTopics(List<String> topics) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, topics);
  }

  static Future<List<String>> loadTopics() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ??
        ['travel', 'technology', 'business', 'entertainment'];
  }

  static Future<void> cleanPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
