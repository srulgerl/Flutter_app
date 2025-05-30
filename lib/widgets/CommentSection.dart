import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final String productId;
  const CommentSection({super.key, required this.productId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> _submitComment() async {
    if (_controller.text.trim().isEmpty || user == null) return;

    await _firestore
        .collection('product_comments')
        .doc(widget.productId)
        .collection('comments')
        .add({
          'userId': user!.uid,
          'userName': user!.displayName ?? 'Anonymous',
          'comment': _controller.text.trim(),
          'timestamp': FieldValue.serverTimestamp(),
        });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Сэтгэгдэл бичих:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Сэтгэгдэл...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _submitComment,
              child: const Text('Илгээх'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          'Сэтгэгдлүүд:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('product_comments')
              .doc(widget.productId)
              .collection('comments')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final docs = snapshot.data!.docs;

            if (docs.isEmpty) {
              return const Text('Одоогоор сэтгэгдэл алга байна.');
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['userName'] ?? 'Хэрэглэгч'),
                  subtitle: Text(data['comment'] ?? ''),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
