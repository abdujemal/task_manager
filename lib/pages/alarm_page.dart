import 'package:flutter/material.dart';
import 'package:task_manager/constants.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  TextEditingController hourTc = TextEditingController();

  TextEditingController minTc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: hourTc,
                  ),
                ),
                const Text("H    :"),
                SizedBox(
                  width: 40,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: minTc,
                  ),
                ),
                const Text("M"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                if (hourTc.text.isNotEmpty && minTc.text.isNotEmpty) {
                  final totalMin =
                      (int.parse(hourTc.text) * 60) + int.parse(minTc.text);
                  print(totalMin);
                  // await AndroidAlarmManager.oneShot(
                  //   Duration(minutes: totalMin),
                  //   1,
                  //   printHello,
                  // );

                  // AndroidAlarmManager.periodic(duration, id, callback)

                  toast("Alarm has been set.", ToastType.success);

                  // SharedPreferences().
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: Ink(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Set",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// printHello() {
//   toast("Alarm works", ToastType.success);
//   AudioPlayer().play(AssetSource("alarm1.wav")).then((value) {
//     AudioPlayer().play(AssetSource("alarm2.wav"));
//   });
// }
