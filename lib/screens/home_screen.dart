import 'package:flutter/material.dart';

import 'ahkam_players_screen.dart';
import 'celeb_players_screen.dart';
import 'draw_players_screen.dart';
import 'act_players_screen.dart';
import 'imit_players_screen.dart';
import 'duo_players_screen.dart';
import 'murders_levels_screen.dart'; // الجرائم موجودة

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 16),
                child: Column(
                  children: [
                    Text(
                      'تحدي الأصحاب',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFFFD54A),
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: const Color(0xFFFF6B6B).withOpacity(0.7),
                            blurRadius: 20,
                          ),
                          const Shadow(
                            color: Color(0xFF8A6000),
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'A GAME BY NOUR ELDIN',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF7AD7FF),
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.0,
                    children: [
                      _squareImage(context, 'assets/images/ahkam.png', 'الأحكام', const Color(0xFFFFD54A), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AhkamPlayersScreen()))),
                      _squareImage(context, 'assets/images/celeb.png', 'المشاهير', const Color(0xFF7AD7FF), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CelebPlayersScreen()))),
                      _squareImage(context, 'assets/images/draw.png', 'ارسم وخمّن', const Color(0xFFFF9B4A), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DrawPlayersScreen()))),
                      _squareImage(context, 'assets/images/act.png', 'مثّل موقف', const Color(0xFFC77AFF), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ActPlayersScreen()))),
                      _squareImage(context, 'assets/images/imit.png', 'قلّد صاحبك', const Color(0xFF4ADE80), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ImitPlayersScreen()))),
                      _squareImage(context, 'assets/images/duo.png', 'تحدي مشترك', const Color(0xFF00E5FF), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DuoPlayersScreen()))),
                      
                      // خانة الجرائم (بدون عجلة الحظ)
                      _squareImage(context, 'assets/images/murder.png', 'الجرائم', const Color(0xFFFF0000), () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MurdersLevelsScreen()))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _squareImage(BuildContext context, String imagePath, String title, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color, width: 2.5),
            boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 18)],
            image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(13), bottomRight: Radius.circular(13)),
                  ),
                  child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}