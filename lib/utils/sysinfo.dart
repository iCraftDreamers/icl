import 'package:system_info2/system_info2.dart';

abstract class Sysinfo {
  static late final int getTotalPhysicalMemory;
  static late final int getFreePhysicalMemory;
  static const int megaByte = 1024 * 1024;

  static init() async {
    getTotalPhysicalMemory = SysInfo.getTotalPhysicalMemory();
    getFreePhysicalMemory = SysInfo.getFreePhysicalMemory();
  }
}
