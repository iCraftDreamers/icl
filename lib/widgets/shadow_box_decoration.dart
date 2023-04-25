import 'package:flutter/material.dart';

import '../theme.dart';

BoxDecoration ShadowBoxDecoration(BuildContext context) {
  return BoxDecoration(
    borderRadius: MyTheme.borderRadius,
    color: Theme.of(context).extension<ShadowButtonTheme>()!.background,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.2), // 阴影的颜色
        offset: Offset(0, 5), // 阴影与容器的距离
        blurRadius: 10.0, // 高斯的标准偏差与盒子的形状卷积。
        spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
      ),
    ],
  );
}
