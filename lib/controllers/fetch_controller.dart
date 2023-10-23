import 'package:digisalad_task/data_models/song_data_model.dart';
import 'package:digisalad_task/utils/api_services.dart';
import 'package:get/get.dart';

class FetchController extends GetxController {
  List<SongDataModel?> _songList = [];
  List<SongDataModel?> get songList => _songList;

  Future<void> fetchSongs(String keyword) async {
    await APIServices().getSearchResult(keyword).then((value) {
      print(value);
      if (value != null) {
        _songList = value;
      } else {
        _songList = [];
      }
    });
    update();
  }

  emptySongList() {
    _songList = [];
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
