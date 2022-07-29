import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseConfig {
  static final String apiKey = dotenv.get("API_KEY");
  static final String appId = dotenv.get("APP_ID");
  static final String messagingSenderId = dotenv.get("MESSAGING_SENDER_ID");
  static final String projectId = dotenv.get("PROJECT_ID");
  static final String storageBucket = dotenv.get("STORAGE_BUCKET");
}
