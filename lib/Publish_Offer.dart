import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class ParkingRentalScreen extends StatefulWidget {
  @override
  _ParkingRentalScreenState createState() => _ParkingRentalScreenState();
}

class _ParkingRentalScreenState extends State<ParkingRentalScreen> {
  List<DateTime?> _selectedDates = [];
  CalendarDatePicker2Type _calendarType = CalendarDatePicker2Type.single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alquilar Estacionamiento'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Modo de selección: '),
              DropdownButton<CalendarDatePicker2Type>(
                value: _calendarType,
                onChanged: (value) {
                  setState(() {
                    _calendarType = value!;
                    _selectedDates = [];
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: CalendarDatePicker2Type.single,
                    child: Text('Un solo día'),
                  ),
                  DropdownMenuItem(
                    value: CalendarDatePicker2Type.range,
                    child: Text('Rango de días'),
                  ),
                  DropdownMenuItem(
                    value: CalendarDatePicker2Type.multi,
                    child: Text('Días específicos'),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: _calendarType,
              ),
              value: _selectedDates,
              onValueChanged: (dates) {
                setState(() {
                  _selectedDates = dates;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {}, // Utiliza el callback para cambiar al perfil
            child: Text('Publicar'),
          ),
        ],
      ),
    );
  }
}