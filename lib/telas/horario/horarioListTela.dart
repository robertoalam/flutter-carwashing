import 'package:flutter/material.dart';
import 'package:flutter_carwashing/model/horarioModel.dart';
import 'package:flutter_carwashing/telas/horario/horarioEditTela.dart';

class horarioListTela extends StatefulWidget {
  @override
  _horarioListTelaState createState() => _horarioListTelaState();
}

class _horarioListTelaState extends State<horarioListTela> {

    List<HorarioModel> _listagem = new List<HorarioModel>();
    HorarioModel _horario = new HorarioModel();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        _getBuscarLista();
    }
    void _getBuscarLista() async {
        _listagem = await _horario.buscar() ;
        setState(() {
            _listagem;
        });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Lista de Horários"),
        ),
        body: ListView.builder(
            itemCount: _listagem.length,
            itemBuilder: (BuildContext context, int index) {
                return _cardObjeto(context, index);
            },
        )
    );
  }

    _cardObjeto(BuildContext context , int index){
        return Card(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    children: [
                        Column(
                            children: [
                                Container(
                                    child: GestureDetector(
                                        onTap: () => { _deletar( index ), },
                                        child: Icon(Icons.delete,size: 36,),
                                    ),
                                ),
                            ],
                        ),
                        Column(
                            children: [
                                Container(
                                    child: GestureDetector(
                                        onTap: () => _editarObjeto(horario:  _listagem[index]),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                                children: [
                                                    Row(
                                                        children: [
                                                            Text(_listagem[index].id.toString()),
                                                            Text(" - "),
                                                            Text(_listagem[index].descricao ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                                            Icon( _listagem[index].flag.toString() == "1" ?  Icons.star : Icons.star_border ),
                                                        ],
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }

    _editarObjeto({HorarioModel horario}) async {
        final retorno = await Navigator.push(context, MaterialPageRoute(builder: (context) => horarioEditTela(horario: horario,) ) );
        if(retorno != null){
            _getBuscarLista();
        }
    }

    _deletar( index ) {
        _listagem[index].delete(  _listagem[index].id );
        _listagem.removeAt(index);
        setState(() {
            _listagem;
        });
    }

}
