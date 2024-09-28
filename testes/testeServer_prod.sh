#!/bin/bash
sleep 30
if curl -s --head http://localhost | head -n 1 | grep -q "HTTP/1.[01] [23].."; then
 
  response=$(curl -s http://localhost/api/profile)


  echo "Resposta do endpoint /profile:"
  echo "$response"

  if echo "$response" | grep -q '{"message":"Invalid token"}'; then
    echo "API E WEB rodando corretamente."
    exit 0
  else
    echo "Falha ao iniciar o servidor: resposta incorreta no endpoint /profile."
    exit 1
  fi
else
  echo "Falha ao iniciar o servidor: http://localhost:3000 não está acessível."
  exit 1
fi
