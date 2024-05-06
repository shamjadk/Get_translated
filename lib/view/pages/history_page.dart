import 'package:flutter/material.dart';
import 'package:translate_it/view/widgets/bottom_elevated_button_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('source text '), Text('result text')],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
            itemCount: 10),
      ),
      bottomNavigationBar: BottomElevatedButtonWidget(
        btnName: 'Clear',
        onPressed: () {},
      ),
    );
  }
}
