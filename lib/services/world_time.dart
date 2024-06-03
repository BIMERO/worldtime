import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
late
  String location;
  late String time;
  late String flag;
  late String url;
  late bool isDaytime;

  WorldTime ({required this.location, required this.flag, required this.url});

Future<void> getData() async {

  try{
    // you can replace your api link with this link
    final response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);

    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    print(datetime);
    print(offset);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDaytime = now.hour > 6 && now.hour < 17 ? true : false;
    time = DateFormat.jm().format(now);
  }catch(e){
    print('catch errors $e');
    time = 'could not get data';
  }

}


}
