# App de Registro de Ponto

## Descrição

O **PontoApp** é um aplicativo desenvolvido para permitir que os funcionários registrem seu ponto de trabalho de forma simples e segura, utilizando geolocalização para garantir que o registro esteja sendo feito dentro de um raio de 100 metros do local de trabalho. O app oferece duas opções de autenticação: **NIF e senha** ou **Reconhecimento Facial via biometria**.

## Funcionalidades

**Autenticação por NIF e Senha ou Reconhecimento Facial**:
   - **NIF e senha**: O usuário pode autenticar-se utilizando seu NIF (Número de Identificação Fiscal) e senha previamente cadastrados.
   - **Reconhecimento Facial**: Alternativamente, o app permite a autenticação por reconhecimento facial utilizando a câmera do dispositivo.
   
**Verificação de Localização**:
   - O aplicativo utiliza a **geolocalização** para garantir que o registro de ponto seja feito apenas quando o funcionário estiver dentro de um raio de **100 metros do local de trabalho**. Caso o usuário esteja fora da área definida, o ponto não será registrado.

**Armazenamento de Dados**:
   - O registro de ponto, incluindo **data**, **hora** e **localização** (latitude e longitude), é armazenado de forma segura.
   
**Integração com Firebase**:
   - O aplicativo utiliza o **Firebase** para gerenciar a autenticação e o armazenamento dos dados de ponto. Ele oferece escalabilidade e segurança na sincronização dos registros.

---

## Como Usar

### **Instalar o Aplicativo**
   - Faça o download do **PontoApp** na **Google Play Store** ou **Apple App Store**.
   
### **Autenticação**
   - Ao abrir o app, você será solicitado a escolher entre dois métodos de autenticação:
     1. **NIF e Senha**: Insira seu NIF e a senha cadastrada. 
     2. **Reconhecimento Facial**: Caso tenha configurado a biometria, a câmera será ativada e você deverá olhar para ela para o reconhecimento.
     
### **Registrar Ponto**
   - Depois de autenticar-se, a verificação de localização será realizada automaticamente.
   - O app validará se você está dentro do raio de **100 metros** do local de trabalho.
   - Se a localização for válida, o ponto será registrado com **data**, **hora** e **localização**.
   
### **Verificação de Registros**
   - Você pode consultar seus registros de ponto diretamente na interface do app, que mostrará a lista de entradas realizadas.

---

## Como Funciona

- **Autenticação**: O app utiliza o Firebase para gerenciar a autenticação via **NIF e senha** ou **reconhecimento facial**. As credenciais são validadas com segurança no servidor Firebase.
  
- **Geolocalização**: O aplicativo acessa os serviços de localização do dispositivo para verificar se o usuário está dentro do raio de 100 metros do local de trabalho. Caso contrário, o ponto não é registrado e uma mensagem de erro será exibida.

- **Armazenamento no Firebase**: Cada registro de ponto é armazenado no banco de dados do Firebase. A data, hora e localização do ponto são salvas de forma segura e podem ser acessadas apenas pelo usuário autenticado.

---

## Tecnologias Utilizadas

- **Firebase Authentication**: Para autenticação de usuários (NIF, senha e biometria).
- **Firebase Firestore**: Para armazenamento dos registros de ponto.
- **Google Maps API**: Para verificar a localização do usuário via geolocalização.
- **Biometria**: Utiliza a API de reconhecimento facial do dispositivo para autenticação.
