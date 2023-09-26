import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationService {
  Future<void> initNotification() async {
    try {
      AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        // 'resource://drawable/res_app_icon',
        null,
        [
          NotificationChannel(
            channelGroupKey: 'Task Manageer Channel Group',
            channelKey: 'Task Manageer Channel',
            channelName: 'Task Manageer notifications',
            channelDescription: 'Task Manageer Notification',
            defaultColor: Colors.red,
            ledColor: Colors.red,
          )
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'Task Manageer Channel Group',
              channelGroupName: 'Task Manageer')
        ],
        debug: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> showNotification(
      int id, String title, String body, DateTime? schedule) async {
    int seconds = 0;
    if (schedule != null) {
      DateTime now = DateTime.now();
      DateTime scheduledDate = DateTime(
        now.year,
        now.month,
        now.day,
        schedule.hour,
        schedule.minute,
      );

      if (now.isAfter(scheduledDate)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      seconds = scheduledDate.difference(now).inSeconds;
    }

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'Task Manageer Channel',
        title: title,
        body: body,
      ),
      schedule: schedule != null
          ? NotificationInterval(
              interval: seconds,
              allowWhileIdle: true,
            )
          : null,
    );
  }

  cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
