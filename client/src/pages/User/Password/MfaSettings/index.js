import React, { useState } from "react";
import * as C from "./styles";
import Input from "../../../../components/Input";
import Button from "../../../../components/Button";

const MfaForLogin = () => {
  const [token, setToken] = useState("");
  const [error, setError] = useState("");

  const handlePasswordUpdate = () => {
    if (!token) {
      setError("Preencha todos os campos");
    }
  };

  return (
    <>
      <C.Container>
      <C.Label>Login</C.Label>
      <C.Content>
        <C.Strong>Insira o token de autenticação gerado pelo aplicativo</C.Strong>
        <Input 
          type="text"
          placeholder="XXX XXX"
          value={token}
          onChange={(e) => [setToken(e.target.value), setError("")]}
        />
        <C.labelError>{error}</C.labelError>
        
        <Button Text="Entrar" onClick={handlePasswordUpdate} />
      </C.Content>
    </C.Container>
    </>
  );
};

export default MfaForLogin;