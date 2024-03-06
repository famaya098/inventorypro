import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';



void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(title: '',),
  )
);

class HomePage extends StatelessWidget {
  const HomePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF177272),
              Color(0xFF20aca8),
              Color(0xFF68e0d6)
            ] // #177272, #20aca8, #68e0d6
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(duration: const Duration(milliseconds: 1000), child: const Text("InventoryPro", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  const SizedBox(height: 10,),
                  FadeInUp(duration: const Duration(milliseconds: 1300), child: const Text("Bienvenid@", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 60,),
                        FadeInUp(duration: const Duration(milliseconds: 1400), child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(
                              color: Color.fromRGBO(232, 227, 214, 1), //rgba(232, 227, 214, 1)
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                ),
                                child: const TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 40,),
                        FadeInUp(duration: const Duration(milliseconds: 1500), child: const Text("¿Olvidaste tu contraseña?", style: TextStyle(color: Colors.grey),)),
                        const SizedBox(height: 40,),
                        FadeInUp(duration: const Duration(milliseconds: 1600), child: MaterialButton(
                          onPressed: () {},
                          height: 50,
                          // margin: EdgeInsets.symmetric(horizontal: 50),
                          color: const Color(0xFF073142),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          // decoration: BoxDecoration(
                          // ),
                          child: const Center(
                            child: Text("Ingresar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                        const SizedBox(height: 50,),
                        FadeInUp(duration: const Duration(milliseconds: 1700), child: const Text("Ingresar con huella", style: TextStyle(color: Colors.grey),)),
                        const SizedBox(height: 30,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeInUp(duration: const Duration(milliseconds: 1800), child: MaterialButton(
                                onPressed: (){},
                                height: 50,
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Center(
                                  child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              )),
                            ),
                            const SizedBox(width: 30,),
                            Expanded(
                              child: FadeInUp(duration: const Duration(milliseconds: 1900), child: MaterialButton(
                                onPressed: () {},
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),

                                ),
                                color: Colors.black,
                                child: const Center(
                                  child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


//#177272
//#e8e3d6
//#073142
//#fba436