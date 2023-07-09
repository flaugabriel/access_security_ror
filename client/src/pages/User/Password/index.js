import React, { useState } from "react";
import * as C from "./styles";
import Input from "../../../components/Input";
import Button from "../../../components/Button";
import { passwordUpdate } from "../../../operations/auth";
import { useNavigate } from "react-router-dom";

const Password = () => {
  const navigate = useNavigate();
  const [password, setPassword] = useState("");
  const [password_confirmation, setPasswordConfirmation] = useState("");
  const [error, setError] = useState("");

  const handlePasswordUpdate = (event) => {
  const authorization = localStorage.getItem("authorization");

    if (!password | !password_confirmation) {
      setError("Preencha todos os campos");
    }else{
      event.preventDefault();
      passwordUpdate(authorization, password, password_confirmation).then((response) => {
        if (response.data.status === 404) {
          console.log(response.data.errors[0]);
        } else {
          alert(response.data.message)
          navigate('/')
        }
      }).catch(function (error) {
        console.log(error);
        alert( error.response.data.error)
      });
    }
  };

  return (
    <>
      <C.Container>
      <C.Label>Atualizar Senha</C.Label>
      <C.Content>
        <Input 
          type="password"
          placeholder="Digite sua Senha"
          value={password}
          onChange={(e) => [setPassword(e.target.value), setError("")]}
        />
        <Input
          type="password"
          placeholder="Confirme sua senha"
          value={password_confirmation}
          onChange={(e) => [setPasswordConfirmation(e.target.value), setError("")]}
        />
        <C.labelError>{error}</C.labelError>
        
        <Button Text="Atualizar senha" onClick={handlePasswordUpdate} />
      </C.Content>
    </C.Container>
    </>
  );
};

export default Password;