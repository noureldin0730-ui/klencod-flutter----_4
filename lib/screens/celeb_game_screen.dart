import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/celebrities.dart';

class CelebGameScreen extends StatefulWidget {
  final List<String> playerNames;

  const CelebGameScreen({super.key, required this.playerNames});

  @override
  State<CelebGameScreen> createState() => _CelebGameScreenState();
}

class _CelebGameScreenState extends State<CelebGameScreen> {
  late List<int> _scores;
  late List<Celebrity> _allCelebs;
  final Set<int> _usedCelebs = {};

  int _currentTurn = 0;
  bool _gameOver = false;
  bool _showStart = true;

  Celebrity? _currentCeleb;

  @override
  void initState() {
    super.initState();
    _scores = List.filled(widget.playerNames.length, 0);
    _allCelebs = List.from(CelebritiesData.all);
    _startTurn();
  }

  void _startTurn() {
    if (_usedCelebs.length >= _allCelebs.length) {
      _usedCelebs.clear();
    }
    int idx;
    do {
      idx = math.Random().nextInt(_allCelebs.length);
    } while (_usedCelebs.contains(idx));
    _usedCelebs.add(idx);
    _currentCeleb = _allCelebs[idx];
    _showStart = true;
  }

  void _startRound() {
    setState(() {
      _showStart = false;
    });
  }

  void _correct() {
    setState(() {
      _scores[_currentTurn] += 150;
      _nextTurn();
    });
  }

  void _wrong() {
    setState(() {
      _scores[_currentTurn] -= 150;
      _nextTurn();
    });
  }

  void _nextTurn() {
    _currentTurn++;
    if (_currentTurn >= widget.playerNames.length) {
      _currentTurn = 0;
    }
    _startTurn();
  }

  void _endGame() {
    setState(() {
      _gameOver = true;
    });
  }

  void _restart() {
    setState(() {
      _scores = List.filled(widget.playerNames.length, 0);
      _usedCelebs.clear();
      _currentTurn = 0;
      _gameOver = false;
      _startTurn();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();
    if (_showStart) return _buildStartScreen();
    return _buildGame();
  }

  Widget _buildStartScreen() {
    final playerName = widget.playerNames[_currentTurn];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A2A4A),
              Color(0xFF0A1A2A),
              Color(0xFF050A14),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Spacer(),
                const Text('📱', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                const Text(
                  'حط التليفون على جبهتك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(color: const Color(0xFF7AD7FF), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    playerName,
                    style: const TextStyle(
                      color: Color(0xFF7AD7FF),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'الباقيين هيوصفولك الاسم\nوانت لازم تخمن',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: _startRound,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7AD7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xFFFFD54A), width: 2),
                      ),
                    ),
                    child: const Text(
                      'ابدأ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _endGame,
                  child: const Text(
                    'إيقاف اللعبة',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGame() {
    final celeb = _currentCeleb!;
    final playerName = widget.playerNames[_currentTurn];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A2A4A),
              Color(0xFF0A1A2A),
              Color(0xFF050A14),
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
                    _chip('👤 $playerName', const Color(0xFF7AD7FF)),
                    const Spacer(),
                    _chip('نقاطه: ${_scores[_currentTurn]}', const Color(0xFFFFD54A)),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF7AD7FF).withOpacity(0.3),
                        const Color(0xFF7AD7FF).withOpacity(0.05),
                      ],
                    ),
                    border: Border.all(color: const Color(0xFF7AD7FF), width: 2),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7AD7FF).withOpacity(0.4),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(celeb.emoji, style: const TextStyle(fontSize: 70)),
                      const SizedBox(height: 14),
                      Text(
                        celeb.category,
                        style: const TextStyle(
                          color: Color(0xFFFFD54A),
                          fontSize: 16,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        celeb.name,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
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
                        label: 'خمنه غلط',
                        sub: '-150',
                        color: const Color(0xFFE24A4A),
                        onTap: _wrong,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _actionButton(
                        label: 'خمنه صح',
                        sub: '+150',
                        color: const Color(0xFF4ADE80),
                        onTap: _correct,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 13,
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
          height: 100,
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
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 15,
              ),
            ],
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
              const SizedBox(height: 6),
              Text(
                sub,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
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
              Color(0xFF0A3A4A),
              Color(0xFF0A1A2A),
              Color(0xFF050A14),
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
                    color: Color(0xFF7AD7FF),
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
                                ? const Color(0xFF7AD7FF)
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
                                    ? const Color(0xFF7AD7FF)
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
                          backgroundColor: const Color(0xFF7AD7FF),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFFFFD54A)),
                          ),
                        ),
                        child: const Text(
                          'العب تاني',
                          style: TextStyle(
                            color: Colors.black,
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