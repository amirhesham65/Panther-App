import 'package:flutter/material.dart';
import 'package:panther_app/components/SegmentsOfControl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SingleWorkspaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Quak'),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.insert_chart),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: SOC(),
              ),
              SizedBox(
                height: 12.0,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: 300.0,
                      child: Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10.0),
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[300],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Wireframe the app layout',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Start the UX design process by wireframing the whole app layout with flow.',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .caption
                                        .color,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.flag, color: Colors.grey),
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        percent: 0.25,
                                        progressColor:
                                            Theme.of(context).accentColor,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.check_circle_outline),
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
