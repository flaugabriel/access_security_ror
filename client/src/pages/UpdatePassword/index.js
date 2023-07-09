import React, { useState } from "react";
import * as C from "./styles";
import Input from "../../components/Input";
import Button from "../../components/Button";

const UpdatePassword = () => {
  const [email, setEmail] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = () => {
    if (!email) {
      setError("Preencha todos os campos");
    }
  };

  return (
    <>
      <C.Container>
      <C.Label>Login</C.Label>
      <C.Content>
        <C.Strong>Insira seu email para enviarmos um link de redefinição</C.Strong>
        <Input 
          type="text"
          placeholder="example@example.com"
          value={email}
          onChange={(e) => [setEmail(e.target.value), setError("")]}
        />
        <C.labelError>{error}</C.labelError>
        
        <Button Text="Entrar" onClick={handleSubmit} />
      </C.Content>
    </C.Container>
    </>
  );
};

export default UpdatePassword;