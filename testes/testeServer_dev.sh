#!/bin/bash
sleep 30
# Verifica se o servidor em http://localhost:3000 está rodando
if curl -s --head http://localhost:3000 | head -n 1 | grep -q "HTTP/1.[01] [23].."; then
  # Faz a requisição ao endpoint http://localhost:3333/profile e imprime a resposta
  response=$(curl -s http://localhost:3333/profile)

  # Imprime a resposta
  echo "Resposta do endpoint /profile:"
  echo "$response"

  # Verifica se a resposta contém a mensagem correta
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
