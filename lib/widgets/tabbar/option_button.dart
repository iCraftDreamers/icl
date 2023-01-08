import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  const OptionButton({
    Key? key,
    this.active = false,
    required this.text,
    required this.icon,
    required this.onChanged
  }) : super(key: key);

  final bool active;
  final String text;
  final dynamic icon;
  final ValueChanged<bool> onChanged;

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  bool _border = false;

  void _onTap() {
    widget.onChanged(!widget.active);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _border = false;
    });
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _border = true;
    });
  }

  void _onTapCancel() {
    setState(() {
      _border = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 7.5),
      child: GestureDetector(
        onTap: _onTap,
        onTapUp: _onTapUp,
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        child: _buildButton(),
      ),
    );
  }
  Widget _buildButton() {
    var fontStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: widget.active ? Colors.blue[300] : Colors.transparent,
        border: _border | widget.active ? Border.all(
          color: Colors.blueAccent,
          width: 1,
        ) : null,
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Icon(widget.icon,size: 30),
          const SizedBox(width: 5),
          Text(widget.text,style: fontStyle)
        ]
      )
    );
  }
}

class PeopleButton extends StatefulWidget {
  const PeopleButton({Key? key}) : super(key: key);

  @override
  State<PeopleButton> createState() => _PeopleButtonState();
}

class _PeopleButtonState extends State<PeopleButton> {
  bool _active = false;

  void _onChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OptionButton(
      text: "账户",
      icon: Icons.people,
      active: _active,
      onChanged: _onChanged
    );
  }
}

class GuiseButton extends StatefulWidget {
  const GuiseButton({Key? key}) : super(key: key);

  @override
  State<GuiseButton> createState() => _GuiseButtonState();
}

class _GuiseButtonState extends State<GuiseButton> {
  bool _active = false;

  void _onChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OptionButton(
      text: "外观",
      icon: Icons.palette,
      active: _active,
      onChanged: _onChanged
    );
  }
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

