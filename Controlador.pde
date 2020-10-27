boolean cliente = false, servidor = false;
boolean vitoria = false, derrota = false;
int modo = 0;

boolean caiu = false;
int timeout = 0;

int timeConexao = 0;

void controlador() {
  desenhaJogo();
  if (!servidor && !cliente) {
    fill(0);
    rect(width/2, height/2, 50, 120);
    fill(255);
    textSize(50);
    text("PONG", width/2, 100);
    textSize(25);
    text("Para criar partida pressione UP \nPara se juntar pressione DOWN", width/2, height/2);
    if (keyPressed && keyCode == UP) {
      abrirServidor();
    }
    if (keyPressed && keyCode == DOWN) {
      abrirClient();
    }
  } else if (servidor) {
    switch(modo) {
    case 0:
      fill(0);
      rect(width/2, height/2, 10, 10);
      fill(255);
      String ip = Server.ip();
      text("Aguardando Jogador", width/2, height/2);
      break;
    case 1:
      if (caiu) {
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Ocorreu um erro de conexão!\nPressione qualquer tecla para voltar", width/2, height/2);
        if(keyPressed){
          fecharServidor();
          reiniciaVariaveis();
        }
      } else if (vitoria) {
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Você venceu!!", width/2, height/2);
      } else if (derrota) {
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Você perdeu!", width/2, height/2);
      } else {
        pong();
        serverEnviaDados();
        serverRecebeDados();
      }
      break;
      case 2:
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Já existe um servidor neste ip\nPressione DOWN para retornar", width/2, height/2);
        if(keyPressed && keyCode == DOWN){
          servidor = false;
          modo = 0;
        }
    }
    
  } else if (cliente) {
    switch(modo) {
    case 0:
        if(c.available()>0){
          modo = 1;
        }
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Aguarde...", width/2, height/2);
        if (keyPressed && keyCode == UP) {
          cliente = false;
          timeConexao = 0;
          c.stop();
        }
        if(timeConexao>30){
          fill(0);
          rect(width/2, height/2, 100, 50);
          fill(255);
          text("Host não encontrado!\nPressione UP para retornar", width/2, height/2);
        }
        timeConexao++;
      break;
    case 1:
      if (caiu) {
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Ocorreu um erro de conexão!\nPressione qualquer tecla para voltar", width/2, height/2);
        if(keyPressed){
          fecharClient();
          reiniciaVariaveis();
        }
      } else if (vitoria) {
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Você venceu!!", width/2, height/2);
      } else if (derrota) {
        fill(0);
        rect(width/2, height/2, 10, 10);
        fill(255);
        text("Você perdeu!", width/2, height/2);
      } else {
        clientRecebeDados();
        desenhaJogo();
        controleClient();
        clientEnviaDados();
        vitoriaOuDerrota();
      }
      break;
    }
  }
}

void timeout() {
  timeout++;
  if (timeout >= 60) {
    caiu = true;
  }
}
