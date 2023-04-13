import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'package:archive/archive.dart';

/// Game对象 存储一个游戏的信息
///
/// [jsonData]传入解析好的json数据
///
/// [path]传入路径
///
/// [jar]传入jar文件路径

class Game {
  late final String path; //版本文件夹路径
  late final String jar; //jar文件路径
  late final String id; //游戏名
  late final String version; //游戏版本
  late final String type;
  String? Forge; //Forge版本
  String? Fabric;
  String? OptiFine; //OptiFine版本
  bool? LiteLoader;
  String? Quilt;

  Game(Map jsonData, String this.path, String this.jar) {
    //初始化对象,并读取该版本的信息
    _readInfo(jsonData);
    _readLibraries(jsonData['libraries']);
  }

  void printInfo() {
    print(longDescribe());
    // print(
    // "id: $id, version: $version, type:$type, Forge:$Forge, OptiFine:$OptiFine");
  }

  String shortDescribe() {
    Map<String, String> typeName = {
      "release": "正式版",
      "snapshot": "预览版",
      "old_beta": "远古版",
    };
    return "${typeName[type]}, $version";
  }

  String longDescribe() {
    StringBuffer desc = StringBuffer("$version");
    if (LiteLoader == true) desc.write("  LiteLoader");
    if (Forge != null) desc.write("  Forge:$Forge");
    if (Fabric != null) desc.write("  Fabric:$Fabric");
    if (Quilt != null) desc.write("  Quilt:$Quilt");
    if (OptiFine != null) desc.write("  OptiFine:$OptiFine");
    return desc.toString();
  }

  Future<void> _readInfo(data) async {
    //读取版本，发布类型与版本号

    String fromJar() {
      final by = jsonDecode(utf8.decode(ZipDecoder()
          .decodeBytes(File(jar).readAsBytesSync())
          .findFile("version.json")!
          .content as List<int>));
      return by["id"];
    }

    this.id = data['id'];
    this.type = data['type'];
    this.version = data['clientVersion'] ?? data['jar'] ?? fromJar();
  }

  Future<void> _readLibraries(libraries) async {
    //读取是否安装Forge,高清修复等
    RegExp ForgeExp = RegExp(
        "(net.minecraftforge:forge|net.minecraftforge:fmlloader):1.[0-9+.]+-");
    RegExp FabricExp = RegExp("net.fabricmc:fabric-loader:");
    RegExp LiteLoaderExp = RegExp("liteloader");
    RegExp QuiltExp = RegExp("org.quiltmc:quilt-loader:");
    RegExp OptifineExp = RegExp("optifine:OptiFine:1.[0-9+.]+_");
    libraries.forEach((e) {
      String str = e.toString();
      if (LiteLoaderExp.hasMatch(str)) this.LiteLoader = true;
      if (ForgeExp.hasMatch(str))
        this.Forge = e["name"].toString().replaceAll(ForgeExp, '');
      if (FabricExp.hasMatch(str))
        this.Fabric = e["name"].toString().replaceAll(FabricExp, '');
      if (QuiltExp.hasMatch(str))
        this.Quilt = e["name"].toString().replaceAll(QuiltExp, '');
      if (OptifineExp.hasMatch(str))
        this.OptiFine = e["name"].toString().replaceAll(OptifineExp, '');
    });
  }
}

class GameManaging {
  /// GameManaging.installedGames[下标].[变量]
  /// 以获取相应下标的对象的变量值
  /// [path] 版本文件夹路径
  ///
  /// [jar] jar文件路径
  ///
  /// [id] 游戏名
  ///
  /// [version] 游戏版本
  ///
  /// [Forge] Forge版本
  ///
  /// [OptiFine] OptiFine版本
  ///
  /// Examples:
  /// ```dart
  /// GameManaging.installedGames.forEach( //遍历此数组当中的对象
  ///   (element) => print(element.path), //打印遍历到的对象的path
  ///     );
  ///
  /// ```
  static List<Game> installedGames = []; //以对象存储已安装的游戏

  static final List<Map<String, dynamic>> constGameDirs = [
    //固有.minecraft目录
    {"name": "启动器下游戏目录", "Directory": Directory('.minecraft')},
    {
      "name": "官方启动器游戏目录",
      "Directory": Directory('%appdata%/Roadming/.minecraft')
    },
  ];

  static List<Map<String, dynamic>> additionGameDir = [
    //额外.minecraft目录，可添加可删除
    {"name": "", "Directory": Directory('D:/游戏/Minecraft/1.8/.minecraft')},
    {"name": "", "Directory": Directory('F:/mc/main/.minecraft')},
  ];

  static void addDir(String dir, String? name) {
    additionGameDir.add({"name": name, "Directory": Directory(dir)});
  }

  static Future<void> init() async {
    installedGames.clear();

    File convertToFile(FileSystemEntity dir, String type) {
      //当系统为Windows时转换斜杠，防止无法获取当前文件夹名
      return File(
          '${dir.path}/${dir.path.split(Platform.isWindows ? '\\' : '/').last}.${type}');
    }

    Future<void> _searchGame(Directory dir) async {
      //搜索versions文件夹下的文件夹
      if (await dir.exists())
        dir
            .listSync()
            .where((e) => e is Directory)
            .forEach((e) => Future(() async {
                  File json = convertToFile(dir, "json");
                  File jar = convertToFile(dir, "jar");
                  //判断是否为合法的已安装版本目录
                  if (await json.exists())
                    //解析json文件并添加
                    installedGames.add(Game(
                        jsonDecode(await json.readAsString()),
                        dir.path,
                        jar.path));
                }));
    }

    //遍历游戏搜索.minecraft目录
    for (Map map in constGameDirs)
      _searchGame(Directory('${map["Directory"].path}/versions'));
    for (Map map in additionGameDir)
      _searchGame(Directory('${map["Directory"].path}/versions'));
  }
}
