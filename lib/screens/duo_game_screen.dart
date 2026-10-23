import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/duo_challenges.dart';

class DuoGameScreen extends StatefulWidget {
  final List<String> playerNames;
  const DuoGameScreen({super.key, required this.playerNames});

  @override
  State<DuoGameScreen> createState() => _DuoGameScreenState();
}

class _DuoGameScreenState extends State<DuoGameScreen> {
  late List<int> _scores;
  late List<DuoChallenge> _allChallenges;
  final Set<int> _usedChallenges = {};
  int _p1Turn = 0;
  int _p2Turn = 1;
  int _roundsCompleted = 0;
  int _totalRounds = 3;
  bool _gameOver = false;
  DuoChallenge? _currentChallenge;

  @override
  void initState() {
    super.initState();
    _scores = List.filled(widget.playerNames.length, 0);
    _allChallenges = List.from(DuoChallengesData.all);
    _startTurn();
  }

  void _startTurn() {
    if (widget.playerNames.length > 1) {
      int first = math.Random().nextInt(widget.playerNames.length);
      int second;
      do { second = math.Random().nextInt(widget.playerNames.length); } while (second == first);
      _p1Turn = first; _p2Turn = second;
    }
    if (_usedChallenges.length >= _allChallenges.length) _usedChallenges.clear();
    int idx;
    do { idx = math.Random().nextInt(_allChallenges.length); } while (_usedChallenges.contains(idx));
    _usedChallenges.add(idx);
    _currentChallenge = _allChallenges[idx];
  }

  void _nextTurn(bool success) {
    setState(() {
      if (success) {
        _scores[_p1Turn] += 300;
        _scores[_p2Turn] += 300;
      } else {
        _scores[_p1Turn] -= 300;
        _scores[_p2Turn] -= 300;
      }
      _roundsCompleted++;
      if (_roundsCompleted >= _totalRounds) {
        _gameOver = true;
      } else {
        _startTurn();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();
    final p1 = widget.playerNames[_p1Turn];
    final p2 = widget.playerNames[_p2Turn];
    final challenge = _currentChallenge!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0A2A4A), Color(0xFF050A14)]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('لفة ${_roundsCompleted + 1} من $_totalRounds', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 18)),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _nameChip(p1, const Color(0xFFFFD54A)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('+', style: TextStyle(color: Colors.white, fontSize: 30))),
                  _nameChip(p2, const Color(0xFF00E5FF)),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00E5FF).withOpacity(0.1),
                    border: Border.all(color: const Color(0xFF00E5FF), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(challenge.emoji, style: const TextStyle(fontSize: 50)),
                      const SizedBox(height: 10),
                      Text(challenge.text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(child: _actionButton('مش هعملها', '-300', const Color(0xFFE24A4A), () => _nextTurn(false))),
                    const SizedBox(width: 14),
                    Expanded(child: _actionButton('خلصنا!', '+300', const Color(0xFF4ADE80), () => _nextTurn(true))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameChip(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Colors.black45, border: Border.all(color: color, width: 2), borderRadius: BorderRadius.circular(12)),
      child: Text(name, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionButton(String label, String sub, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          border: Border.all(color: color, width: 2.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(sub, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOver() {
    final sorted = List.generate(widget.playerNames.length, (i) => {'name': widget.playerNames[i], 'score': _scores[i]})
      ..sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0A2A4A), Color(0xFF050A14)])),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🏆', style: TextStyle(fontSize: 80)),
                const Text('الفايز!', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(sorted.first['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                Text('${sorted.first['score']} نقطة', style: const TextStyle(color: Color(0xFF4ADE80), fontSize: 24)),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)),
                  child: const Text('القائمة', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}