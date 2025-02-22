import 'dart:async';

import 'package:flutter/services.dart';
import 'package:games_services_platform_interface/helpers.dart';
import 'package:games_services_platform_interface/models/access_point_location.dart';
import 'package:games_services_platform_interface/models/achievement.dart';
import 'package:games_services_platform_interface/models/score.dart';
import 'game_services_platform_interface.dart';

const MethodChannel _channel = const MethodChannel("games_services");

class MethodChannelGamesServices extends GamesServicesPlatform {
  Future<String?> unlock({achievement: Achievement}) async {
    return await _channel.invokeMethod("unlock", {
      "achievementID": achievement.id,
      "percentComplete": achievement.percentComplete,
    });
  }

  Future<String?> submitScore({score: Score}) async {
    return await _channel.invokeMethod("submitScore", {
      "leaderboardID": score.leaderboardID,
      "value": score.value,
    });
  }

  Future<String?> increment({achievement: Achievement}) async {
    return await _channel.invokeMethod("increment", {
      "achievementID": achievement.id,
      "steps": achievement.steps,
    });
  }

  Future<String?> showAchievements() async {
    return await _channel.invokeMethod("showAchievements");
  }

  Future<String?> showLeaderboards({iOSLeaderboardID = ""}) async {
    return await _channel.invokeMethod("showLeaderboards", {"iOSLeaderboardID": iOSLeaderboardID});
  }

  Future<String?> signIn() async {
    if (Helpers.isPlatformAndroid) {
      return await _channel.invokeMethod("silentSignIn");
    } else {
      return await _channel.invokeMethod("signIn");
    }
  }

  Future<String?> signOut() async {
    return await _channel.invokeMethod("signOut");
  }

  Future<bool> isSignedIn() async {
    return await _channel.invokeMethod("isSignedIn");
  }

  Future<String?> showAccessPoint(AccessPointLocation location) async {
    return await _channel.invokeMethod("showAccessPoint", {"location": location.toString().split(".").last});
  }

  Future<String?> hideAccessPoint() async {
    return await _channel.invokeMethod("hideAccessPoint");
  }
}
