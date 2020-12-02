import 'package:flutter/material.dart';
import 'package:flutter_carwashing/telas/agenda/agendaListTela.dart';
import 'package:flutter_carwashing/telas/cliente/clienteListTela.dart';
import 'package:flutter_carwashing/telas/horario/horarioListTela.dart';
import 'package:flutter_carwashing/telas/servico/servicoListTela.dart';
import 'package:flutter_carwashing/widgets/network_sensitivity.dart';

class homeTela extends StatelessWidget {

    final List<Map<String,dynamic>> _listagem = [
        {'label':'Agenda','tela':agendaListTela(),'imagem':'images/agenda.jpg'},
        {'label':'Lista de Clientes','tela':clienteListTela(),'imagem':'images/clientes.jpg'},
        {'label':'Lista de Serviços','tela':servicoListTela(),'imagem':'images/servicos.jpg'},
        {'label':'Lista de Horarios','tela':horarioListTela(),'imagem':'images/horarios.jpg'},
        {'label':'Lista de Promoções','tela':horarioListTela(),'imagem':'images/promocao.jpg'},
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: NetworkSensitive(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: _listagem.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => { _navegarTela(context , _listagem[index]['tela']), },
                child:
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      children: [
                        Image.asset( _listagem[index]['imagem']  ),
                        Center(
                          child: Text(
                            _listagem[index]['label'] ,
                            style: TextStyle(
                              fontWeight: FontWeight.bold ,
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                Shadow(
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 8.0,
                                  color: Color.fromARGB(125, 0, 0, 255),
                                ),
                              ],
                              fontSize: 20 ,
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _navegarTela(BuildContext context, tela) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => tela));
  }
}
