
import 'package:flutter/material.dart';
import 'user.dart';
import 'message.dart';
import 'message_list.dart';

class BoardMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _boardNavigationBar(),
      body: _boardBody()
    );
  }
}

Widget _boardNavigationBar() {
    return AppBar(
      title: Text('Quadro de Mensagens'), 
      backgroundColor: Colors.pink, 
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            print("refresh");
          },
        )
      ],
      );
}

Widget _boardBody() {
  return Stack(
        children: <Widget>[ 
          new GradientBackground(),
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageBoardTopContainerDetails(),
            ListTopDiagonalDesign(),
            ListHeader(),
            MessageList(),
          ],
          )
        ]
      );
}


class ListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: new Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Mensagens', style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold)),
            Text(DateTime.now().toString(), style: TextStyle(fontSize: 10.0, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}


class ListTopDiagonalDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
        child: CustomPaint(
          painter: ListTopPainter(),
        ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink, Colors.orange],
        )
      ),
    );
  }
}

class ListTopPainter extends CustomPainter {

  final Paint topListPaint;

  ListTopPainter() : topListPaint = Paint() {
    topListPaint.color = Colors.white;
    topListPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    canvas.translate(0.0, 0.0);

    Path path = Path();
    path.lineTo(size.width, 50.0);
    path.lineTo(0.0, 50.0);
    path.close();

    canvas.drawPath(path, topListPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class MessageBoardTopContainerDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new FutureBuilder<User>(
        future: fetchUser(),
        builder: (context, snapshot) {
              return Row(
                verticalDirection: VerticalDirection.down,
                children: [
                  new Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      child: _buildCircleAvatar(snapshot)
                    ),
                  ),
                  Flexible(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: snapshot.hasData ? [ 
                        Text(snapshot.data.name, textAlign: TextAlign.left, style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Manager on Duty', textAlign: TextAlign.left, style: TextStyle(fontSize: 10.0, color: Colors.white)),
                      ] : [
                        new Center(child: CircularProgressIndicator())
                      ],
                    ),
                  ),
                ],
              );
            
        },)
    );
  }

  Widget _buildCircleAvatar(AsyncSnapshot<User> snapshot) {
    
    if (snapshot.hasData) {
      return CircleAvatar(
        backgroundColor: Colors.white,
        radius: 60.0,
        backgroundImage: NetworkImage(snapshot.data.img)
      );
    }

    
    return Center(
            child: FutureBuilder<List<Message>>(
              future: fetchMessages(),
              builder: (context, snapshot) {
                return Center(child: new CircularProgressIndicator());
                }
              )
          );
    
  }

}
