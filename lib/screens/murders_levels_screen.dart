import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'murders_game_screen.dart';
import '../data/murders_data.dart';

class MurdersLevelsScreen extends StatefulWidget {
  const MurdersLevelsScreen({super.key});

  @override
  State<MurdersLevelsScreen> createState() => _MurdersLevelsScreenState();
}

class _MurdersLevelsScreenState extends State<MurdersLevelsScreen> {
  int _unlockedLevel = 1;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _unlockedLevel = prefs.getInt('murder_unlocked') ?? 1;
      _loading = false;
    });
  }

  Future<void> _unlockNextLevel() async {
    if (_unlockedLevel < MurdersData.all.length) {
      setState(() {
        _unlockedLevel++;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('murder_unlocked', _unlockedLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('سجل الجرائم', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: MurdersData.all.length,
        itemBuilder: (_, i) {
          final level = i + 1;
          final isUnlocked = level <= _unlockedLevel;
          return Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  if (isUnlocked) {
                    final won = await Navigator.of(context).push<bool>(
                      MaterialPageRoute(
                        builder: (_) => MurdersGameScreen(caseIndex: i, levelNumber: level),
                      ),
                    );
                    if (won == true) {
                      _unlockNextLevel();
                    }
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isUnlocked ? Colors.redAccent : Colors.grey.shade800,
                      width: 3,
                    ),
                    boxShadow: isUnlocked ? [BoxShadow(color: Colors.redAccent.withOpacity(0.3), blurRadius: 20, spreadRadius: 2)] : [],
                  ),
                  child: Center(
                    child: Text(
                      isUnlocked ? '$level' : '🔒',
                      style: TextStyle(
                        color: isUnlocked ? Colors.white : Colors.grey.shade700,
                        fontSize: isUnlocked ? 32 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}