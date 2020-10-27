int[] dataServidor = {0,0,0,0,0,0,0,0,0,0};

void abrirClient(){
  try{
    //BufferedReader reader = createReader("ip.txt");
    //String ip = reader.readLine();
    c = new Client(this,"localHost", 12345);
    print(c);
    cliente = true;
    modo = 0;
  }
  catch(Exception e){
    
  }
}

void clientEnviaDados(){
  c.write(str(up) + " " + str(down)+"\n");
}

void clientRecebeDados(){
  if(c.available()>0){
      input = c.readString();
      input = input.substring(0,input.indexOf("\n"));
      dataServidor = int(split(input, ' '));
      timeout = 0;
    }
  else{
    timeout();
  }
    pxBola = dataServidor[0];
    pyBola = dataServidor[1];
    pxServer = dataServidor[2];
    pyServer = dataServidor[3];
    pxClient = dataServidor[4];
    pyClient = dataServidor[5];
    pontServer = dataServidor[6];
    pontClient = dataServidor[7];
    tamanhoRaquetes = dataServidor[8];
}

void fecharClient(){
  c.stop();
}
