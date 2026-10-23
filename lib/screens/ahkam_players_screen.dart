import 'package:flutter/material.dart';

import 'ahkam_game_screen.dart';

class AhkamPlayersScreen extends StatefulWidget {
  const AhkamPlayersScreen({super.key});

  @override
  State<AhkamPlayersScreen> createState() => _AhkamPlayersScreenState();
}

class _AhkamPlayersScreenState extends State<AhkamPlayersScreen> {
  int _playerCount = 3;
  final List<TextEditingController> _controllers = [];
  final List<String> _names = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      _controllers.add(TextEditingController());
      _names.add('');
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _canStart {
    for (int i = 0; i < _playerCount; i++) {
      if (_names[i].trim().isEmpty) return false;
    }
    return true;
  }

  void _startGame() {
    final players = <String>[];
    for (int i = 0; i < _playerCount; i++) {
      players.add(_names[i].trim());
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AhkamGameScreen(playerNames: players),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'اللاعبين',
                      style: TextStyle(
                        color: Color(0xFFFFD54A),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'كم عدد اللاعبين؟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: 19,
                  itemBuilder: (_, i) {
                    final n = i + 2;
                    final selected = n == _playerCount;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => setState(() => _playerCount = n),
                        child: Container(
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFFFF6B6B)
                                : Colors.black.withOpacity(0.4),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFFFFD54A)
                                  : const Color(0x55FFFFFF),
                              width: selected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$n',
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _playerCount,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: _controllers[i],
                        onChanged: (v) => setState(() => _names[i] = v),
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: 'اسم اللاعب ${i + 1}',
                          hintStyle: const TextStyle(color: Colors.white38),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: Color(0xFFFFD54A),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.4),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0x557AD7FF),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFFFD54A),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _canStart ? _startGame : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      disabledBackgroundColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: _canStart
                              ? const Color(0xFFFFD54A)
                              : Colors.white24,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      _canStart ? 'ابدأ اللعبة' : 'اكتب كل الأسماء',
                      style: TextStyle(
                        color: _canStart ? Colors.white : Colors.white38,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}