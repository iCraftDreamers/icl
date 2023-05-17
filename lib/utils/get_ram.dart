import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

// 定义一个typedef来表示C函数的类型签名
typedef MemoryStatusExFunc = Int32 Function(Pointer<MEMORYSTATUSEX>);

// 定义一个typedef来表示Dart函数的类型签名
typedef MemoryStatusEx = int Function(Pointer<MEMORYSTATUSEX>);

// 定义一个typedef来表示C函数的类型签名
typedef GetLastErrorFunc = Int32 Function();

// 定义一个typedef来表示Dart函数的类型签名
typedef GetLastError = int Function();

// 定义一个类来表示C结构体MEMORYSTATUSEX
final class MEMORYSTATUSEX extends Struct {
  @Uint32()
  external int dwLength;

  @Uint32()
  external int dwMemoryLoad;

  @Uint64()
  external int ullTotalPhys;

  @Uint64()
  external int ullAvailPhys;

  @Uint64()
  external int ullTotalPageFile;

  @Uint64()
  external int ullAvailPageFile;

  @Uint64()
  external int ullTotalVirtual;

  @Uint64()
  external int ullAvailVirtual;

  @Uint64()
  external int ullAvailExtendedVirtual;
}

late final String? libraryPath;
late final String functionName;
late final Pointer<NativeType> argument;
late final DynamicLibrary dylib;
final memoryStatus = dylib.lookupFunction<Int32 Function(Pointer<NativeType>),
    int Function(Pointer<NativeType>)>(functionName);
late final int result;

void init() {
  if (Platform.isWindows) {
    libraryPath = 'kernel32.dll';
    functionName = 'GlobalMemoryStatusEx';
    argument = calloc<MEMORYSTATUSEX>();
    (argument as Pointer<MEMORYSTATUSEX>).ref.dwLength =
        sizeOf<MEMORYSTATUSEX>();
  } else if (Platform.isLinux) {
    libraryPath = 'libc.so.6';
    functionName = 'sysconf';
    argument = calloc<Int64>();
    // _SC_PHYS_PAGES
    (argument as Pointer<Int64>).value = 30;
  } else if (Platform.isMacOS) {
    libraryPath = 'libSystem.dylib';
    functionName = 'sysconf';
    argument = calloc<Int64>();
    // _SC_PHYS_PAGES
    (argument as Pointer<Int64>).value = 2;
  }
  if (libraryPath == null) return;
  dylib = DynamicLibrary.open(libraryPath!);
  result = memoryStatus(argument);
  if (result == 0) {
    // 获取对C函数的引用，并放入一个变量中
    final getLastError = DynamicLibrary.process()
        .lookupFunction<GetLastErrorFunc, GetLastError>('GetLastError');

    print('Error: $getLastError');
    return;
  }
}

int freePhyMem() {
  if (Platform.isWindows) {
    return (argument as Pointer<MEMORYSTATUSEX>).ref.ullAvailPhys;
  } else if (Platform.isLinux || Platform.isMacOS) {
    final pageSize =
        dylib.lookupFunction<Int64 Function(Int64), int Function(int)>(
            'sysconf')(30); // _SC_PAGE_SIZE
    return result * pageSize;
  }
  return 0;
}
