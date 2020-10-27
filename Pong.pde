int pxBola = 300, pyBola = 175, vxBola = -3, vyBola = 3;
int pxServer = 50, pyServer = 175;
int pxClient = 550, pyClient = 175;
int tamanhoRaquetes = 35;
int pontServer = 0, pontClient = 0;

int contBola = 0;

boolean up = false, down = false;

void pong(){
  determinaPosServer();
  determinaPosClient();
  fisicaBola();
  vitoriaOuDerrota();
}

void desenhaJogo(){
  background(0);
  fill(255);
  rect(width/2, height/2, width/2 - 10, height/2 - 10);
  fill(0);
  rect(width/2, height/2, width/2 - 30, height/2 - 30);
  fill(255);
  rect(pxBola, pyBola, 5, 5);
  rect(pxServer, pyServer, 5, tamanhoRaquetes);
  rect(pxClient, pyClient, 5, tamanhoRaquetes);
  text(str(pontServer) + "X" + str(pontClient),300,80);
}

void fisicaBola(){
  if(tamanhoRaquetes<25){
    if(vxBola < 0){
      vxBola = -4;
    }
    else if(vxBola > 0){
      vxBola = 4;
    }
  }
  else if(tamanhoRaquetes<15){
    if(vxBola < 0){
      vxBola = -5;
    }
    else if(vxBola > 0){
      vxBola = 5;
    }
  }
  //Colisão com a parte de cima e baixo
  if(pyBola - 5 < 30){
    vyBola = -vyBola;
  }
  if(pyBola + 5 > 320){
    vyBola = -vyBola;
  }
  //Colisão com as raquetes
  if(pxBola - 5 <= pxServer + 5 && pxBola - 5 >= pxServer - 5 && pyBola + 5 > pyServer - tamanhoRaquetes && pyBola - 5 < pyServer + tamanhoRaquetes){
    pxBola = pxServer + 11;
    vxBola = -vxBola;
    tamanhoRaquetes-=2;
    if(tamanhoRaquetes<4){
      tamanhoRaquetes = 4;
    }
  }
  if(pxBola + 5 >= pxClient - 5 && pxBola + 5 <= pxClient + 5 && pyBola + 5 > pyClient - tamanhoRaquetes && pyBola - 5 < pyClient + tamanhoRaquetes){
    pxBola = pxClient - 11;
    vxBola = -vxBola;
    tamanhoRaquetes-=2;
    if(tamanhoRaquetes<4){
      tamanhoRaquetes = 4;
    }
  }
  //Adiciona pontuação
  if(pxBola > 570){
    pontServer++;
    if(vxBola>0){
      vxBola = 3;
    }
    else if(vxBola < 0){
      vxBola = -3;
    }
    vxBola = -vxBola;
    resetaPosBola();
    contBola = 0;
  }
  if(pxBola < 30){
    pontClient++;
    if(vxBola>0){
      vxBola = 3;
    }
    else if(vxBola < 0){
      vxBola = -3;
    }
    vxBola = -vxBola;
    resetaPosBola();
    contBola = 0;
  }
  
  if(contBola > 60){
    pyBola = pyBola + vyBola;
    pxBola = pxBola + vxBola;
  }
  contBola++;
  
}

void resetaPosBola(){
  pxBola = 300;
  pyBola = 175;
  tamanhoRaquetes = 35;
}

void determinaPosServer(){
  if(keyPressed && keyCode == DOWN){
    pyServer = pyServer + 2;
    if(pyServer + tamanhoRaquetes > 320){
      pyServer = 320 - tamanhoRaquetes;
    }
  }
  if(keyPressed && keyCode == UP){
    pyServer = pyServer - 2;
    if(pyServer - tamanhoRaquetes < 30){
      pyServer = 30 + tamanhoRaquetes;
    }
  }
}

void determinaPosClient(){
  println(dataClient[0]);println(dataClient[1]);
  if(dataClient[0] == true){
    pyClient = pyClient + 2;
    if(pyClient + tamanhoRaquetes > 320){
      pyClient = 320 - tamanhoRaquetes;
    }
  }
  if(dataClient[1] == true){
    pyClient = pyClient - 2;
    if(pyClient - tamanhoRaquetes < 30){
      pyClient = 30 + tamanhoRaquetes;
    }
  }
}

void controleClient(){
  if(keyPressed && keyCode == DOWN){
    down = false;
    up = true;
  }
  else if(keyPressed && keyCode == UP){
    down = true;
    up = false;
  }
  else{
    down = false;
    up = false;
  }
}

void vitoriaOuDerrota(){
  if(servidor){
    if(pontServer == 5){
      vitoria = true;
    }
    if(pontClient == 5){
      derrota = true;
    }
    
  }
  if(cliente){
      if(pontClient == 5){
        vitoria = true;
      }
      if(pontServer == 5){
        derrota = true;
      }
  }
}


void reiniciaVariaveis(){
  pxBola = 300;
  pyBola = 175;
  vxBola = -3;
  vyBola = 3;
  pxServer = 50;
  pyServer = 175;
  pxClient = 550;
  pyClient = 175;
  tamanhoRaquetes = 35;
  pontServer = 0; 
  pontClient = 0;
  modo = 0;
  servidor = false;
  cliente = false;
  caiu = false;
  timeout = 0;
  contBola = 0;
}
