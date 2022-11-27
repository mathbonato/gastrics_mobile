import 'package:flutter/material.dart';

class ListItem {
  String label;
  String value;

  ListItem(this.label, this.value);
}

class CuppertinoListInput extends StatefulWidget {
  const CuppertinoListInput(
      {Key? key,
      required this.items,
      required this.onChange,
      this.initialValue,
      })
      : super(key: key);

  final List<ListItem> items;
  final Function onChange;
  final String? initialValue;

  @override
  State<CuppertinoListInput> createState() => _CuppertinoListInput();
}

class _CuppertinoListInput extends State<CuppertinoListInput> {
  TextEditingController currentItemLabel = TextEditingController();
  TextEditingController currentItemValue = TextEditingController();
  var actualIdxItem = 0; 

  nextItem(int itemLength) {
    var newIdx = actualIdxItem + 1;

    if (newIdx < itemLength) {
      actualIdxItem = newIdx;
    }
    else {
      actualIdxItem = 0;
    }
  }

  backItem(int itemLength) {
    var newIdx = actualIdxItem - 1;

    if (newIdx >= 0) {
      actualIdxItem = newIdx;
    }
    else {
      actualIdxItem = itemLength - 1;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    List<ListItem> items = widget.items;
    var itemLength = items.length;

    if (currentItemLabel.text == "") {
      var firstValue = items[actualIdxItem].label;

      if (widget.initialValue != "" && widget.initialValue != null) {
        var idxFind = items.indexWhere((element) => element.value == widget.initialValue);
        firstValue = items[idxFind].label;
      }
        
      currentItemLabel.text = firstValue;
    } 

    return Material(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            IconButton(
              onPressed: () {
                backItem(itemLength);
                widget.onChange(items[actualIdxItem].value);
                currentItemLabel.text = items[actualIdxItem].label;
                setState(() {});
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey.shade400,
              ),
            ),
            Text(currentItemLabel.text),
            IconButton(
              onPressed: () {
                backItem(itemLength);
                widget.onChange(items[actualIdxItem].value);
                currentItemLabel.text = items[actualIdxItem].label;
                setState(() {});
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
              ),
            )
          ],
        ),
      )
    );
  }
}