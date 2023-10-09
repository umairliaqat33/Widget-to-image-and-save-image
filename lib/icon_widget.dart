import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Color color;
  final Function changeColor;
  const IconWidget({
    super.key,
    this.color = Colors.white,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 60.0,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Hello, Flutter!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'This is a beautiful Flutter UI example.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => changeColor(),
          child: const Text('Click Me to change color'),
        ),
      ],
    );
  }
}
