import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class VideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String court = args['court'];
    final DateTime date = args['date'];
    final String time = args['time'];

    // Lista de vídeos (simulada, depois pode vir do Firebase)
    final List<Map<String, String>> videos = [
      {"title": "Jogo 1", "thumbnail": "https://via.placeholder.com/400x200"},
      {"title": "Jogo 2", "thumbnail": "https://via.placeholder.com/400x200"},
      {"title": "Jogo 3", "thumbnail": "https://via.placeholder.com/400x200"},
    ];

    return Scaffold(
      appBar: customAppBar(context, "Vídeos"),
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
              "Data: ${date.day}/${date.month}/${date.year} - Horário: $time",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/video_player',
                          arguments: {
                            'video': video,
                          },
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              video["thumbnail"]!,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              video["title"]!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // lógica de download
                                  },
                                  icon: Icon(Icons.download),
                                  label: Text("Download"),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // lógica de compartilhar
                                  },
                                  icon: Icon(Icons.share),
                                  label: Text("Compartilhar"),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // lógica de salvar no perfil
                                  },
                                  icon: Icon(Icons.bookmark),
                                  label: Text("Salvar"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
