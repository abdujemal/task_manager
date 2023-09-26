import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PickDate extends StatefulWidget {
  final String title;
  final String currentDate;
  final void Function(String val) onChange;
  final DateTimePickerType? dateTimePickerType;
  const PickDate({
    super.key,
    required this.title,
    required this.currentDate,
    required this.onChange,
    this.dateTimePickerType,
  });

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              widget.title,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DateTimePicker(
            initialValue: widget.currentDate,
            decoration: InputDecoration(
              suffix: widget.dateTimePickerType == DateTimePickerType.time
                  ? const Icon(Icons.timer)
                  : const Icon(Icons.event),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            type: widget.dateTimePickerType ?? DateTimePickerType.date,
            firstDate: widget.dateTimePickerType == DateTimePickerType.time
                ? null
                : DateTime(2000),
            lastDate: widget.dateTimePickerType == DateTimePickerType.time
                ? null
                : DateTime(2100),
            dateLabelText: widget.title,
            timeLabelText: widget.title,
            dateMask: widget.dateTimePickerType == DateTimePickerType.time
                ? null
                : 'd MMM, yyyy',
            locale: widget.dateTimePickerType == DateTimePickerType.time
                ? const Locale('en', 'US')
                : null,
            use24HourFormat: false,
            onChanged: widget.onChange,
            // validator: (value) {
            //   print(value);
            //   return value;
            // },
          ),
        ],
      ),
    );
  }
}
