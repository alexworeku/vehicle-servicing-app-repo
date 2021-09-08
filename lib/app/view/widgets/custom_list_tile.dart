import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget title, subtitle, leading, trailing;
  const CustomListTile(
      {Key key, this.leading, this.title, this.subtitle, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          leading,
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      SizedBox(
                        height: 6,
                      ),
                      subtitle
                    ],
                  ),
                ),
                trailing
              ],
            ),
          )
        ],
      ),
    );
  }
}
