#!/bin/bash


API_URL="https://localhost/api/users"


USER_NAME="Teste Usuario"
USER_EMAIL="teste@exemplo.com"
USER_PASSWORD="senha123"


response=$(curl -s -o /dev/null -w "%{http_code}" -k -X POST "$API_URL" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "name": "$USER_NAME",
  "email": "$USER_EMAIL",
  "password": "$USER_PASSWORD"
}
EOF
)

if [ "$response" -eq 201 ]; then
  echo "Usuário criado com sucesso."
  exit 0
else
  echo "Falha ao criar usuário. Status HTTP: $response"
  exit 1
fi
