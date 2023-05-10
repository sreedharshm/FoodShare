import 'package:flutter/material.dart';
import 'package:foodproject/view/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference orgDetails =
      FirebaseFirestore.instance.collection('Organisations');

  bool _isAppBarTransparent = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        setState(() {
          _isAppBarTransparent = false;
        });
      } else {
        setState(() {
          _isAppBarTransparent = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isAppBarTransparent == false) {
          setState(() {
            _isAppBarTransparent = true;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              _isAppBarTransparent ? Colors.transparent : tdBGcolor,
          elevation: 0,
          toolbarHeight: 60,
          centerTitle: true,
          titleTextStyle: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 130, 130, 130),
              fontSize: 20,
              fontWeight: FontWeight.normal),
          title: const Text("Charities near you"),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Kottayam",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color.fromARGB(255, 206, 206, 206),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                  stream: orgDetails.snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot orgDetailsnap =
                                snapshot.data.docs[index];
                            String imageUrl = orgDetailsnap['image'];
                            String orgName = orgDetailsnap['name'];
                            String acc_image = orgDetailsnap["acc_image"];
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tdBGcolor),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                //color: Colors.orange,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          fit: StackFit.expand,
                                          children: [
                                            Image(
                                              image: NetworkImage(imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: const Alignment(0, 0),
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.7),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // CircleAvatar(
                                            //   radius: 20,
                                            //   backgroundColor: tdBGcolor,
                                            //   backgroundImage:
                                            //       NetworkImage(acc_image),
                                            // ),
                                            Container(
                                              alignment:
                                                  const Alignment(-0.7, -0.9),
                                              child: Text(
                                                orgName,
                                                style: GoogleFonts.openSans(
                                                    color: tdWhite,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        child: Container(
                                      color: Colors.white10,
                                      child: ListTile(
                                        leading: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.favorite)),
                                        title: LinearPercentIndicator(
                                          barRadius: const Radius.circular(12),
                                        ),
                                        trailing: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text("Donate")),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              const Text("Ends here")
            ],
          ),
        ),
      ),
    );
  }
}
