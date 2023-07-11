import React, { useEffect, useState } from "react";
import * as C from "../User/styles";
import Input from "../../components/Input";
import Button from "../../components/Button";
import { signinMfa } from "../../operations/auth";
import { useNavigate } from "react-router-dom";

const MfaForLogin = () => {
  const navigate = useNavigate();
  const [token, setToken] = useState("");
  const [error, setError] = useState("");
  const email = localStorage.getItem("email");
  const authorization = localStorage.getItem("authorization");

  const handleLogin = () => {
    if (!token) {
      setError("Token não informado!");
    }else{
      signinMfa(email, authorization, token).then((response) => {
        if (response.data.status === 404) {
          alert(response.data.errors.toString());
        }else{
          if (response.data) {
            localStorage.setItem("mfa", true);
            alert('Bem vindo!')  
            navigate('/home')
          }else{
            alert('Token invalido!')
          }
        }
      }).catch(function (error) {
        if (error.response.status === 500) {
          alert('Erro interno, tente novamente mas tarde.')
        } else {
          alert(error.response.data.messager);
        }
      });
    }
  };

  return (
    <>
      <C.Container>
      <C.Label>Login via MFA</C.Label>
      <C.Content>
        <C.Strong>Insira o token de autenticação gerado pelo aplicativo</C.Strong>
        <Input 
          type="text"
          placeholder="XXX XXX"
          value={token}
          onChange={(e) => [setToken(e.target.value), setError("")]}
        />
        <C.labelError>{error}</C.labelError>
        
        <Button Text="Entrar" onClick={handleLogin} />
      </C.Content>
    </C.Container>
    </>
  );
};

export default MfaForLogin;