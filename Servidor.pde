Server s; 
Client c;

boolean clientConectado = false;

String input;
boolean[] dataClient = {false, false};

void abrirServidor(){
  try{
    s = new Server(this, 12345);
    modo = 0;
    servidor = true;
  }
  catch(Exception e){
    servidor = true;
    modo = 2;
  }
}

void serverEvent(Server someServer, Client someClient) {
  if(clientConectado){
    someServer.disconnect(someClient);
  }
  else
    modo = 1;
}

void serverEnviaDados(){
  s.write(str(pxBola)+" "+str(pyBola)+" "+str(pxServer)+" "+str(pyServer)+" "+str(pxClient)+" "+str(pyClient)+" "+str(pontServer)+" "+str(pontClient)+ " " + str(tamanhoRaquetes) + "\n");
}
void serverRecebeDados(){
  c = s.available();
  if(c != null){
      input = c.readString();
      if(input != null){
        input = input.substring(0,input.indexOf("\n"));
        dataClient = boolean(split(input, ' '));
        timeout = 0;
      }
    }
    else{
      timeout();
    } 
}

void fecharServidor(){
  s.stop(); 
}
