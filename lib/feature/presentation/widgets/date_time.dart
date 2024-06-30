import 'package:flutter/material.dart';
import '/constants/colors.dart';

class DateTimeWidget extends StatefulWidget {
  final String titleText;
  final String valueText;
  final IconData iconSection;
  final Function(DateTime) onTap;

  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.iconSection,
    required this.onTap,
  });

  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Material(
          child: Ink(
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                color: backPrimary,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(widget.iconSection),
                    const SizedBox(width: 12),
                    Text(selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : widget.valueText),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      locale: const Locale('ru', 'RU'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onTap(picked);
    }
  }
}
