import 'package:dimata_logbook/API/models/picUser.dart';
import 'package:http/http.dart' as http;
import 'package:dimata_logbook/API/models/kategoriTiket.dart';
import 'package:dimata_logbook/API/models/pengguna.dart';
import 'models/detailTiketBugs.dart';
import 'models/chapter.dart';

class GetAllTiketKategori {
  Future<List<KategoriTiket>> getKategoriTiket() async {
    final url = "http://192.168.18.10:8080/api/log-report/report-all";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final kategoriTiket = kategoriTiketFromJson(body);
      // print(kategoriTiket);
      return kategoriTiket;
    } else {
      final body = req.body;
      final error = kategoriTiketFromJson(body);
      print(error);
      return error;
    }
  }
}

class GetAllUser {
  Future<List<Pengguna>> getPengguna() async {
    final url = "http://192.168.18.10:8080/api/user";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final pengguna = penggunaFromJson(body);
      // print(pengguna);
      return pengguna;
    } else {
      final body = req.body;
      final error = penggunaFromJson(body);
      return error;
    }
  }
}

class GetAllChapter {
  Future<List<Chapter>> getChapter() async {
    final url = "http://192.168.18.10:8080/api/log-report/chapter";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final chapter = chapterFromJson(body);
      return chapter;
    } else {
      final body = req.body;
      final error = chapterFromJson(body);
      return error;
    }
  }
}

class GetAllDetailTiketBugs {
  Future<List<TiketDetail>> getDetailBugs() async {
    final url = "http://192.168.18.10:8080/api/dashboard/status-report/bugs";
    final req = await http.get(Uri.parse(url));
    if (req.statusCode == 200) {
      final body = req.body;
      final detailTiketBugs = tiketDetailFromJson(body);
      return detailTiketBugs;
    } else {
      final body = req.body;
      final error = tiketDetailFromJson(body);
      return error;
    }
  }
}

class GetAllDetailTiketKnowledge {
  Future<List<TiketDetail>> getDetailKnowledge() async {
    final url = "http://192.168.18.10:8080/api/dashboard/status-report/knowledge";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final detailTiketKnowledge = tiketDetailFromJson(body);
      return detailTiketKnowledge;
    } else {
      final body = req.body;
      final error = tiketDetailFromJson(body);
      return error;
    }
  }
}

class GetAllDetailTiketProblem {
  Future<List<TiketDetail>> getDetailProblem() async {
    final url = "http://192.168.18.10:8080/api/dashboard/status-report/problem";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final detailTiketProblem = tiketDetailFromJson(body);
      return detailTiketProblem;
    } else {
      final body = req.body;
      final error = tiketDetailFromJson(body);
      return error;
    }
  }
}

class GetAllDetailTiketRequest {
  Future<List<TiketDetail>> getDetailRequest() async {
    final url = "http://192.168.18.10:8080/api/dashboard/status-report/request";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final detailTiketRequest = tiketDetailFromJson(body);
      return detailTiketRequest;
    } else {
      final body = req.body;
      final error = tiketDetailFromJson(body);
      return error;
    }
  }
}

class GetAllDetailTiketSupport {
  Future<List<TiketDetail>> getDetailSupport() async {
    final url = "http://192.168.18.10:8080/api/dashboard/status-report/support";
    final req = await http.get(Uri.parse(url));
    if (req.statusCode == 200) {
      final body = req.body;
      final detailTiketSupport = tiketDetailFromJson(body);
      return detailTiketSupport;
    } else {
      final body = req.body;
      final error = tiketDetailFromJson(body);
      return error;
    }
  }
}

class GetAllPicUser {
  Future<PicUser> getPICUsers() async {
    final url = "http://192.168.18.10:8080/api/log-report/get-pic";
    final req = await http.get(Uri.parse(url));
    if(req.statusCode == 200) {
      final body = req.body;
      final picUser = picUserFromJson(body);
      return picUser;
    } else {
      final body = req.body;
      final error = picUserFromJson(body);
      return error;
    }
  }
}