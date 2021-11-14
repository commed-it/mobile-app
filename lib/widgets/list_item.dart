import 'package:flutter/material.dart';

/// 列表项
class ListItem extends StatefulWidget {
  // 点击事件
  final VoidCallback? onPressed;

  // 图标
  final Widget? icon;

  // 标题
  final String? title;
  final Color titleColor;

  // 描述
  final String? describe;
  final Color describeColor;

  // 右侧控件
  final Widget? rightWidget;

  // 构造函数
  ListItem({
    Key? key,
    this.onPressed,
    this.icon,
    this.title,
    this.titleColor: Colors.black,
    this.describe,
    this.describeColor: Colors.grey,
    this.rightWidget,
  }) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Container(
          height: 50.0,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              widget.icon != null
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: SizedBox(
                        height: 32.0,
                        width: 50.0,
                        child: widget.icon,
                      ),
                    )
                  : Container(
                      width: 14.0,
                    ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5,),
                    widget.title != null
                        ? Text(
                            widget.title!,
                            style: TextStyle(
                              color: widget.titleColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                    widget.describe != null
                        ? Text(
                            widget.describe!,
                            maxLines: 2,
                            style: TextStyle(
                                color: widget.describeColor, fontSize: 14.0),
                          )
                        : Container(),
                  ],
                ),
              ),
              widget.rightWidget ?? Container(),
              Container(
                width: 14.0,
              ),
            ],
          )),
    );
  }
}

/// 空图标
class EmptyIcon extends Icon {
  const EmptyIcon() : super(Icons.hourglass_empty);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
