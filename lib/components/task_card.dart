import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text('Rubium Studio', style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color)),
              SizedBox(height: 10.0),
              Text('Build the landing page', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), ),
              SizedBox(height: 10.0),
              Text('I was trying to achieve an effect of allowing a widget to overflow to another widget', style: TextStyle(fontSize: 12.0, color: Theme.of(context).primaryTextTheme.caption.color)),
              // Text('A card is a sheet of Material used to represent some related information, for example an album.', style: TextStyle(fontSize: 12.0, height: 1.5, color: Theme.of(context).primaryTextTheme.caption.color)),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                child: Transform.scale(
                  scale: 1,
                  child: Container(
                    
                    width: 350.0,
                    height: 40.0,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                          child: CircleAvatar(child: Text('A')),
                          left: 0.0,
                        ),
                        Positioned(
                          child: CircleAvatar(
                              child: Text('K'),
                              backgroundColor: Colors.blueAccent[200]),
                          left: 30.0,
                        ),
                        Positioned(
                          child: CircleAvatar(
                            child: Text('H'),
                            backgroundColor: Colors.redAccent[200],
                          ),
                          left: 60.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
