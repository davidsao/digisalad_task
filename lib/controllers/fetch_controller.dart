import 'package:digisalad_task/utils/api_services.dart';
import 'package:get/get.dart';

class FetchController extends GetxController{

  dynamic _songList = [];
  dynamic get songList => _songList;

  Future<void> fetchSongs(String keyword) async {
    await APIServices().getSearchResult(keyword).then((value) {
      if (value != null) _songList = value['results'];
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