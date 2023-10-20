import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'iTunes Explorer',
          'search_text': 'Search a song from iTunes',
          'empty_result_text': 'No result found. Search for more songs'
        },
        'zh_HK': {
          'title': 'iTunes 搜尋器',
          'search_text': '從 iTunes 搜尋歌曲',
          'empty_result_text': '目前沒有搜尋結果，點上方搜尋更多歌曲'
        },
        'zh_CN': {
          'title': 'iTunes 搜寻器',
          'search_text': '从 iTunes 搜索歌曲',
          'empty_result_text': '目前没有搜寻结果，点上方搜寻更多歌曲'
        }
      };
}
