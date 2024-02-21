import 'package:flutter/material.dart';

class ConstantButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  final Color color;
  final Color buttonColor;
  final Border? borderColor;
  final IconData? icon;
  final String? image;

  const ConstantButton({
    Key? key,
    required this.text,
    required this.color,
    this.icon,
    required this.voidCallback,
    required this.buttonColor,
    this.borderColor,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.06,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          border: borderColor ?? Border.all(color: Colors.transparent),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              icon != null
                  ? Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    )
                  : image != null
                      ? Image.asset(
                          image ?? '',
                          width: 30,
                          height: 30,
                          fit: BoxFit.scaleDown,
                        )
                      : Container(
                          width: 30,
                        ),
              const SizedBox(
                width: 70,
              ),
              Center(
                child: Text(
                  text,
                  style: TextStyle(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
