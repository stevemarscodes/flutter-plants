import 'package:leafety/global/environment.dart';
import 'package:leafety/models/profiles_response.dart';
import 'package:leafety/shared_preferences/auth_storage.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

class UsersProvider {
  final prefs = new AuthUserPreferences();

  Future<ProfilesResponse> getSearchPrincipalByQuery(String query) async {
    try {
      final urlFinal = ('${Environment.apiUrl}/api/search/principal/$query');

      final resp = await http.get(
        Uri.parse(urlFinal),
        headers: {'Content-Type': 'application/json', 'x-token': prefs.token},
      );

      final profilesResponse = profilesResponseFromJson(resp.body);

      return profilesResponse;
    } catch (error) {
      return ProfilesResponse.withError("$error");
    }
  }
}
