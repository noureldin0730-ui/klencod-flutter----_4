import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/drawing_words.dart';

class DrawGameScreen extends StatefulWidget {
  final List<String> playerNames;

  const DrawGameScreen({super.key, required this.playerNames});

  @override
  State<DrawGameScreen> createState() => _DrawGameScreenState();
}

class _DrawGameScreenState extends State<DrawGameScreen> {
  late List<int> _scores;
  late List<DrawingWord> _allWords;
  final Set<int> _usedWords = {};

  int _currentTurn = 0;
  bool _gameOver = false;
  bool _showStart = true;

  DrawingWord? _currentWord;

  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];

  @override
  void initState() {
    super.initState();
    _scores = List.filled(widget.playerNames.length, 0);
    _allWords = List.from(DrawingWordsData.all);
    _startTurn();
  }

  void _startTurn() {
    if (_usedWords.length >= _allWords.length) {
      _usedWords.clear();
    }
    int idx;
    do {
      idx = math.Random().nextInt(_allWords.length);
    } while (_usedWords.contains(idx));
    _usedWords.add(idx);
    _currentWord = _allWords[idx];
    _showStart = true;
    _strokes.clear();
    _currentStroke = [];
  }

  void _startRound() {
    setState(() {
      _showStart = false;
      _strokes.clear();
      _currentStroke = [];
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
      _usedWords.clear();
      _currentTurn = 0;
      _gameOver = false;
      _strokes.clear();
      _currentStroke = [];
      _startTurn();
    });
  }

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
      _currentStroke = [];
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
    final word = _currentWord!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A2A0A),
              Color(0xFF2A1A0A),
              Color(0xFF140A05),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Spacer(),
                Text(word.emoji, style: const TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                const Text(
                  'دورك ترسم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(color: const Color(0xFFFF9B4A), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    playerName,
                    style: const TextStyle(
                      color: Color(0xFFFF9B4A),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'الكلمة اللي هترسمها:',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF9B4A).withOpacity(0.3),
                        const Color(0xFFFF9B4A).withOpacity(0.1),
                      ],
                    ),
                    border: Border.all(color: const Color(0xFFFFD54A), width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    word.word,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  '⚠️ متقولش الكلمة لأصحابك',
                  style: TextStyle(
                    color: Color(0xFFFF6B6B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: _startRound,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9B4A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xFFFFD54A), width: 2),
                      ),
                    ),
                    child: const Text(
                      'ابدأ الرسم',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
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
    final playerName = widget.playerNames[_currentTurn];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A2A0A),
              Color(0xFF2A1A0A),
              Color(0xFF140A05),
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
                    _chip('👤 $playerName', const Color(0xFFFF9B4A)),
                    const Spacer(),
                    _chip('نقاطه: ${_scores[_currentTurn]}', const Color(0xFFFFD54A)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFFF9B4A), width: 3),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF9B4A).withOpacity(0.4),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: GestureDetector(
                      onPanStart: (details) {
                        setState(() {
                          _currentStroke = [details.localPosition];
                        });
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          _currentStroke.add(details.localPosition);
                        });
                      },
                      onPanEnd: (details) {
                        setState(() {
                          _strokes.add(List.from(_currentStroke));
                          _currentStroke = [];
                        });
                      },
                      child: CustomPaint(
                        painter: _DrawingPainter(
                          strokes: _strokes,
                          currentStroke: _currentStroke,
                        ),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    const Text(
                      'ارسم بإصبعك على اللوحة',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: _clearCanvas,
                      icon: const Icon(Icons.clear, color: Color(0xFFFF6B6B), size: 18),
                      label: const Text(
                        'امسح',
                        style: TextStyle(color: Color(0xFFFF6B6B), fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: _actionButton(
                        label: 'مش عارفين',
                        sub: '-150',
                        color: const Color(0xFFE24A4A),
                        onTap: _wrong,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _actionButton(
                        label: 'خمنوا صح',
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
          height: 80,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sub,
                style: TextStyle(
                  color: color,
                  fontSize: 15,
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
              Color(0xFF4A3A0A),
              Color(0xFF2A1A0A),
              Color(0xFF140A05),
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
                    color: Color(0xFFFF9B4A),
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
                                ? const Color(0xFFFF9B4A)
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
                                    ? const Color(0xFFFF9B4A)
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
                            side: const BorderSide(color: Color(0xFFFF9B4A)),
                          ),
                        ),
                        child: const Text(
                          'القائمة',
                          style: TextStyle(
                            color: Color(0xFFFF9B4A),
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
                          backgroundColor: const Color(0xFFFF9B4A),
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

class _DrawingPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;

  _DrawingPainter({
    required this.strokes,
    required this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.length < 2) {
        if (stroke.isNotEmpty) {
          canvas.drawCircle(stroke.first, 2.5, Paint()..color = Colors.black);
        }
        continue;
      }
      final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }

    if (currentStroke.length >= 2) {
      final path = Path()..moveTo(currentStroke.first.dx, currentStroke.first.dy);
      for (int i = 1; i < currentStroke.length; i++) {
        path.lineTo(currentStroke[i].dx, currentStroke[i].dy);
      }
      canvas.drawPath(path, paint);
    } else if (currentStroke.length == 1) {
      canvas.drawCircle(currentStroke.first, 2.5, Paint()..color = Colors.black);
    }
  }

  @override
  bool shouldRepaint(covariant _DrawingPainter oldDelegate) {
    return true;
  }
}