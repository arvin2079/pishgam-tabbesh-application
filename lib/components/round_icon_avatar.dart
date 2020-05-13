import 'package:flutter/material.dart';
import 'package:pishgamv2/constants/Constants.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {this.icon,
      this.iconSize,
      this.size = 80,
      this.imageAsset,
      this.onPressed});

  final IconData icon;
  final double size;
  final double iconSize;
  final String imageAsset;
  final Function onPressed;

  //todo: test onPressed
  //todo: test what happens when imageAsset is null

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: imageIconBorderColor, width: 2),
          borderRadius: BorderRadius.circular(200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildImageAsset(),
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: imageAsset != null ? Colors.black12 : Colors.white,
                ),
              ),
              Icon(
                imageAsset == null && icon == null ? Icons.person : icon,
                color:
                    imageAsset == null ? iconContentColor : cardBackgroudColor,
                size: iconSize == null ? 40 : iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //todo : find more efficient way to handle this error
  buildImageAsset() {
    if (imageAsset != null)
      return Image(
        fit: BoxFit.fitWidth,
        image: AssetImage(imageAsset),
        height: size,
        width: size,
      );
    else
      return Container(
        width: 0,
        height: 0,
      );
  }
}
