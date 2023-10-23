import 'dart:developer';

import 'package:digisalad_task/data_models/song_data_model.dart';
import 'package:http/http.dart' as http;

// Fetching online contents
class APIServices {
  // Get search result from the iTunes API
  // Parameters:
  // - Media = Music
  // - Term  = keyword (Search Term)
  // - Limit = 200

  Future<List<SongDataModel>?> getSearchResult(String keyword) async {
    try {
      var url = Uri.parse(
          "https://itunes.apple.com/search?media=music&term=$keyword&limit=200");
      var response = await http.get(url,
          headers: {"Access-Control-Allow-Origin": "*", 'Accept': '/'});
      if (response.statusCode == 200) {
        List<SongDataModel> model = songModelFromJson(response.body);
        print(model.length);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
