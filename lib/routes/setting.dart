import 'package:flutter/cupertino.dart';

import '/widgets/page.dart';

class SettingPage extends BasePage with BasicPage {
  const SettingPage({super.key});

  @override
  String pageName() => "设置";

  Widget body() {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [head(), body()],
    );
  }
}
