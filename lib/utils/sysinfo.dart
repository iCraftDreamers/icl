import 'dart:async';

import 'package:system_info2/system_info2.dart';

const kMegaByte = 1024 * 1024;

abstract class Sysinfo {
  static late final int totalPhysicalMemory;
  static late int _freePhysicalMemory;
  static bool _allowChange = true;

  static set freePhysicalMemory(int value) => freePhysicalMemory = value;

  // TODO: 执行SysInfo.getFreePhysicalMemory()时会出现卡顿，待修复
  static int get freePhysicalMemory {
    if (_allowChange) {
      _allowChange = false;
      Timer(const Duration(seconds: 1), () => _allowChange = true);
      Future(() => _freePhysicalMemory = SysInfo.getFreePhysicalMemory());
    }
    return _freePhysicalMemory;
  }

  static Future<void> init() async {
    totalPhysicalMemory = SysInfo.getTotalPhysicalMemory();
    _freePhysicalMemory = SysInfo.getFreePhysicalMemory();
  }
}
