import React from "react";
import { signout } from "../../operations/auth";

const Navbar = ({user}) => {

  return (
    <header className="space-custon">
      <nav className="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <div className="container-fluid">
          <a className="navbar-brand" href="/#" >Olá, {user?.email}</a>
          <div className="collapse navbar-collapse" id="navbarCollapse">
            <ul className="navbar-nav me-auto mb-2 mb-md-0">
            </ul>

            <form className="d-flex">
              <a className="navbar-brand" href="/home">HOME</a>
              <a className="navbar-brand" href="/password">Senha</a>
              <a className="navbar-brand" href="/mfa">MFA</a>
            </form>

            <form className="d-flex">
              <button className="btn btn-danger" onClick={() => [signout()]} type="submit">Sair</button>
            </form>
          </div>
        </div>
      </nav>
    </header>
  );
};

export default Navbar;
