import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/abstract_session.dart';
import 'package:ffmpeg_kit_flutter/log.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AudioUtil {
  static AudioUtil? _instance;

  static AudioUtil get instance {
    _instance ??= AudioUtil._init();
    return _instance!;
  }

  AudioUtil._init();

  factory AudioUtil() {
    return instance;
  }

  void merge(List files, String outputPath) {

    String fileList = files.map((file) => "-i $file").join(" ");
    String command = "$fileList -filter_complex concat=n=${files.length}:v=0:a=1 -c:a aac $outputPath";

    int now = DateTime.now().millisecondsSinceEpoch;

    print('command>>>>>>$command');
    FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      print('====returnCode=$returnCode');

      final duration = await session.getDuration();
      print('====duration=$duration');

      List<Log> logs = await session.getLogs();
      for(var log in logs) {
        print('====log=${log.getMessage()}');
      }

      final statistics = await session.getStatistics();
      print('====statistics=$statistics');

      final state = await session.getState();
      print('====state=$state');

      print('==>>>>>>>time: ${DateTime.now().millisecondsSinceEpoch - now}');
    });

  }


  void test() async {

    List list = [
      'assets/files/01.aac',
      'assets/files/07.ogg',
      'assets/files/13.wav',
      'assets/files/sample1.aac',
    ];

    List outputList = [
      '01.aac',
      '07.ogg',
      '13.wav',
      'sample1.aac',
    ];
    Directory tempDir = await getTemporaryDirectory();

    // outputList = outputList.map((e) => '${tempDir.path}/$e').toList();




    Directory audioDirectory = Directory('${tempDir.path}/audio2');
    if (audioDirectory.existsSync()) {
      outputList.clear();
      List<FileSystemEntity> files = audioDirectory.listSync(recursive: true);
      for (FileSystemEntity file in files) {
        if (file is File) {
          outputList.add(file.path);
        }
      }
    }


    // for(var item in list) {
    //   String output = item.replaceAll('assets/files/', '');
    //
    //   String? result = await copyWavFileToTempDirectory(item, output);
    //   if(result == null) {
    //     return;
    //   }
    //   if(result != null) {
    //     outputList.add(output);
    //   }
    // }

    String outputPath = '${tempDir.path}/output2.aac';
    File file = File(outputPath);
    if(file.existsSync()) {
      file.deleteSync();
    }
    merge(outputList, outputPath);

  }

  Future<String?> copyWavFileToTempDirectory(String input, String output) async {
    // 获取临时目录路径
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      final assetFile = await rootBundle.load(input);
      final file = File('$tempPath/$output');
      await file.writeAsBytes(assetFile.buffer.asUint8List());
      print('WAV file copied to temporary directory: ${file.path}');
      return file.path;
    } catch (e) {
      print('Failed to copy WAV file to temporary directory: $e');
    }
    return null;
  }


}
