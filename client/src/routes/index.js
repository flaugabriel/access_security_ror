import React, { Fragment, useEffect, useState, } from "react";
import { session } from '../operations/auth';
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "../pages/Home";
import Signin from "../pages/Signin";
import Signup from "../pages/Signup";
import Password from "../pages/User/Password";
import Navbar from "../components/Navbar";
import MfaForLogin from "../pages/MfaForLogin";
import MfaSettings from "../pages/User/Password/MfaSettings";
import ForgotPassword from "../pages/ForgotPassword";
import UpdatePassword from "../pages/UpdatePassword";

const Private = ({ Item }) => {
  const authorization = localStorage.getItem("authorization");
  const [user, setUser] = useState();

  const getProfile = () => {
    session(authorization).then((items) => {
      if (items.data !== undefined) {
        setUser(items.data.data)
      }
    }).catch(error => {
      console.log(error);
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
          <Route exact path="/settings/mfa" element={<Private Item={MfaSettings} />} />
          <Route path="/mfa" element={<MfaForLogin />} />
          <Route path="/update_password" element={<UpdatePassword />} />
          <Route path="/forgot_password" element={<ForgotPassword />} />
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