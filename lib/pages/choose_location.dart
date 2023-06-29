import 'package:flutter/material.dart';
import 'package:world_time/services/word_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;
  List<WorldTime> locations = [
    WorldTime('London', 'uk.png', 'Europe/London'),
    WorldTime('Athens', 'greece.png', 'Europe/Athens'),
    WorldTime('Cairo', 'egypt.png', 'Africa/Cairo'),
    WorldTime('Nairobi', 'kenya.png', 'Africa/Nairobi'),
    WorldTime('Chicago', 'usa.png', 'America/Chicago'),
    WorldTime('New York', 'usa.png', 'America/New_York'),
    WorldTime('Seoul', 'south_korea.png', 'Asia/Seoul'),
    WorldTime('Jakarta', 'indonesia.png', 'Asia/Jakarta'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    //Navigate to homeScreen
    if (!context.mounted) return;
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Choose a location"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
