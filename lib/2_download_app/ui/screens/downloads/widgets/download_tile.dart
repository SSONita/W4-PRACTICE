import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        Widget trailing;
        switch (controller.status) {
          case DownloadStatus.notDownloaded:
            trailing = IconButton(
              onPressed: controller.startDownload,
              icon: Icon(Icons.download),
            );
            break;
          case DownloadStatus.downloading:
            trailing = IconButton(
              onPressed: controller.startDownload,
              icon: Icon(Icons.downloading),
            );
            break;
          case DownloadStatus.downloaded:
            trailing = IconButton(
              onPressed: controller.startDownload,
              icon: Icon(Icons.folder),
            );
            break;
        }
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Text(controller.ressource.name),
            subtitle: Text(
              "${(controller.progress * 100).toStringAsFixed(1)}% completed "
              "- ${(controller.progress * controller.ressource.size).toStringAsFixed(1)} "
              "of ${controller.ressource.size} MB",
            ),
            trailing: trailing,
          ),
        );
      },
    );
    // TODO
  }
}
