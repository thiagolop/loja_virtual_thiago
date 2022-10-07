import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  const DrawerTitle({
    Key? key,
    required this.icon,
    required this.text,
    required this.controller,
    required this.page,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: controller.page == page
                    ? Theme.of(context).primaryColor
                    : const Color.fromARGB(255, 184, 5, 5),
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: controller.page == page
                      ? Theme.of(context).primaryColor
                      : const Color.fromARGB(255, 184, 5, 5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
