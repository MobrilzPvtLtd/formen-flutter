import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase/chatting_provider.dart';

class MessagesTab extends StatefulWidget {
  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {

  late ChattingProvider chattingProvider;

  @override
  void initState() {
    super.initState();
    chattingProvider = Provider.of<ChattingProvider>(context,listen: false);
    chattingProvider.demo1(context).then((value) {
      chattingProvider.isLoadingchat = false;
    });
    chattingProvider.getblockklisttApi(context);
    chattingProvider.searchController.clear();
    chattingProvider.isSearch = false;
    // chattingProvider.isLoadingchat = true;
  }
  final List<Map<String, dynamic>> messages = [
    {'icon': Icons.person, 'title': 'Turista psvo', 'subtitle': 'Oi'},
    {'icon': Icons.photo, 'title': '.', 'subtitle': 'Foto recebida'},
    {'icon': Icons.person, 'title': 'Leon', 'subtitle': 'Salvador'},
    {'icon': Icons.person, 'title': 'Paulistano', 'subtitle': 'Oi'},
    {'icon': Icons.album, 'title': 'De fora 😈', 'subtitle': 'Álbum recebido'},
    {'icon': Icons.person, 'title': 'LG', 'subtitle': '😏'},
    {'icon': Icons.person, 'title': 'User', 'subtitle': 'E vc na foto do perfil?'},
  ];

  @override
  Widget build(BuildContext context) {
    chattingProvider = Provider.of<ChattingProvider>(context);
    return ListView.separated(
      itemCount: chattingProvider.searchIndexList.length,
      itemBuilder: (BuildContext context, int index) {
        var result = chattingProvider.searchIndexList[index];
        final message = messages[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4.0), // Adjust border radius for square corners
            child: Container(
              color: Colors.grey.shade300, // Background color if there's no image
              width: 50.0,
              height: 50.0,
              child:chattingProvider.searchiteams[result]["image"],
            ),
          ),
          title: chattingProvider.searchiteams[result]["name"],
          subtitle: chattingProvider.searchiteams[result]["message"],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
