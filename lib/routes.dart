import 'package:flutter/material.dart';

// importe todas as telas
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/videos_screen.dart';
import 'screens/video_player_screen.dart';
import 'screens/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String schedule = '/schedule';
  static const String videos = '/videos';
  static const String videoPlayer = '/video_player';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      home: (context) => HomeScreen(),
      schedule: (context) => ScheduleScreen(),
      videos: (context) => VideosScreen(),
      videoPlayer: (context) => VideoPlayerScreen(),
      profile: (context) => ProfileScreen(),
    };
  }
}
