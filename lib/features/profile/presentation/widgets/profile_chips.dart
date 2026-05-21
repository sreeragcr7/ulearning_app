import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileChips extends StatelessWidget {
  const ProfileChips({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ChipItem> items = [
      _ChipItem(icon: Iconsax.video5, text: 'My Courses', onTap: () {}),
      _ChipItem(icon: Icons.book, text: 'Buy Courses', onTap: () {}),
      _ChipItem(icon: Icons.star, text: '4.9 Rating', onTap: () {}),
    ];

    return SizedBox(
      height: 70, // 👈 important
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: item.onTap,
            child: Container(
              width: 93, // 👈 same width for all
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 20, color: Colors.white),
                  const SizedBox(height: 6),
                  Text(
                    item.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ChipItem {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  _ChipItem({required this.text, required this.icon, required this.onTap});
}
