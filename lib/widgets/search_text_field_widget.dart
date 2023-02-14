import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///文本搜索框
class SearchTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTab;
  final String hintText;
  final EdgeInsetsGeometry margin;
   var controller = TextEditingController();


  SearchTextFieldWidget({Key key, this.hintText, this.onSubmitted, this.onTab, this.margin,this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.all(0.0) : margin,
      width: MediaQuery.of(context).size.width,
      height: 36.0,
      decoration: BoxDecoration(
          color: Color(0xff3A3A44),
          borderRadius: BorderRadius.horizontal(left:  Radius.elliptical(2, 2),right: Radius.elliptical(0, 0))),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTab,
        cursorColor: Color(0xffFF324D),
        decoration: InputDecoration(
            isDense:true,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 14, color: Color(0xff8B8C91)),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: TextStyle(fontSize: 14,),
        controller: controller,
        ),
    );
  }

  getContainer(BuildContext context, ValueChanged<String> onSubmitted) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 20),
            prefixIcon: Icon(
              Icons.search,
              size: 29,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
