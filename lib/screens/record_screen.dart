import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gravação")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // volta para a tela anterior
          },
          child: Text("Voltar"),
        ),
      ),
    );
  }
}
