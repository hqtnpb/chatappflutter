import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  final String image;
  final String name;

  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
    required this.image,
    required this.name,
  });
  // text controller
  final TextEditingController _messageController = TextEditingController();
  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something inside the text field
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(
        receiverID,
        _messageController.text,
      );
      _messageController.clear();
    }
  }
  //pick image function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(width: 10.0),
            Text(name),
          ],
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          //display messages
          Expanded(
            child: _buildMessageList(),
          ),

          //user input
          _buildUserInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        //return list view
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildMessageItem(context, doc))
              .toList(),
        );
      },
    );
  }

//build message item
  Widget _buildMessageItem(BuildContext context, DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //check if the sender is the current user
    //if it is, align the message to the right
    //if not, align the message to the left
    //this is to differentiate between the sender and the receiver
    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    // String currentUserID = _authService.getCurrentUser()!.uid;
    // String receiverID = data['receiverID'];
    String chatRoomID = data['chatRoomID'];
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Row(
                children: <Widget>[
                  Icon(Icons.warning),
                  SizedBox(width: 8.0),
                  Text('Confirm Delete'),
                ],
              ),
              content: const Text(
                  'Are you sure you want to delete this message with ?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  onPressed: () async {
                    await _chatService.deleteMessage(
                      chatRoomID,
                      doc.id,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      onTap: () {
        TextEditingController _updateController =
            TextEditingController(text: doc['message']);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Update Message'),
              content: TextField(
                controller: _updateController,
                decoration: const InputDecoration(
                  labelText: 'New message',
                  // hintText: 'Type your new message here',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  onPressed: () async {
                    // Your update operation
                    await _chatService.updateMessage(
                      chatRoomID,
                      doc.id,
                      _updateController.text,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          // text field should take up most of the space
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
              prefixIcon: const Icon(Icons.email),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.image,
              color: Colors.blue,
              size: 40,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25.0),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
