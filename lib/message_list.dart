import 'package:flutter/material.dart';
import 'message.dart';
import 'package:badge/badge.dart';
import 'dart:async';


class MessageList extends StatefulWidget {
  @override
  MessageListState createState() => new MessageListState();

}

class MessageListState extends State<MessageList> {

  Future<Null> _refreshData() async {
    setState(() {
          fetchMessages();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: FutureBuilder<List<Message>>(
                  future: fetchMessages(),
                  builder: (context, snapshot) {
                    return new RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.builder(
                        itemCount:  snapshot.hasData ? snapshot.data.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                            return _listaCell(snapshot.data[index]);
                          },
                        ),
                      );
                    }
                  ),
                ),
            );
  }
}



Widget _listaCell(Message message) {

    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            width: 50.0,
            child: new Center(
                child: Badge.before(
                value: "",
                color: message.status == "Problema" ? Colors.redAccent : Colors.blueAccent,
                child: Text(''),
              ),
            ),
          ),
          Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Expanded(
                      child: Align( 
                      alignment: Alignment.bottomLeft,
                      child: Text(message.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                      ),
                  ),
                  new Expanded(
                    child: Text(message.ticket)
                    ),
                ],
                        ),
          ),
          Container(
              decoration: BoxDecoration(color: Colors.white),
              width: 40.0,
              child: new Center(child: Text('3 mins', style: TextStyle(fontSize: 8.0),)),
            )
        ],
      ),
    );
  
}