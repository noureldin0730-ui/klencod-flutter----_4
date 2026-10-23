import 'package:flutter/material.dart';
import '../data/murders_data.dart';

class MurdersGameScreen extends StatefulWidget {
  final int caseIndex;
  final int levelNumber;

  const MurdersGameScreen({super.key, required this.caseIndex, required this.levelNumber});

  @override
  State<MurdersGameScreen> createState() => _MurdersGameScreenState();
}

class _MurdersGameScreenState extends State<MurdersGameScreen> {
  String? _selectedSuspect;
  bool _isWrong = false;
  bool _isSolved = false;

  @override
  Widget build(BuildContext context) {
    final murderCase = MurdersData.all[widget.caseIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('جريمة رقم ${widget.levelNumber}', style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(murderCase.title, style: const TextStyle(color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 20),
            Text(murderCase.story, style: const TextStyle(color: Colors.white70, fontSize: 18, height: 1.5)),
            const SizedBox(height: 30),
            
            const Text('الأدلة:', style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...murderCase.clues.map((clue) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.search, color: Colors.white54, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(clue, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5))),
                ],
              ),
            )),
            const SizedBox(height: 30),

            const Text('المشتبه بهم:', style: TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...murderCase.suspects.map((suspect) {
              final isSelected = _selectedSuspect == suspect;
              final isThisTheKiller = suspect == murderCase.killer;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    if (_isSolved) return;
                    setState(() {
                      _selectedSuspect = suspect;
                      if (isThisTheKiller) {
                        _isSolved = true;
                        _isWrong = false;
                      } else {
                        _isWrong = true;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isSolved && isThisTheKiller 
                        ? Colors.green.withOpacity(0.2) 
                        : (isSelected && _isWrong && !isThisTheKiller ? Colors.red.withOpacity(0.2) : Colors.white.withOpacity(0.05)),
                      border: Border.all(
                        color: _isSolved && isThisTheKiller 
                          ? Colors.green 
                          : (isSelected && _isWrong && !isThisTheKiller ? Colors.red : Colors.white24),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isSolved && isThisTheKiller ? Icons.check_circle : Icons.person,
                          color: _isSolved && isThisTheKiller ? Colors.green : Colors.white54,
                        ),
                        const SizedBox(width: 10),
                        Text(suspect, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              );
            }),

            if (_isSolved)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('عاش يا محقق! (المرحلة التالية)', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),

            if (_isWrong && !_isSolved)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('إجابة خاطئة! فكر تاني في الأدلة..', style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}