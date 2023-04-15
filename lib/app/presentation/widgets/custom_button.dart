import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_news/app/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      required this.hasColor,
      this.iconPath,
      required this.onTap, required this.titleColor})
      : super(key: key);
  final String title;
  final bool hasColor;
  final Color titleColor;
  final String? iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 55,
          decoration: BoxDecoration(
            color:
                hasColor ? AppTheme.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: hasColor?null:Border.all(color: AppTheme.grey400)
          ),
          child: iconPath == null
              ? Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: titleColor,fontWeight: FontWeight.bold),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(iconPath!),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                )),
    );
  }
}
