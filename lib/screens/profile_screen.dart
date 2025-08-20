import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../widgets/custom_appbar.dart';
import '../utils/firebase_video_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Você precisa estar logado.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Perfil",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // volta para a tela anterior
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá, ${user.displayName ?? user.email ?? 'Usuário'}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
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

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("Nenhum vídeo salvo no perfil."));
                  }

                  final videos = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final videoData =
                          videos[index].data() as Map<String, dynamic>;

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
                                          child: Icon(Icons.video_library,
                                              size: 50)),
                                    ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      // Salvar novamente (duplicar no perfil se desejar)
                                      await FirebaseVideoService.saveVideo(
                                        title: videoData['title'] ?? '',
                                        thumbnailUrl:
                                            videoData['thumbnail'] ?? '',
                                        videoUrl: videoData['file'] ?? '',
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Vídeo salvo no perfil!")));
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
            ),
          ],
        ),
      ),
    );
  }
}
