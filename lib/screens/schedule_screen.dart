import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // argumentos passados pela HomeScreen
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String court = args['court'];
    final DateTime date = args['date'];

    // Horários de exemplo (poderão vir do Firebase no futuro)
    final List<String> horarios = [
      "08:00",
      "09:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
    ];

    return Scaffold(
      appBar: customAppBar(context, "Horários"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quadra: $court",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Data: ${date.day}/${date.month}/${date.year}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: horarios.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/videos',
                          arguments: {
                            'court': court,
                            'date': date,
                            'time': horarios[index],
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("Horário ${horarios[index]}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
