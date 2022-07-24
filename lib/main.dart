import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Message> messages = [
    Message(
        text: 'Yes sure',
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false)
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var DateFormat;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: GroupedListView<Message, DateTime>(
                  padding: const EdgeInsets.all(8),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  floatingHeader: true,
                  elements: messages,
                  groupBy: (message) => DateTime(
                      message.date.year, message.date.month, message.date.day),
                  groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )),
                  itemBuilder: (context, Message message) => Align(
                        alignment: message.isSentByMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(message.text),
                          ),
                        ),
                      ))),
          Container(
            color: Colors.grey.shade300,
            child: TextField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Type your message here....'),
              onSubmitted: (text) {
                final message =
                    Message(text: text, date: DateTime.now(), isSentByMe: true);
                setState(() {
                  message.add(message);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;
  const Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });

  void add(Message message) {}
}
