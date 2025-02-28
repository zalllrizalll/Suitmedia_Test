import 'package:flutter/material.dart';
import 'package:suitmedia_test/components/custom_button.dart';
import 'package:suitmedia_test/components/text_input.dart';
import 'package:suitmedia_test/routes/navigation.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final sentenceController = TextEditingController();

    bool isPalindrome(String text) {
      String cleanedText =
          text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
      return cleanedText == cleanedText.split('').reversed.join('');
    }

    void checkPalindrome(BuildContext context) {
      final text = sentenceController.text;
      final message = isPalindrome(text) ? 'isPalindrome' : 'not palindrome';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/ic_photo.png'),
              const SizedBox(height: 32),
              TextInput(controller: nameController, hint: 'Name'),
              TextInput(controller: sentenceController, hint: 'Palindrome'),
              const SizedBox.square(dimension: 16),
              CustomButton(
                onTap: () => checkPalindrome(context),
                text: 'CHECK',
              ),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Navigation.secondScreen.name,
                    arguments: nameController.text,
                  );
                },
                text: 'NEXT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
