
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mayachange/interfaz/botones.dart';
import 'package:mayachange/interfaz/pantalla.dart';


void main(){
 Pantallazo pantalla = Pantallazo();
 group(
   "Darme Numero", 
   (){
     test("numero random", (){
       StatefulElement prueba = pantalla.createElement();
       //inconoCorrecto
       expect(0, 1);
     });
   },
 );
}