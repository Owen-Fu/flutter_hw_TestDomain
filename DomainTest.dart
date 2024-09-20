import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class DomainTest {
  /// 儲存 domain 和下載時間的列表
  List<Map<String, dynamic>> _downloadResults = [];
  static const int TimeOutTime = -1;

  /// 1.請求圖片的 function，請求必須背景執行，圖片不需要儲存，最後回傳圖片的下載時間(ms)：downloadImg(domain: String)
  Future<int> downloadImg(String domain) async {
    int downloadTime = TimeOutTime;
    try {
      final startTime = DateTime.now();
      final response = await http.get(Uri.parse(domain));
      final endTime = DateTime.now();
      if (response.statusCode == 200) {
        downloadTime = endTime.difference(startTime).inMilliseconds;
      }
    } catch (e) {}
    return downloadTime;
  }

  /// 2.儲存結果的 function，傳入參數由撰寫者自行決定，傳入後必須要照下載時間順序排序後儲存：set({由撰寫者自行決定}): void
  /// 儲存結果，結果包括 {domain, 時間}，並根據時間排序後儲存
  void set(String domain, int downloadTime) {
    _downloadResults.add({'domain': domain, 'downloadTime': downloadTime});
    _downloadResults.sort((a, b) => a['downloadTime'].compareTo(b['downloadTime']));
  }

  /// 3.取出結果的 function，回傳結果由撰寫者自行決定，請搭配 set 傳入參數一起考慮：get(): {由撰寫者自行決定}
  /// 回傳排序好的 {domain, downloadTime} 列表 使用 jsonEncode
  String get() {
    return jsonEncode(_downloadResults);
  }
}
