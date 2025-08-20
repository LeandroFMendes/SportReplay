import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class TimeSelectionScreen extends StatelessWidget {
  final List<String> times = [
    '08:00', '09:00', '10:00', '11:00', '12:00',
    '13:00', '14:00', '15:00', '16:00', '17:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Selecione o Horário'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: times.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/videos', arguments: times[index]);
              },
              child: Text(times[index]),
            );
          },
        ),
      ),
    );
  }
}
