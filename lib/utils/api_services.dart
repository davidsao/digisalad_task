import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

// Fetching online contents
class APIServices {
  // Get search result from the iTunes API
  // Parameters:
  // - Media = Music
  // - Term  = keyword (Search Term)
  // - Limit = 200

  Future<dynamic> getSearchResult(String keyword) async {
    try {
      var url = Uri.parse(
          "https://itunes.apple.com/search?media=music&term=$keyword&limit=200");
      var response = await http.get(url,
          headers: {"Access-Control-Allow-Origin": "*", 'Accept': '/'});
      if (response.statusCode == 200) {
        // Pass back the JSON object to the widget for displaying the search result
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
