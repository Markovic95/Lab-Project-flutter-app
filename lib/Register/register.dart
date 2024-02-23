import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../database/db_helpers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(BuildContext context, {super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String dropdownvalue = 'Male';
  var sex = ['Male', 'Female', 'Other', 'Prefer not to say'];
  final _formKey = GlobalKey<FormState>();

  redir(String route) {
    Navigator.of(context).pushNamed(route);
  }

  databaseInsert() {
    DBHelper.insert(
      'users',
      {
        'name': nameController.text,
        'birth': dateInput.text,
        'gender': sexController.text,
        'weight': weightController.text,
        'username': usernameController.text,
        'password': passController.text,
        'email': emailController.text
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController passController = TextEditingController();
  /**
   * this could be also implemented with Cards widget, instead of writting the
   * whole code below but sinces i started that why i will leave it as is!
   */
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 45),
                            child: Column(
                              children: const [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 33,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 4),
                                Text("IT'S FREEEE!")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 500,
                  height: 300,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 257),
                                        child: Text(
                                          "Name",
                                          style: TextStyle(
                                            
                                              color: Colors.blueAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            nameController, //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                                        //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Provide your Name";
                                          } else {
                                            print(nameController.value);
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 1, right: 10),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 239),
                                        child: Text(
                                          "Birthday",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: dateInput,
                                        //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                                        //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                                        // The validator receives the text that the user has entered.
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2100));

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            setState(() {
                                              dateInput.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {}
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Birth date not selected";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 1, right: 10),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 248),
                                        child: Text(
                                          "Gender",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 150),
                                        child: SizedBox(
                                          width: 190,
                                          child: DropdownButton(
                                            isExpanded: true,
                                            value: dropdownvalue,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: sex.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(
                                                () {
                                                  dropdownvalue = newValue!;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 1, right: 10),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 250),
                                        child: Text(
                                          "Weight",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            weightController, //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                                        //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                                        // The validator receives the text that the user has entered.
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "You didn't set your weight";
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
                                        padding: EdgeInsets.only(right: 226),
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
                                            return "Provide your username";
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
                                        padding: EdgeInsets.only(right: 226),
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
                                            passController, //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                                        //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Provide your password";
                                          } else if (value.length < 8) {
                                            return "Password must have at least 8 characters";
                                          } else if (!value.contains('@') ||
                                              !value.contains('!')) {
                                            return "Password must contain at those characters '@' '! ";
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
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 257),
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      TextFormField(
                                        controller:
                                            emailController, //χρησιμοποιουμε τον controller ωστε να μπορουμε να παρουμε την τιμη του καθε πεδιου οταν γινεται submit η φορμα
                                        //initialValue: "Some text", το initial value δεν μπορει να χρησιμοποιηθει μαζι με την επιλογη controller
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Provide an email";
                                          } else if (!value.contains('@') ||
                                              !value.contains('.')) {
                                            return "Email should have '@' -_- ";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 1, right: 0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
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
                                databaseInsert();
                                redir("/secondsplash");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Just a moment! :)')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Opps!! something is wrong, please check your form fields'),
                                  ),
                                );
                              }
                            },
                            child: const Text("Register"),
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
    );
  }
}
