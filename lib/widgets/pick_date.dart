import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class PickDate extends StatefulWidget {
  final String title;
  final String currentDate;
  final void Function(String val) onChange;
  const PickDate({
    super.key,
    required this.title,
    required this.currentDate, 
    required this.onChange,
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
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DateTimePicker(
            initialValue: widget.currentDate,
            decoration: const InputDecoration(
              suffix: Icon(Icons.event),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            type: DateTimePickerType.date,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            dateLabelText: 'Date',
            dateMask: 'd MMM, yyyy',
            onChanged: widget.onChange
          ),
        ],
      ),
    );
  }
}
