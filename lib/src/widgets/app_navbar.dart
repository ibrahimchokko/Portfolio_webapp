import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuTap;

  const AppNavbar({Key? key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Choko Portfolio'),
      backgroundColor: Colors.black,
      actions: [
        if (MediaQuery.of(context).size.width > 800)
          Row(
            children: [
              _navButton('Home', context),
              _navButton('Videos', context),
              _navButton('Articles', context),
              _navButton('Projects', context),
              _navButton('Contact', context),
              const SizedBox(width: 16),
            ],
          )
        else
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onMenuTap,
          )
      ],
    );
  }

  Widget _navButton(String label, BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
