import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';

import 'botones.dart';

class Pantallazo extends StatefulWidget {
  Pantallazo({Key key}) : super(key: key);

  @override
  PantallazoState createState() => PantallazoState();
}

var rng = new Random();
var agregar = false;
int numeroActul = rng.nextInt(400);
int dameNumeroRandom() {
  return rng.nextInt(400);
}

String verificarRespuesta="¿?";
Icon iconDeRespuesta = inconoQuestion;
var tipoNumero = true;
double widthBotones;
double eightBotones;

Map<int, int> valordePisos = {
  3: 0,
  2: 0,
  1: 0,
};

class PantallazoState extends State<Pantallazo> {
  // ignore: non_constant_identifier_names
  final controllador_numero = TextEditingController(text: "$numeroActul");
  // ignore: non_constant_identifier_names
  final controllador_escribir = TextEditingController();
  var contador = 0;

  Widget vacio = Row(
    children: [
      Container(
        color: Colors.grey,
      )
    ],
  );
  final Widget punto = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 25,
        width: 25,
        //color: Colors.green,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.all(const Radius.circular(80)),
        ),
      ),
    ],
  );
  Widget rectangulo = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          height: 25,
          width: 100,
          //color: Colors.blue,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(width: 1),
            //borderRadius: const BorderRadius.all(const Radius.elliptical(80,70)),
          )),
    ],
  );
  Widget concha = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: new Image(
          width: 50,
          height: 50,
          image: new AssetImage('/imagenes/numero0.png'),
        ),
        height: 50,
        width: 50,
        //color: Colors.red,
      ),
    ],
  );


  cambiarNumeroRandom() {
    numeroActul = rng.nextInt(400);
    controllador_numero.text = "$numeroActul";
    iconDeRespuesta=inconoQuestion;
    verificarRespuesta="¿?";
  }

  List<Widget> piso1 = List<Widget>();
  List<Widget> piso2 = List<Widget>();
  List<Widget> piso3 = List<Widget>();


  Widget boton(btntxt, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Text(
          btntxt,
          style: TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            controllador_escribir.text = controllador_escribir.text + btntxt;
          });
        },
        color: btnColor,
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnBorrar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey),
        onPressed: () {
          controllador_escribir.text = (controllador_escribir.text.length > 0)
              ? (controllador_escribir.text
                  .substring(0, controllador_escribir.text.length - 1))
              : "";
        },
        color: const Color(0xFFF5F7F9),
        padding: EdgeInsets.all(18.0),
        splashColor: Colors.black,
        shape: CircleBorder(),
      ),
    );
  }

  Widget generarBotones() {
    var contenedor = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    //para que me de un random queTipoSera.nextBool()
    if (tipoNumero) {
      //por si es numerico
      var fila1 = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[]);
      fila1.children.add(boton('7', Colors.white));
      fila1.children.add(boton('8', Colors.white));
      fila1.children.add(boton('9', Colors.white));
      fila1.children.add(btnBorrar());
      //segunda fila
      var fila2 = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[]);
      fila2.children.add(boton('4', Colors.white));
      fila2.children.add(boton('5', Colors.white));
      fila2.children.add(boton('6', Colors.white));
      fila2.children.add(boton('', Colors.white));
      //tercera y ultima
      var fila3 = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[]);
      fila3.children.add(boton('1', Colors.white));
      fila3.children.add(boton('2', Colors.white));
      fila3.children.add(boton('3', Colors.white));
      fila3.children.add(boton('0', Colors.white));
      contenedor.children.add(fila1);
      contenedor.children.add(fila2);
      contenedor.children.add(fila3);
    } else {
      //BOTONES PARA EL MAYA
      var filaMaya = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[]);
      filaMaya.children.add(regresaUnDrag(
        punto,
        Colors.green,
      ));
      filaMaya.children.add(regresaUnDrag(
        rectangulo,
        Colors.blue,
      ));
      filaMaya.children.add(regresaUnDrag(
        concha,
        Colors.red,
      ));
      contenedor.children.add(filaMaya);
    }
    return contenedor;
  }

  Widget generarAreaDeTrabajo() {
    if (tipoNumero) {
      widthBotones=380;
      eightBotones=200;
      return TextField(
        decoration: new InputDecoration.collapsed(
            hintText: "Tu respuesta",
            fillColor: Colors.deepPurpleAccent,
            hintStyle: TextStyle(fontFamily: 'RobotoMono')),
        enabled: false,
        style: TextStyle(
            fontSize: 42, fontFamily: 'RobotoMono', fontWeight: FontWeight.bold
            // color: Colors.deepPurpleAccent
            ),
        textAlign: TextAlign.center,
        controller: controllador_escribir,
      );
    } else {
      widthBotones=300;
      eightBotones=100;
      Widget contenedorDagreable3 = Container(
          width: 150,
          height: 105,
          color: Colors.orange,
          child: agregar == true
              ? new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: piso3,
                )
              : Container());
      Widget contenedorDagreable2 = Container(
          width: 150,
          height: 105,
          color: Colors.orange,
          child: agregar == true
              ? new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: piso2,
                )
              : Container());
      Widget contenedorDagreable = Container(
          width: 150,
          height: 105,
          color: Colors.orange,
          child: agregar == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: piso1,
                )
              : Container());

      Widget dragTarget3 = DragTarget<Widget>(
        builder: (context, incoming, rejected) {
          return contenedorDagreable3;
        },
        //onWillAccept: (data) => data == 'cuadro',
        onWillAccept: (data) =>true,
        onAccept: (data) {
          setState(() {
            agregar = true;
            if (data == concha) {
              if (piso3.length > 0) {
                if (piso3[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                }
              } else {
                piso3 = insertarConchaoApiso(piso3);
              }
            } else if (data == punto) {
              if (piso3.length > 0) {
                print("vino agregar un punto");
                if (piso3[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                } else if (piso3[0] == vacio || piso3[0] != null) {
                  piso3 = insertarPuntoApiso(piso3);
                } else {
                  print("no llama a agregar");
                }
              } else {
                piso3.add(punto);
                piso3.add(vacio);
              }
            } else if (data == rectangulo) {
              if (piso3.length > 0) {
                if (piso3[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                } else if (piso3[1] == vacio || piso3[0] != null) {
                  piso3 = insertarRectanguloApiso(piso3);
                }
              } else {
                piso3.add(vacio);
                piso3.add(rectangulo);
              }
            }
          });
        },
        onLeave: (data) {},
      );

      Widget dragTarget2 = DragTarget<Widget>(
        builder: (context, incoming, rejected) {
          return contenedorDagreable2;
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          setState(() {
            agregar = true;
            if (data == concha) {
              if (piso2.length > 0) {
                if (piso2[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                }
              } else {
                piso2 = insertarConchaoApiso(piso2);
              }
            } else if (data == punto) {
              if (piso2.length > 0) {
                print("vino agregar un punto");
                if (piso2[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                } else if (piso2[0] == vacio || piso2[0] != null) {
                  piso2 = insertarPuntoApiso(piso2);
                } else {
                  print("no llama a agregar");
                }
              } else {
                piso2.add(punto);
                piso2.add(vacio);
              }
            } else if (data == rectangulo) {
              if (piso2.length > 0) {
                if (piso2[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                } else if (piso2[1] == vacio || piso2[0] != null) {
                  //insertarColumna();
                  piso2 = insertarRectanguloApiso(piso2);
                  //columna2 = piso2[1];
                }
              } else {
                piso2.add(vacio);
                piso2.add(rectangulo);
                
              }
            }
          });
        },
        onLeave: (data) {},
      );

      Widget dragTarget1 = DragTarget<Widget>(
        builder: (context, incoming, rejected) {
          return contenedorDagreable;
        },
        onWillAccept: (data) => true,
        onAccept: (data) {
          setState(() {
            agregar = true;
            if (data == concha) {
              if (piso1.length > 0) {
                if (piso1[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                }
              } else {
                piso1 = insertarConchaoApiso(piso1);
              }
            } else if (data == punto) {
              if (piso1.length > 0) {
                print("vino agregar un punto");
                if (piso1[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                } else if (piso1[0] == punto ||
                    piso1[0] == vacio ||
                    piso1[0] != null) {
                  piso1 = insertarPuntoApiso(piso1);
                } else {
                  print("no llama a agregar");
                }
              } else {
                piso1.add(punto);
                piso1.add(vacio);
              }
            } else if (data == rectangulo) {
              if (piso1.length > 0) {
                if (piso1[0] == concha) {
                  print("no puedes agregar otro numero ademas de 0");
                } else if (piso1[1] == vacio || piso1[0] != null) {
                  //insertarColumna();
                  piso1 = insertarRectanguloApiso(piso1);
                }
              } else {
                piso1.add(vacio);
                piso1.add(rectangulo);
              }
            }
          });
        },
        onLeave: (data) {},
      );
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dragTarget3,
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'Borrar',
                onPressed: () {
                  setState(() {
                    piso3.clear();
                  });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dragTarget2,
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'Borrar',
                onPressed: () {
                  setState(() {
                    piso2.clear();
                  });
                },
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dragTarget1,
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'Borrar',
                onPressed: () {
                  setState(() {
                    piso1.clear();
                  });
                },
              ),
            ],
          ),
          //dragTarget1,
        ],
      );
    }
  }

  Widget generarProblema() {
    if (!tipoNumero) {
      return TextField(
        decoration: new InputDecoration.collapsed(
            hintText: "problema",
            fillColor: Colors.deepPurpleAccent,
            hintStyle: TextStyle(fontFamily: 'RobotoMono')),
        //textInputAction: TextInputAction.none,
        //keyboardType: TextInputType.number,
        enabled: false,
        style: TextStyle(
            fontSize: 42, fontFamily: 'RobotoMono', fontWeight: FontWeight.bold
            // color: Colors.deepPurpleAccent
            ),
        textAlign: TextAlign.center,
        controller: controllador_numero,
      );
    } else {
      dameNumeroMaya(numeroActul);
      return Container(
        color: Colors.blueGrey,
        height: 250,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //regresaPisoTerminado(valorPiso3),
            regresaPisoTerminado(3),
            Divider(),
            //regresaPisoTerminado(valorPiso2),
            regresaPisoTerminado(2),
            Divider(),
            //regresaPisoTerminado(valorPiso1),
            regresaPisoTerminado(1),
            //Text("valor $numeroActul"),
            //Text("aqui ira piso 1"),
          ],
        ),
      );
    }
  }

  Widget regresaPisoTerminado(int numeroPiso) {
    if(numeroActul==0){
      if(numeroPiso==1){
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [concha],
        );
      }
      //return
    }
    if (valordePisos[numeroPiso] == 0) {
      if (numeroPiso != 3 && valordePisos[3] > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [concha],
        );
      } else if (numeroPiso == 2 && valordePisos[3] > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [concha],
        );
      } else if (numeroPiso == 1 && valordePisos[2] > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [concha],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [vacio],
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          filaConPuntos(valordePisos[numeroPiso]),
          columnasConRectangulos(valordePisos[numeroPiso]),
        ],
      );
    }
  }

  Widget filaConPuntos(int valorDePiso) {
    regresaCuantoPuntosCaben(valorDePiso);
    Row fila = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    for (var i = 0; i < regresaCuantoPuntosCaben(valorDePiso); i++) {
      fila.children.add(punto);
    }
    return fila;
  }

  Widget columnasConRectangulos(int valorDePiso) {
    //regresaCuantoRectangulosCaben(valorDePiso);
    Column fila = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    for (var i = 0; i < regresaCuantoRectangulosCaben(valorDePiso); i++) {
      fila.children.add(rectangulo);
    }
    return fila;
  }

  Widget cuadroDeComprobacion() {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.brown,
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(const Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconDeRespuesta,
          Text(
            verificarRespuesta,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  //int valorMaya = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('¿Conoces el numero?'),
        backgroundColor: Color(0xFFf01DFD7),
        leading: IconButton(
          icon: Icon(Icons.auto_fix_high),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                generarProblema(),
                cuadroDeComprobacion(),
                Divider(),
                //generarAreaDeTrabajo(),
                Column(children: [
                  generarAreaDeTrabajo(),
                ]),
                Container(
                  width: widthBotones,
                  height: eightBotones,
                  child: generarBotones(),
                ),
                //generarBotones(),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 150.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'random',
              onPressed: () {
                setState(() {
                  dameModoRandom();
                });
              },
              child: Icon(Icons.change_history),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'save',
              onPressed: () {
                setState(() {
                  calcularValorMaya();
                });
              },
              child: Icon(Icons.spellcheck),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'refresh',
              onPressed: () {
                setState(() {
                  cambiarNumeroRandom();
                });
              },
              child: Icon(Icons.refresh),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  calcularValorMaya() {
    if (tipoNumero) {
      calcularSihayArabigo();
    } else {
      cacularSihayMaya();
    }
  }

  cacularSihayMaya(){
    int valorTotal=0;
    bool pisoVacio=false;
    valorTotal += (valorDelPiso(piso3) * (20 * 20));
    valorTotal += (valorDelPiso(piso2) * 20);
    valorTotal += valorDelPiso(piso1);
    if (valorTotal == numeroActul) {
      if(piso3.length>0){
        if(piso3[0] == concha){
          piso3.clear();
        }else if(piso3[0] == punto || piso3[1] == rectangulo){
          if(piso2.length<1 || piso1.length<1){
            pisoVacio=true;
          }
        }
      }
      if(piso2.length>0){
        if(piso2[0]==concha){
          if(piso3.length<1){
            piso2.clear();
          }else if(piso3[0]==concha){
            piso2.clear();
          }
        }
        if(piso1.length<1){
            pisoVacio=true;
        }
      }
      //para el caso de ser 0
      if(numeroActul==0 && valorTotal==0){
        if(piso1.length>0){
          if(piso1[0]==concha){
            print("muy bien es el correcto1");
            mostrarCorrecto();
            //return;
          }else{
            mostrarIncorrecto();
          }
        }else{
          mostrarIncorrecto(); 
        }
      }else if(pisoVacio){
        verificarRespuesta ="Falta algo";
        iconDeRespuesta=inconoInCorrecto;
      }else{
        mostrarCorrecto();
      }
    } else {
      mostrarIncorrecto();
    }
    print("el valor que tiene ahora es: $valorTotal");
  }
  calcularSihayArabigo(){
    int valorTotal = 0;
    if (controllador_escribir.text == "problema"|| controllador_escribir.text =="")
        valorTotal = -1;
    else
    valorTotal = int.parse(controllador_escribir.text);
    if(valorTotal==numeroActul){
      mostrarCorrecto();
    }else mostrarIncorrecto();
    print("el valor que tiene ahora es: $valorTotal");
  }

  mostrarCorrecto(){
    print("muy bien es el correcto");
    verificarRespuesta ="Correcto";
    iconDeRespuesta=inconoCorrecto;
  }
  mostrarIncorrecto(){
    print("Estas mal estas en mostrarIncorrecto()");
    verificarRespuesta ="Incorrecto";
    iconDeRespuesta=inconoInCorrecto;
  }
  void dameModoRandom() {
    tipoNumero = rng.nextBool();
    numeroActul = rng.nextInt(400);
    controllador_numero.text = "$numeroActul";
    iconDeRespuesta=inconoQuestion;
    verificarRespuesta="¿?";
  }

  int valorDelPiso(List<Widget> piso) {
    int valorPorPiso = 0;
    if (piso.length > 0 && piso[0] != null && piso[1] != null) {
      if (piso[0].hashCode != vacio.hashCode) {
        Row dameFila = piso[0];
        if (dameFila == concha) return 0;
        valorPorPiso += dameFila.children.length;
      }
      if (piso[1].hashCode != vacio.hashCode) {
        Column dameColumna = piso[1];
        //print("cuantas columnas tiene: ${dameColumna.children.length}");
        valorPorPiso += (dameColumna.children.length * 5);
      } else {
        print("esta vacio");
      }
      //valorPorPiso++;
    } else print("no tiene punto");
    return valorPorPiso;
  }


  List<Widget> insertarPuntoApiso(List<Widget> piso) {
    Row filas = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    if (piso[0] == vacio) {
      piso[0] = punto;
      return piso;
    }
    Row filaDelpiso = piso[0];
    if (filaDelpiso.children.length == 4) {
      print("no se puede mas de 4 puntos");
    } else {
      for (int x = 0; x <= filaDelpiso.children.length; x++) {
        filas.children.add(punto);
      }
      piso[0] = filas;
    }
    return piso;
  }

  List<Widget> insertarRectanguloApiso(List<Widget> piso) {
    Column filas = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    if (piso[1] == vacio) {
      piso[1] = rectangulo;
      return piso;
    }
    Column columnasRec = piso[1];
    if (columnasRec.children.length == 3) {
      print("maximo de rectangulos");
    } else {
      for (int x = 0; x <= columnasRec.children.length; x++) {
        //print("tiene 1 hijo fila1: $x");
        filas.children.add(rectangulo);
      }
      //columnasRec = filas;
      piso[1] = filas;
    }
    return piso;
  }

  List<Widget> insertarConchaoApiso(List<Widget> piso) {
    piso.insert(0, concha);
    piso.insert(1, vacio);
    return piso;
  }


  void dameNumeroMaya(int numeroActul) {
    if (((numeroActul / 20).truncate() > 20)) {

      int nuevoDividir = (numeroActul / 20).truncate();
      valordePisos[3] = (nuevoDividir / 20).truncate();
      print("valor del piso3: ${(nuevoDividir / 20).truncate()}");
     
      valordePisos[2] = (nuevoDividir % 20).truncate();
      
      valordePisos[1] = (numeroActul % 20).truncate();
      
    } else {
     
      valordePisos[3] = (numeroActul / 400).truncate();
      if (valordePisos[3] > 0) {
        
        numeroActul -= 400;
      }
      valordePisos[2] = (numeroActul / 20).truncate();
      
      valordePisos[1] = (numeroActul % 20).truncate();
      
    }
  }
}

//Crea un drag con la informaicon que le mando
regresaUnDrag(Widget info, MaterialColor colorContainer) {
  return Draggable<Widget>(
    data: info,
    child: info,
    feedback: info,
    childWhenDragging: info,
  );
}

int regresaCuantoRectangulosCaben(int valorDepiso) {
  //int dameunValor=(numeroActul/20).truncate();
  return (valorDepiso / 5).truncate();
}

int regresaCuantoPuntosCaben(int valorDepiso) {
  //int dameunValor=(numeroActul%20).truncate();
  return (valorDepiso % 5).truncate();
}
