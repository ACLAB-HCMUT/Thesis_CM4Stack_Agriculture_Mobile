import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/constants/api_constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final GenerativeModel _model;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: geminiAPIKEy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farming Advisory Chat'),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(onPressed: _sendMediaMessage, icon: const Icon(Icons.image)),
        ],
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      final content = <Content>[];
      if (chatMessage.medias?.isNotEmpty ?? false) {
        File imageFile = File(chatMessage.medias!.first.url);
        if (imageFile.existsSync()) {
          final imageBytes = await imageFile.readAsBytes();
          content.add(Content.multi([
            TextPart(chatMessage.text),
            DataPart('image/jpeg', imageBytes),
          ]));
        } else {
          print('Image file does not exist: ${imageFile.path}');
          return;
        }
      } else {
        content.add(Content.text(chatMessage.text));
      }

      final response = _model.generateContent(content);
      final text = (await response).text ?? '';
      final message = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: text,
      );
      setState(() {
        messages = [message, ...messages];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture for me",
        medias: [
          ChatMedia(url: file.path, fileName: "", type: MediaType.image),
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}