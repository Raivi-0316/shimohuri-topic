import 'package:flutter/material.dart';


class AccountPage extends StatefulWidget {
  static const roteName = '/myRoute';
  const AccountPage({super.key, required this.name,required this.passward,});


  final String name;
  final String passward;



  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage>{

  bool _isObscure = true;
  String name ="";
  String passward ="";
  String inputText1 = "";
  String inputText2 = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyAccount'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  onChanged:(value1){
                    setState(() {
                      inputText1 = value1;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'ユーザー名を入力してください',

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  onChanged: (value2){
                    setState(() {
                      inputText2 = value2;
                    });
                  },
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      labelText: 'パスワードを入力してください',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                ),
              ),
              Center(
                child:ElevatedButton(
                  onPressed: () {
                    setState(() {
                      const Text('ログインしました！');
                      name = inputText1;
                      passward = inputText2;
                    }
                    );
                  },
                  child: const Text('ログイン'),
                ),
              ),
              const SizedBox(
                width: 50,
                height: 50,
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    const Text('ユーザー名'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child:
                      Text(name,
                          style: const TextStyle(fontSize: 25)),
                    ),
                    const SizedBox(
                      width: 50,
                      height: 50,
                    ),
                    const Text('パスワード'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child:
                      Text(passward,
                        style: const TextStyle(fontSize: 25),),
                    ),
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