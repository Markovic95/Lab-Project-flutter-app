import 'package:labproject/Register/register.dart';
import 'package:labproject/session/Manager.dart';
import 'package:labproject/testpath.dart';
import 'package:flutter/material.dart';
import 'Drawer&Demographics/demographics.dart';
import 'Drawer&Demographics/drawer.dart';
import 'SplashScreens/secondsplash.dart';
import 'SplashScreens/splashscreen.dart';
import 'database/db_helpers.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/splashscreen',
      debugShowCheckedModeBanner: false,
      routes: {
        '/secondsplash': (context) => secondSplash(context),
        '/splashscreen': (context) => const Splash(),
        '/home': (context) => const MySQLApp(),
        '/testpath': (context) => Testpath(context),
        '/registerpath': (context) => RegisterPage(context),
        '/mydrawerpath': (context) => MyDrawer(),
        '/demogra': (context) => mydemographics(context)
      },
    ),
  );
}

class MySQLApp extends StatefulWidget {
  const MySQLApp({super.key});

  @override
  State<MySQLApp> createState() => _MySQLAppState();
}

class _MySQLAppState extends State<MySQLApp> {
  SessionManager prefs = SessionManager();

  final datalist = [];

  Future<bool> _onWillPop() async {
    // εδω καθε φορα που ο user κανει swipe για να παει πισω! δλδ στο splashscreen
    // θα επιστρεφει false δηλαδη "ακυρωνει" to action του user!!
    return false;
  }

  Future<void> fetchAndSetData(String u, String p) async {
    final datalist = await DBHelper.getlog('users');
/**
 * Υπο κανονικες συνθηκες το ετοιμα θα το εστελνα στον server για validation απλα εδω τραβαω
 * απο την βαση μεσω τησ getlog ολους τους χρηστες και τα password τους 
 */
    /**Η βαση μας επιστρεφει μια μιστα απο maps με τα κλειδια να ειναι το
     * username & password και οι τιμες να ειναι το username & το password  
     * στην απο κατω if απλα ελεγχο εαν στο εκαστο ζευγαρι (οπου ζευγαρι ειναι 
     * username & password μαζι!!!) εαν βρισκονται στο ιδιο σημειο, 
     */
    datalist.forEach(
      (element) {
        print(element.keys);
        print(element.values);
        if (element.values.contains(u) && element.values.contains(p)) {
          prefs.setAuthToken(u);
          print("USERNAME AND PASSWORD IS HERE!!!");
          redir('/mydrawerpath');
        }
      },
    );
  }

  redir(String route) {
    Navigator.of(context).pushNamed(route);
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      onWillPop: _onWillPop,
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      children: const [
                        Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, right: 10),
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 225),
                            child: Text(
                              "Username",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller:
                                usernameController, //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                            //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username provided is incorrect";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 229),
                            child: Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextFormField(
                            controller:
                                passwordController, //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                            //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Provide your password";
                              } else if (value.length < 8) {
                                return "Password must have at least 8 characters";
                              } else if (!value.contains('@') ||
                                  !value.contains('!')) {
                                return "Password must contain '@' and '!' ";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 0),
                    child: SizedBox(
                      width: 200,
                      height: 70,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  //print(emailController
                                  //  .text); //απλα τυπωνουμε τις τιμες που εγραψε ο χρηστης στα πεδια
                                  //print(textController.text);
                                  // Αν η φορμα ειναι valid τυπωσε ενα snackbar (στο κατω μερος της εφαρμογης εμφανιζεται μια μαυρη μπαρα με το κειμενο)
                                  // συνηθως εδω σε πραγματικες εφαρμογες σωνονται οι πληροφοριες στην βαση
                                  fetchAndSetData(usernameController.text,
                                      passwordController.text);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                              child: const Text("Sing in"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, left: 80),
                      child: Row(
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                redir("/registerpath");
                              },
                              child: const Text("Sign up"))
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
    );
  }
}
