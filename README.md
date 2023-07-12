## INFORMAÇÃO/INSTALAÇÃO

Este projeto tem como finalidade de desenvolver mecanismo de acesso, dentre esses mecanismos estão em destaque:

* Senha segura.
* Expiração de sessão.
* Bloqueio por limite máximo de tentativas de login.
* proteção via captcha. 
* duplo fator de autenticação.

Tecnologias utilizadas:
* Ruby 3.2.1
* Rails 7.0.4.3 (api)
* React 18.2.0
* PostgreSQL Stable
* Docker 24.0.0 /Compose 1.29.2

## Preparação de como configura este projeto ? 🔨
OBS: Para os requisitos nescessario para executa esse projeto é preciso do docker/docker-compose.  Dependendo da versão que está instalado em seu equipamento o comando de ação muda versões mais antigas 2022 estão operando com a sintaxe
```docker-compose ```a mais atual é ```docker compose ```. 
No caso deste projeto foi utilizado o comando compose da forma antiga na versão 1.29.2

## Setup 
Na raiz do projeto acess_security_ror execute:
Para instala e configura as imagens e containers 

```shell
docker-compose build
```
Levanta os servidores

```shell
docker-compose up
```
Configurando o banco de dados

```shell
docker-compose run --rm api rails db:drop db:create db:migrate
```
Acesse [localhost:3000](localhost:3000) Para visualiza a ir a de login ou Realize um Cadastro usando esse link http://localhost:3000/signup

## Consumindo os endpoint da API
Nota: esta api se encontra preparada para versionamento. (plus)
### Rotas Auth

* POST http://localhost:3030/api/auth/sign_in (LOGIN)

* POST http://localhost:3030/api/v1/sign_up (CADASTRO DE USUÁRIO)

### Rotas users

* GET http://localhost:3030/api/myaccount/mfa (PERFIL DO USUPARIO/SESSÃO)

* POST http://localhost:3030/api/myaccount/token (ATUALIZA O DO USUARIO)(PLUS)

### Autenticação (plus)
* Após o login e necessário envia via headers o 
Authorization: Bearer <your_token>

#### login:
```POST localhost:3030/api/auth/sign_in```
```json
{
	"email": "test@gmail.com",
	"password": "12345678"
}
```
resposta:
```json
{
	"data": {
		"email": "test@test.com",
		"provider": "email",
		"uid": "test@test.com",
		"id": 2,
		"allow_password_change": false
	}
}
```
#### Cadastro:
```POST localhost:3030/api/auth```
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"status": "success",
	"data": {
		"id": 1,
		"provider": "email",
		"uid": "test@gmail.com",
		"allow_password_change": false,
		"email": "test@gmail.com",
		"created_at": "2023-05-22T10:48:54.580-04:00",
		"updated_at": "2023-05-22T10:48:54.639-04:00"
	}
}
```
### User
#### atualiza perfil (senha, confirmação)
```PUT localhost:3030/api/myaccount/profile```
```json
{
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"message": "Senha atualizado."
}
```
#### consulta perfil/session
```GET localhost:3030/api/myaccount/profile```
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
resposta:
```json
{
	"data": {
		"id": 1,
		"provider": "email",
		"uid": "test@gmail.com",
		"allow_password_change": false,
		"email": "test@gmail.com",
		"created_at": "2023-05-22T10:48:54.580-04:00",
		"updated_at": "2023-05-22T10:49:16.968-04:00"
	}
}
```
#### Esqueceu sua senha
```POST localhost:3030/password/forgot```
```json
{
  "email": "flaugabriel@gmail.com"
}
```
resposta:
```json
{
	"status": "ok"
}
```
#### Recupere sua senha
```POST localhost:3030/password/reset```

```json
{
  "email": "flaugabriel@gmail.com",
  "token": "05b0b53d881660c62ae1",
  "password": "Gabrielwga28201945"
}
```
resposta
```json 
{
 	"status": "ok"
}
```
#### Recupere sua conta 
```POST localhost:3030/unlock/show?unlock_token=<token>```

params: token é verifique no email o token
resposta:
```json
{
	"messager": "Conta desbloqueada"
}
```
## Testes 

Executando todos os testes
```shell
docker-compose run --rm api rspec
```

## Cobertura de codigos (SimpleCov)
Após compila os testes vá clique [aqui](api/coverage/index.html) para visualizar a cobertura de testes.
### Fim Obrigado! :D 🚀
