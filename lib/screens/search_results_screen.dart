import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf/models/ride_model.dart';
import 'package:leaf/models/user_model.dart';
import 'package:leaf/screens/search_card_info.dart';
import 'package:leaf/screens/seat_selection_screen.dart';
import 'package:leaf/services/database_service.dart';
import 'package:leaf/services/demo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

String name = "test";
String url = 'https://jsonplaceholder.typicode.com/posts';

///Method for GET Request
Future<Demo> getDemoResponse() async{
  final response = await http.get('$url/1');
  return responseFromJson(response.body);
}

class SearchResultsScreen extends StatefulWidget {
  final String origin, destination, time, date;
  SearchResultsScreen(this.origin, this.destination, this.time, this.date);

  static final String id = 'search_results_screen';

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  // Variables
  //TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final String origin = ModalRoute.of(context).settings.arguments.toString();
    final String origin = widget.origin;
    final String destination = widget.destination;
    return Scaffold(
      backgroundColor: Color(0xff111e2e),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff111e2e),
        automaticallyImplyLeading: true,
        title: Hero(
          tag: 'animateText',
          child: Material(
            color: Color(0xff111e2e),
            child: Text(
              'Fahrten am 18.01.2020',
              style: TextStyle(
                fontFamily: 'UbuntuRegular',
                fontSize: 22,
                color: Color(0xffE6EFE9),
              ),
            ),
          ),
        ),
        leading: Hero(
          tag: 'animateIcon',
          child: Material(
            color: Color(0xff111e2e),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffe8b641),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: DatabaseService.searchRides('München', 'Tuttlingen'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text(
                'Uppss..\n'
                'Leider wurden keine passenden Fahrten gefunden.\n'
                'Schau doch später noch mal vorbei.',
                style: TextStyle(
                  fontFamily: 'UbuntuLight',
                  fontSize: 14,
                  color: Color(0xffE6EFE9),
                ),
              ),
            );
          }
          return ListView.builder(
            physics: new BouncingScrollPhysics(),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              Ride ride = Ride.fromDoc(snapshot.data.documents[index]);
              return SearchCardItem(num: index);
            },
          );
        },
      ),
    );
  }
}



class SearchCardItem extends StatelessWidget {
  final int num;

  const SearchCardItem({Key key, this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Hero(
          tag: 'card$num',
          flightShuttleBuilder: (
            BuildContext flightContext,
            Animation<double> animation,
            HeroFlightDirection flightDirection,
            BuildContext fromHeroContext,
            BuildContext toHeroContext,
          ) {
            return SingleChildScrollView(
              child: fromHeroContext.widget,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0, // soften the shadow
                    spreadRadius: 2.0, //extend the shadow
                    offset: Offset(
                      0, // Move to right 10  horizontally
                      2.5, // Move to bottom 5 Vertically
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xff192C43),
              ),
              child: SizedBox(
                height: 168,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// Start Ziel -----------------------------------------
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Material(
                                    color: Color(0xff192C43),
                                    child: Text(
                                      'Von ' + 'München',
                                      style: TextStyle(
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 20,
                                        color: Color(0xffE6EFE9),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    color: Color(0xff192C43),
                                    child: Text(
                                      'nach ' + 'Tuttlingen',
                                      style: TextStyle(
                                        fontFamily: 'UbuntuLight',
                                        fontSize: 20,
                                        color: Color(0xffE6EFE9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// Drei Icons -----------------------------------------
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 22,
                                              child: Image.asset(
                                                  'assets/images/thin_clock.png'),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                'Abfahrt',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 12,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                '13:30',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 16,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 22,
                                              child: Image.asset(
                                                  'assets/images/thin_hourglass.png'),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                'Fahrtdauer',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 12,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                            Material(
                                              color: Color(0xff192C43),
                                              child: Text(
                                                '1,5',
                                                style: TextStyle(
                                                  fontFamily: 'UbuntuLight',
                                                  fontSize: 16,
                                                  color: Color(0xffE6EFE9),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 22,
                                            child: Image.asset(
                                                'assets/images/thin_euro.png'),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Material(
                                            color: Color(0xff192C43),
                                            child: Text(
                                              'Preis',
                                              style: TextStyle(
                                                fontFamily: 'UbuntuLight',
                                                fontSize: 12,
                                                color: Color(0xffE6EFE9),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Color(0xff192C43),
                                            child: Text(
                                              '7',
                                              style: TextStyle(
                                                fontFamily: 'UbuntuLight',
                                                fontSize: 16,
                                                color: Color(0xffE6EFE9),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Flaggen ------------------------------------------------------
                    Padding(
                      padding: EdgeInsets.only(right: 16, left: 32),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            /// Flagge oben ------------------------------------------
                            GestureDetector(
                              onTap: () async {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(3.0),
                                      bottomLeft: Radius.circular(3.0)),
                                  color: Color(0xff294970),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 2.0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        2.5, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                height: 76,
                                width: 57,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Material(
                                          color: Color(0xff294970),
                                          child: Text(
                                            'Paul',
                                            style: TextStyle(
                                              fontFamily: 'UbuntuLight',
                                              fontSize: 12,
                                              color: Color(0xff0cce6b),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: CircleAvatar(
                                            radius: 21.0,
                                            backgroundImage: AssetImage(
                                                'assets/images/Profilbild_Paul.png'),
                                            backgroundColor: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                              width: 57,
                            ),

                            /// Flagge unten -----------------------------------------
                            GestureDetector(
                              onTap: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return new SearchCardInfo(num: num);
                                    },
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3.0),
                                      topLeft: Radius.circular(3.0)),
                                  color: Color(0xff294970),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4.0, // soften the shadow
                                      spreadRadius: 2.0, //extend the shadow
                                      offset: Offset(
                                        0, // Move to right 10  horizontally
                                        0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                height: 76,
                                width: 57,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, left: 5, bottom: 18),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: ButtonTheme(
                                      child: Image.asset(
                                        'assets/images/Fahrtinfo_Leaf.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
