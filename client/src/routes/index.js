import React, { Fragment, useEffect, useState, } from "react";
import { session } from '../operations/auth';
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "../pages/Home";
import Signin from "../pages/Signin";
import Signup from "../pages/Signup";
import Password from "../pages/User/Password";
import Navbar from "../components/Navbar";
import Mfa from "../pages/User/Mfa";


const Private = ({ Item }) => {
  const authorization = localStorage.getItem("authorization");
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
    if (authorization && user === undefined) {
      getProfile();
    }
  },);

  var signed = false;
  if (authorization) {
    signed = true
  }

  return(
      signed ? 
      <>
        <Navbar user={user}/>
        <Item /> 
      </>
      :
    <>
      <Signin />
    </>
  )
};

const RoutesApp = () => {

  return (
    <>
    <BrowserRouter>
      <Fragment>
        <Routes>
          <Route exact path="/home" element={<Private Item={Home} />} />
          <Route exact path="/password" element={<Private Item={Password} />} />
          <Route exact path="/mfa" element={<Private Item={Mfa} />} />
          <Route path="/" element={<Signin />} />
          <Route exact path="/signup" element={<Signup />} />
          <Route path="*" element={<Signin />} />
        </Routes>
      </Fragment>
    </BrowserRouter>
    </>
  );
};

export default RoutesApp;