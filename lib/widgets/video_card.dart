import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String thumbnailUrl;
  final VoidCallback onTap;
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const VideoCard({
    required this.thumbnailUrl,
    required this.onTap,
    required this.onDownload,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Image.network(
              thumbnailUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: Icon(Icons.download), onPressed: onDownload),
                IconButton(icon: Icon(Icons.share), onPressed: onShare),
                IconButton(icon: Icon(Icons.favorite_border), onPressed: onSave),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
