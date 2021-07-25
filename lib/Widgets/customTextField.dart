import 'package:flutter/material.dart';

class CustomTextFiel extends StatefulWidget {
  final String? hintText;
  final Icon? prefixIcon;
  final IconButton? subfixIcon;
  final bool hasPassword;
  final Function? onPresss;
  final TextInputType? textInputType;
  final double? height;
  final Color? color;
  final double circular;
  final TextEditingController? textEditingController;

  const CustomTextFiel({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.subfixIcon,
    required this.hasPassword,
    this.onPresss,
    this.textInputType,
    this.height,
    this.color,
    required this.circular,
    this.textEditingController,
  }) : super(key: key);

  @override
  _CustomTextFielState createState() => _CustomTextFielState();
}

class _CustomTextFielState extends State<CustomTextFiel> {
  bool _showPassword1 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0, 3),
            ),
          ],
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.circular),
        ),
        height: widget.height,
        child: widget.hasPassword
            ? TextField(
                controller: widget.textEditingController,
                keyboardType: widget.textInputType,
                obscureText: !_showPassword1,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: IconButton(
                    icon: _showPassword1
                        ? Icon(
                            Icons.visibility_rounded,
                            size: 30,
                          )
                        : Icon(Icons.visibility_off_rounded),
                    onPressed: () {
                      setState(() {
                        _showPassword1 = !_showPassword1;
                      });
                    },
                  ),
                  border: InputBorder.none,
                ),
              )
            : TextField(
                controller: widget.textEditingController,
                keyboardType: widget.textInputType,
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.subfixIcon,
                  border: InputBorder.none,
                ),
              ),
      ),
    );
  }
}
