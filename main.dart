import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcards Mini App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const FlashcardsHome(),
    );
  }
}

class Flashcard {
  Flashcard({
    required this.question,
    required this.answer,
    this.learned = false,
  });

  final String question;
  final String answer;
  bool learned;
}

class FlashcardsHome extends StatefulWidget {
  const FlashcardsHome({super.key});

  @override
  State<FlashcardsHome> createState() => _FlashcardsHomeState();
}

class _FlashcardsHomeState extends State<FlashcardsHome> {
  final Random _rand = Random();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Flashcard> _cards;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _cards = _sampleSet();
  }

  List<Flashcard> _sampleSet() {
    return [
      Flashcard(question: 'What is Flutter?', answer: 'An open-source UI toolkit by Google for building natively compiled apps.'),
      Flashcard(question: 'Stateful vs Stateless?', answer: 'Stateful widgets have mutable state, stateless don\'t.'),
      Flashcard(question: 'What language does Flutter use?', answer: 'Dart.'),
      Flashcard(question: 'What is a Widget?', answer: 'A description of part of a UI — composable and immutable.'),
      Flashcard(question: 'What is build()?', answer: 'A method that describes the widget tree for this widget.'),
      Flashcard(question: 'What is hot reload?', answer: 'A developer tool to inject updated source code into a running app.'),
      Flashcard(question: 'What is an Isolate?', answer: 'A Dart execution thread with its own memory.'),
      Flashcard(question: 'How to style text?', answer: 'Using TextStyle on a Text widget.'),
      Flashcard(question: 'What are keys used for?', answer: 'To preserve widget state across rebuilds and identify widgets.'),
      Flashcard(question: 'How to listen to taps?', answer: 'Use GestureDetector or InkWell.'),
    ];
  }

  int get _learnedCount => _cards.where((c) => c.learned).length;

  Future<void> _pullToRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _expandedIndex = null;
      _cards = _sampleSet()..shuffle(_rand);
    });
  }

  void _insertNewCard(Flashcard card) {
    const insertIndex = 0;
    _cards.insert(insertIndex, card);
    _listKey.currentState?.insertItem(insertIndex, duration: const Duration(milliseconds: 450));
  }

  void _removeCardAt(int index) {
    if (index < 0 || index >= _cards.length) return;
    final removed = _cards.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => _buildRemovedCard(removed, animation),
      duration: const Duration(milliseconds: 400),
    );
  }

  Widget _buildRemovedCard(Flashcard card, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.green.shade200),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.check, color: Colors.green),
            const SizedBox(width: 10),
            Expanded(
              child: Text(card.question, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Flashcard card, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: Dismissible(
        key: ValueKey(card.question + card.answer),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          setState(() => card.learned = true);
          final currentIndex = _cards.indexWhere((c) => c == card);
          if (currentIndex != -1) _removeCardAt(currentIndex);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Marked "${card.question}" as learned')));
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 28),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              setState(() => _expandedIndex = _expandedIndex == index ? null : index);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          card.question,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (card.learned)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Learned', style: TextStyle(color: Colors.green)),
                        )
                      else
                        const Icon(Icons.touch_app_outlined, size: 20, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(card.answer, style: const TextStyle(fontSize: 16)),
                    ),
                    crossFadeState: _expandedIndex == index ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddDialog() async {
    final qController = TextEditingController();
    final aController = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a new flashcard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: qController, decoration: const InputDecoration(labelText: 'Question')),
            const SizedBox(height: 8),
            TextField(controller: aController, decoration: const InputDecoration(labelText: 'Answer')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (qController.text.trim().isNotEmpty && aController.text.trim().isNotEmpty) {
                final card = Flashcard(question: qController.text.trim(), answer: aController.text.trim());
                _insertNewCard(card);
                Navigator.pop(context, true);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added new flashcard')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _cards.length;
    final learned = _learnedCount;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        edgeOffset: 80,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 160,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 12),
                title: Text('$learned of $total learned'),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text('Flashcards', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Practice quick facts — swipe to mark learned', style: TextStyle(color: Colors.white.withOpacity(0.9))),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: total == 0 ? 0 : learned / total,
                          backgroundColor: Colors.white24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tap a card to reveal the answer', style: Theme.of(context).textTheme.bodyMedium),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _cards.shuffle(_rand);
                          _expandedIndex = null;
                        });
                      },
                      icon: const Icon(Icons.shuffle),
                      label: const Text('Shuffle'),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _cards.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  final card = _cards[index];
                  return _buildCard(card, index, animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
