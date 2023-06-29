import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  WorldTime(this.location, this.flag, this.url);

  String location; //location name for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location irl for api endpoint
  late bool isDayTime;

  Future<void> getTime() async {
    try {
      String baseUrl = "http://worldtimeapi.org/api/timezone/";
      String urlStr = baseUrl + this.url;
      var url = Uri.parse(urlStr);
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      String offsetSign = data['utc_offset'].substring(0, 1);

      //create a dateTime obj
      DateTime now = DateTime.parse(dateTime);
      if (offsetSign == '-') {
        now = now.subtract(Duration(hours: int.parse(offset)));
      } else {
        now = now.add(Duration(hours: int.parse(offset)));
      }
      isDayTime = now.hour > 7 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = e.toString(); //or time='error loading data';
      isDayTime = false;
    }
  }
}
