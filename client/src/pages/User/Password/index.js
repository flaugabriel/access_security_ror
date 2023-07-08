import React, { useState } from "react";
import * as C from "./styles";
import Input from "../../../components/Input";
import Button from "../../../components/Button";

const Password = () => {
  const [password, setPassword] = useState("");
  const [password_confirmation, setPasswordConfirmation] = useState("");
  const [error, setError] = useState("");

  const handlePasswordUpdate = () => {
    if (!password | !password_confirmation) {
      setError("Preencha todos os campos");
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