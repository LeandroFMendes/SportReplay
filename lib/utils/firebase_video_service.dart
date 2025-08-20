import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseVideoService {
  // Upload do vídeo para Firebase Storage
  static Future<String> uploadVideo(File videoFile) async {
    final user = FirebaseAuth.instance.currentUser!;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('videos')
        .child(user.uid)
        .child('${DateTime.now().millisecondsSinceEpoch}.mp4');

    final uploadTask = storageRef.putFile(videoFile);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Gerar thumbnail e retornar caminho temporário
  static Future<String> generateThumbnail(File videoFile) async {
    final tempDir = await getTemporaryDirectory();
    final thumbPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 150,
      quality: 75,
    );
    return thumbPath ?? '';
  }

  // Salvar metadados no Firestore (incluindo thumbnail)
  static Future<void> saveVideo({
    required String title,
    required String videoUrl,
    String? thumbnailUrl,
  }) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('saved_videos')
        .add({
      "title": title,
      "thumbnail": thumbnailUrl ?? '',
      "file": videoUrl,
      "created_at": FieldValue.serverTimestamp(),
    });
  }

  // Upload do thumbnail para Storage (opcional)
  static Future<String> uploadThumbnail(File thumbFile) async {
    final user = FirebaseAuth.instance.currentUser!;
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('thumbnails')
        .child(user.uid)
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    final uploadTask = storageRef.putFile(thumbFile);
    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
