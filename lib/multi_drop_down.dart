import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';

typedef OnConfirm(List selectedValues);

/// 下拉多选
/// Created by Shusheng.
class MultipleDropDown extends StatefulWidget {
  final List values;
  final List<MultipleSelectItem> elements;
  final String? placeholder;
  final bool disabled;
  final VoidCallback? onClose;

  MultipleDropDown({
    Key? key,
    required this.values,
    required this.elements,
    this.placeholder,
    this.disabled = false,
    this.onClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MultipleDropDownState();
}

class MultipleDropDownState extends State<MultipleDropDown> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Opacity(
              opacity: this.widget.disabled ? 0.4 : 1,
              child: Container(
                // margin: EdgeInsets.only(right: 8),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: this._getContent(),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 5.5),
                      child: Icon(Icons.list, color: Colors.black54),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 0.5, color: Colors.grey[350]!))),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        if (!this.widget.disabled)
          MultipleSelect.showMultipleSelector(
            context,
            elements: this.widget.elements,
            values: this.widget.values,
            title: this.widget.placeholder,
          ).then((values) {
            this.setState(() {});
            print("on close");
            if (widget.onClose != null) {
              widget.onClose!();
            }
          });
      },
    );
  }

  Widget _getContent() {
    if (this.widget.values.length <= 0 && this.widget.placeholder != null) {
      return Padding(
        child: Text(
          this.widget.placeholder!,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 0),
      );
    } else {
      return Wrap(
        children: this
            .widget
            .elements
            .where((element) => this.widget.values.contains(element.value))
            .map(
              (element) => Container(
                margin: EdgeInsets.only(right: 2),
                child: RawChip(
                  isEnabled: !this.widget.disabled,
                  label: Text(
                    element.display,
                    style: TextStyle(fontSize: 12),
                  ),
                  onDeleted: () {
                    if (!this.widget.disabled) {
                      this.widget.values.remove(element.value);
                      this.setState(() {});
                    }
                  },
                ),
              ),
            )
            .toList(),
      );
    }
  }
}
