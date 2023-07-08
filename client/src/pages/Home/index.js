import React, { useEffect, useState } from "react";
import './styles.css';
import { signout } from '../../operations/auth';
import { session } from '../../operations/auth';
import { useNavigate } from "react-router-dom";


const Home = () => {
  const authorization = localStorage.getItem("authorization");
  const navigate = useNavigate();
  const [user, setUser] = useState();

  const getProfile = () => {
    session(authorization).then((items) => {
      if (items.data !== undefined) {
        setUser(items.data.data)
      }
    }).catch(error => {
      alert(error.response.data.errors[0])
    });
  }

  useEffect(() => {
    if (authorization) {
      getProfile();
    } else {
      navigate('/')
    }
  }, []);

  return (
    <>
      <header className="space-custon">
        <nav className="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
          <div className="container-fluid">
            <a className="navbar-brand" href="#" >ACCESS SECURITY ROR</a>
            <div className="collapse navbar-collapse" id="navbarCollapse">
              <ul className="navbar-nav me-auto mb-2 mb-md-0">
              </ul>
              <form className="d-flex">
                <a className="navbar-brand" disabled ></a>
              </form>
              <form className="d-flex">
                <a className="navbar-brand" disabled >{user?.email}</a>
                <button className="btn btn-danger" onClick={() => [signout(), navigate('/')]} type="submit">Sair</button>
              </form>
            </div>
          </div>
        </nav>
      </header>
      <main className="flex-shrink-0">
        <div className="text-center">
          <div className="container margin-top">
            <div class="card">
              <div class="card-body">
                <h1>  Security Page</h1>
              </div>
            </div>
          </div>
        </div>
      </main>
    </>
  );
};

export default Home;