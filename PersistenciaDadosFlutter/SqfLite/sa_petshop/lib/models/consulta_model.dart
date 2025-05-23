import 'package:intl/intl.dart';

class Consulta {
    final int? id;
    final int petId;
    final Datetime dataHora; // obj é dateTime -> BD é string
    final  String tipoServico;
    final String? observacao;

    Consulta({ // Campo de obrigatoriedade -- required é obrigatório -- this não é
        this.id,
        required this.petId,
        required this.dataHora,
        required this.tipoServico,
        this.observacao
    });

    //toMap - obj -> BD
    Map<String,dynamic> toMap(){
        return{
            "id":id,
            "pet_id":petId,
            "data_hora":dataHora.toIso8601String(), // Padrão de conversão de BD 
            "tipo_servico":tipoServico,
            "observacao":observacao
        };
    }

    //fromMap - BD -> obj
    factory Consulta.fromMap(Map<String,dynamic> map){
        return Consulta(
            id: map["id"] as int,
            petId: map["pet_id"] as int,
            dataHora: Datetime.parse(map["data_hora"] as String), // converte String em DateTime
            tipoServico: map["tipo_servico"] as String,
            observacao: map["observacao"] as String?
        );
    }

    // Método para formatar a data e hora em formato Brasil
    String get dataHoraFormatada {
        final formatter = DateFormat("dd/MM/yyyy HH:mm");
        return formatter.format(dataHora);
    }
}