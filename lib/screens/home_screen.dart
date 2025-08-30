import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List<String> courts = [];

  @override
  void initState() {
    super.initState();
    fetchCourts();
  }

  Future<void> fetchCourts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('courts')
          .get();
      final courtNames = snapshot.docs
          .map((doc) => doc['name'] as String)
          .toList();
      setState(() {
        courts = courtNames;
      });
    } catch (e) {
      print("Erro ao buscar quadras: $e");
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _goToProfile() {
    Navigator.pushNamed(context, '/profile');
  }

  void _goToSchedule(String courtName) {
    Navigator.pushNamed(context, '/schedule', arguments: courtName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // ✅ título centralizado
        title: const Text(
          "Sport Replay",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.person), onPressed: _goToProfile),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Bem-vindo, ${user?.email ?? ''}!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Selecione a quadra para ver horários:",
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/video_list_screen');
              },
              child: const Text("Lista de videos"),
            ), // BOTÃO TEMPORÁRIO PARA IR PARA OS VIDEOS
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/record_screen');
              },
              child: const Text("Ir para Record Screen"),
            ),
            // Lista de quadras
            Expanded(
              child: courts.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: courts.length,
                      itemBuilder: (context, index) {
                        final court = courts[index];
                        return Card(
                          child: ListTile(
                            title: Text(court),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () => _goToSchedule(court),
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
