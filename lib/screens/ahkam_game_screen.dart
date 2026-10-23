import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/challenges.dart';

class AhkamGameScreen extends StatefulWidget {
  final List<String> playerNames;

  const AhkamGameScreen({super.key, required this.playerNames});

  @override
  State<AhkamGameScreen> createState() => _AhkamGameScreenState();
}

class _AhkamGameScreenState extends State<AhkamGameScreen> {
  late List<int> _scores;
  late List<Challenge> _allChallenges;
  final Set<int> _usedChallenges = {};

  int _currentTurn = 0;
  int _roundsCompleted = 0;
  int _totalRounds = 3;
  int _highScore = 0;
  bool _gameOver = false;

  Challenge? _currentChallenge;

  @override
  void initState() {
    super.initState();
    _scores = List.filled(widget.playerNames.length, 0);
    _allChallenges = List.from(ChallengesData.all);
    _loadHighScore();
    _startTurn();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _highScore = prefs.getInt('ahkam_high') ?? 0;
    });
  }

  Future<void> _saveHighScore() async {
    final maxScore = _scores.reduce(math.max);
    if (maxScore > _highScore) {
      _highScore = maxScore;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('ahkam_high', _highScore);
    }
  }

  void _startTurn() {
    if (_usedChallenges.length >= _allChallenges.length) {
      _usedChallenges.clear();
    }
    int idx;
    do {
      idx = math.Random().nextInt(_allChallenges.length);
    } while (_usedChallenges.contains(idx));
    _usedChallenges.add(idx);
    _currentChallenge = _allChallenges[idx];
  }

  void _completeChallenge() {
    setState(() {
      _scores[_currentTurn] += 150;
      _nextTurn();
    });
  }

  void _skipChallenge() {
    setState(() {
      _scores[_currentTurn] -= 150;
      _nextTurn();
    });
  }

  void _nextTurn() {
    _currentTurn++;
    if (_currentTurn >= widget.playerNames.length) {
      _currentTurn = 0;
      _roundsCompleted++;
      if (_roundsCompleted >= _totalRounds) {
        _gameOver = true;
        _saveHighScore();
        return;
      }
    }
    _startTurn();
  }

  void _restart() {
    setState(() {
      _scores = List.filled(widget.playerNames.length, 0);
      _usedChallenges.clear();
      _currentTurn = 0;
      _roundsCompleted = 0;
      _gameOver = false;
      _startTurn();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();
    return _buildGame();
  }

  Widget _buildGame() {
    final playerName = widget.playerNames[_currentTurn];
    final challenge = _currentChallenge!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A0A4A),
              Color(0xFF1A0A2A),
              Color(0xFF0A0514),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _chip('🏆 $_highScore', const Color(0xFFFF9B4A)),
                    const Spacer(),
                    _chip(
                      'لفة ${_roundsCompleted + 1}/$_totalRounds',
                      const Color(0xFF7AD7FF),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  border: Border.all(color: const Color(0xFFFFD54A), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  playerName,
                  style: const TextStyle(
                    color: Color(0xFFFFD54A),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'نقاطك: ${_scores[_currentTurn]}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFF6B6B).withOpacity(0.3),
                        const Color(0xFFFF6B6B).withOpacity(0.05),
                      ],
                    ),
                    border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(challenge.emoji, style: const TextStyle(fontSize: 50)),
                      const SizedBox(height: 10),
                      Text(
                        challenge.category,
                        style: const TextStyle(
                          color: Color(0xFF7AD7FF),
                          fontSize: 14,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        challenge.text,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: _actionButton(
                        label: 'مش هعملها',
                        sub: '-150',
                        color: const Color(0xFFE24A4A),
                        onTap: _skipChallenge,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _actionButton(
                        label: 'خلصت!',
                        sub: '+150',
                        color: const Color(0xFF4ADE80),
                        onTap: _completeChallenge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required String sub,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.4),
                color.withOpacity(0.15),
              ],
            ),
            border: Border.all(color: color, width: 2.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sub,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOver() {
    final sortedPlayers = List.generate(
      widget.playerNames.length,
      (i) => {'name': widget.playerNames[i], 'score': _scores[i]},
    )..sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    final winner = sortedPlayers.first;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A2A0A),
              Color(0xFF2A0A2A),
              Color(0xFF0A0514),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Spacer(),
                const Text('🏆', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 10),
                const Text(
                  'الفايز!',
                  style: TextStyle(
                    color: Color(0xFFFFD54A),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  winner['name'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${winner['score']} نقطة',
                  style: const TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedPlayers.length,
                    itemBuilder: (_, i) {
                      final p = sortedPlayers[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          border: Border.all(
                            color: i == 0
                                ? const Color(0xFFFFD54A)
                                : const Color(0x33FFFFFF),
                            width: i == 0 ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${i + 1}.',
                              style: TextStyle(
                                color: i == 0
                                    ? const Color(0xFFFFD54A)
                                    : Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                p['name'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${p['score']}',
                              style: TextStyle(
                                color: (p['score'] as int) >= 0
                                    ? const Color(0xFF4ADE80)
                                    : const Color(0xFFE24A4A),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFF7AD7FF)),
                          ),
                        ),
                        child: const Text(
                          'القائمة',
                          style: TextStyle(
                            color: Color(0xFF7AD7FF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _restart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B6B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFFFFD54A)),
                          ),
                        ),
                        child: const Text(
                          'العب تاني',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}