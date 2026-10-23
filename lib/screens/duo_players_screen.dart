import 'package:flutter/material.dart';
import 'duo_game_screen.dart';

class DuoPlayersScreen extends StatefulWidget {
  const DuoPlayersScreen({super.key});

  @override
  State<DuoPlayersScreen> createState() => _DuoPlayersScreenState();
}

class _DuoPlayersScreenState extends State<DuoPlayersScreen> {
  int _playerCount = 2;
  final List<TextEditingController> _controllers = List.generate(20, (_) => TextEditingController());
  final List<String> _names = List.generate(20, (_) => '');

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    super.dispose();
  }

  bool get _canStart {
    for (int i = 0; i < _playerCount; i++) {
      if (_names[i].trim().isEmpty) return false;
    }
    return true;
  }

  void _startGame() {
    final players = _names.take(_playerCount).map((e) => e.trim()).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => DuoGameScreen(playerNames: players)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Color(0xFF0A2A4A), Color(0xFF0A1A2A), Color(0xFF050A14)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('التحدي المشترك', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const Text('كم عدد اللاعبين؟', style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 9,
                  itemBuilder: (_, i) {
                    final n = i + 2;
                    final selected = n == _playerCount;
                    return GestureDetector(
                      onTap: () => setState(() => _playerCount = n),
                      child: Container(
                        width: 50, margin: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected ? const Color(0xFF00E5FF) : Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('$n', style: TextStyle(color: selected ? Colors.black : Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _playerCount,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: _controllers[i],
                        onChanged: (v) => setState(() => _names[i] = v),
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'اسم اللاعب ${i + 1}',
                          hintStyle: const TextStyle(color: Colors.white38),
                          filled: true, fillColor: Colors.black45,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white24)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF00E5FF))),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity, height: 60,
                  child: ElevatedButton(
                    onPressed: _canStart ? _startGame : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E5FF),
                      disabledBackgroundColor: Colors.black26,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text('ابدأ اللعبة', style: TextStyle(color: _canStart ? Colors.black : Colors.white38, fontSize: 20, fontWeight: FontWeight.bold)),
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