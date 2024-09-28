#!/bin/bash


AUTH_URL="https://localhost/api/sessions/password"

USER_EMAIL="teste@exemplo.com"
USER_PASSWORD="senha123"


response=$(curl -s -k -X POST "$AUTH_URL" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "email": "$USER_EMAIL",
  "password": "$USER_PASSWORD"
}
EOF
)


status_code=$(curl -s -o /dev/null -w "%{http_code}" -k -X POST "$AUTH_URL" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "email": "$USER_EMAIL",
  "password": "$USER_PASSWORD"
}
EOF
)


if [ "$status_code" -eq 201 ]; then

  token=$(echo "$response" | jq -r '.token')

  echo "Login bem-sucedido. Token: $token"
  exit 0
else
  echo "Falha ao realizar login. Status HTTP: $status_code"
  echo "Resposta completa:"
  echo "$response"
  exit 1
fi
