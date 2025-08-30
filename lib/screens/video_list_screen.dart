import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_replay/screens/video_player_screen.dart';
import '../widgets/custom_appbar.dart';
import '../utils/firebase_video_service.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Você precisa estar logado.")),
      );
    }

    return Scaffold(
      appBar: customAppBar(context, "Vídeos"),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('saved_videos')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Caso não existam vídeos no Firestore → mostra vídeo de exemplo
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //return const Center(child: Text("Nenhum vídeo encontrado."));
            // Vídeo de exemplo (esporte)
            final exampleVideo = {
              'title': '3 SEGREDOS PARA NÃO ERRA MAIS O ATAQUE',
              'thumbnail': 'https://img.youtube.com/vi/q69bPeHXPi8/0.jpg', // thumbnail exemplo
              'file': 'https://archive.org/details/SampleVideo1280x7205mb', // link MP4 exemplo
            };

            return ListView(
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exampleVideo['title']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Image.network(exampleVideo['thumbnail']!),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VideoPlayerScreen(
                                      videoPath: exampleVideo['file']!,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text("Assistir"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          // Caso tenha vídeos do usuário no Firestore
          final videos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoData = video.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videoData['title'] ?? 'Sem título',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      videoData['thumbnail'] != null &&
                              videoData['thumbnail'].isNotEmpty
                          ? Image.network(videoData['thumbnail'])
                          : Container(
                              height: 150,
                              color: Colors.grey[300],
                              child: const Center(
                                  child: Icon(Icons.video_library, size: 50)),
                            ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implementar download
                            },
                            icon: const Icon(Icons.download),
                            label: const Text("Download"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Implementar compartilhar
                            },
                            icon: const Icon(Icons.share),
                            label: const Text("Compartilhar"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              // Salvar novamente no Firestore (pode ser usado para duplicar em outra coleção)
                              await FirebaseVideoService.saveVideo(
                                title: videoData['title'] ?? 'Sem título',
                                thumbnailUrl: videoData['thumbnail'] ?? '',
                                videoUrl: videoData['file'] ?? '',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Vídeo salvo no perfil!")),
                              );
                            },
                            icon: const Icon(Icons.bookmark),
                            label: const Text("Salvar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
