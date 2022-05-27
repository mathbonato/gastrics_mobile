import 'package:flutter/material.dart';

class CardImgDescription extends StatefulWidget {
  const CardImgDescription({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.img,
    this.editIcon = false,
    this.removeIcon = false,
    this.removeAction,
    this.editAction,
    this.onCardClick,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String img;
  final bool editIcon;
  final bool removeIcon;
  final Function? removeAction;
  final Function? editAction;
  final Function? onCardClick;

  @override
  State<CardImgDescription> createState() => _CardImgDescription();
}

class _CardImgDescription extends State<CardImgDescription> {
  @override
  Widget build(BuildContext context) {
    double screenWidthSize = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () => widget.onCardClick!(),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(widget.img),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                widget.editIcon
                    ? IconButton(
                        onPressed: () => widget.editAction!(),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : const SizedBox(),
                widget.removeIcon
                    ? IconButton(
                        onPressed: () => widget.removeAction!(),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
