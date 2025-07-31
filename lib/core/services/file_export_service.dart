import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class FileExportService {
  static Future<String?> downloadReport(String data, String fileName) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted');
      }

      // Get the documents directory
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      // Write the data to the file
      await file.writeAsString(data);

      return file.path;
    } catch (e) {
      throw Exception('Failed to download report: $e');
    }
  }

  static Future<void> shareReport(String data, String fileName) async {
    try {
      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');

      // Write the data to the file
      await file.writeAsString(data);

      // Share the file
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Attendance Report: $fileName');
    } catch (e) {
      throw Exception('Failed to share report: $e');
    }
  }

  static Future<void> saveToDownloads(String data, String fileName) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted');
      }

      // Get the downloads directory (Android) or documents directory (iOS)
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getApplicationDocumentsDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final file = File('${directory.path}/$fileName');
      await file.writeAsString(data);
    } catch (e) {
      throw Exception('Failed to save report: $e');
    }
  }

  static String getFileExtension(String format) {
    switch (format.toLowerCase()) {
      case 'csv':
        return '.csv';
      case 'json':
        return '.json';
      case 'excel':
        return '.xlsx';
      default:
        return '.txt';
    }
  }

  static String generateFileName({
    required String institutionId,
    required String classId,
    required DateTime startDate,
    required DateTime endDate,
    required String format,
  }) {
    final startDateStr = startDate.toString().split(' ')[0];
    final endDateStr = endDate.toString().split(' ')[0];

    return 'attendance_report_$institutionId\_$classId\_$startDateStr\_$endDateStr${getFileExtension(format)}';
  }
}
