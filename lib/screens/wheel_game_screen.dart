import 'dart:math' as math;

import 'package:flutter/material.dart';

class WheelGameScreen extends StatefulWidget {
  final List<String> playerNames;

  const WheelGameScreen({super.key, required this.playerNames});

  @override
  State<WheelGameScreen> createState() => _WheelGameScreenState();
}

class _WheelGameScreenState extends State<WheelGameScreen> {
  int _currentTurn = 0;
  bool _gameOver = false;
  bool _isSpinning = false;
  String _resultText = '';
  bool _isReward = true;

  final List<Map<String, dynamic>> _rewards = [
    {'text': 'خد 200 نقطة!', 'type': 'reward'},
    {'text': 'خد 100 نقطة!', 'type': 'reward'},
    {'text': 'اخسر 100 نقطة!', 'type': 'punish'},
    {'text': 'اعمل 10 ضغط دلوقتي!', 'type': 'punish'},
    {'text': 'قول نكتة تضحك الكل!', 'type': 'punish'},
    {'text': 'خد 50 نقطة!', 'type': 'reward'},
    {'text': 'اشرب كوباية مية!', 'type': 'reward'},
    {'text': 'قوم اتمشى في الأوضة!', 'type': 'punish'},
  ];

  void _spinWheel() {
    if (_isSpinning) return;
    setState(() {
      _isSpinning = true;
      _resultText = 'العجلة بتلف...';
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      final rng = math.Random();
      final result = _rewards[rng.nextInt(_rewards.length)];
      setState(() {
        _isSpinning = false;
        _resultText = result['text'];
        _isReward = result['type'] == 'reward';
      });
    });
  }

  void _nextPlayer() {
    setState(() {
      _currentTurn++;
      if (_currentTurn >= widget.playerNames.length) {
        _currentTurn = 0;
      }
      _resultText = '';
    });
  }

  void _endGame() {
    setState(() {
      _gameOver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();

    final playerName = widget.playerNames[_currentTurn];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A0A2A),
              Color(0xFF2A0A1A),
              Color(0xFF0A0514),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _endGame,
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        border: Border.all(color: const Color(0xFFFF3366), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        playerName,
                        style: const TextStyle(
                          color: Color(0xFFFF3366),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48), // للتوازن
                  ],
                ),
              ),
              const Spacer(),
              Text(
                _resultText.isEmpty ? 'دوس على العجلة عشان تلف' : _resultText,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: _resultText.isEmpty 
                      ? Colors.white70 
                      : (_isReward ? const Color(0xFF4ADE80) : const Color(0xFFE24A4A)),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              
              // العجلة
              GestureDetector(
                onTap: _spinWheel,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFFD54A), width: 5),
                    gradient: SweepGradient(
                      colors: [
                        const Color(0xFFFF3366),
                        const Color(0xFFFF9B4A),
                        const Color(0xFF7AD7FF),
                        const Color(0xFF4ADE80),
                        const Color(0xFFC77AFF),
                        const Color(0xFFFF3366),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF3366).withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isSpinning
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 4)
                        : const Text(
                            'لف!',
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                            ),
                          ),
                  ),
                ),
              ),
              
              const SizedBox(height: 50),
              
              // زرار التالي
              if (_resultText.isNotEmpty && !_isSpinning)
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _nextPlayer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD54A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'اللاعب اللي بعده',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOver() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A0A2A),
              Color(0xFF2A0A1A),
              Color(0xFF0A0514),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                const Text(
                  'خلصت اللعبة!',
                  style: TextStyle(
                    color: Color(0xFFFF3366),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3366),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'القائمة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}