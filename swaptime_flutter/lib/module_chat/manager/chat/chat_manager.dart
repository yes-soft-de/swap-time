import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/module_chat/model/chat/chat_model.dart';
import 'package:swaptime_flutter/module_chat/repository/chat/chat_repository.dart';

@provide
class ChatManager {
  ChatRepository _chatRepository;

  ChatManager(this._chatRepository);

  Stream<QuerySnapshot> getMessages(String chatRoomID) {
    return _chatRepository.requestMessages(chatRoomID);
  }

  sendMessage(String chatRoomID, ChatModel chatMessage) {
    _chatRepository.sendMessage(chatRoomID, chatMessage);
  }
}
