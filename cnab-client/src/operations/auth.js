import axios from 'axios';

const urlBase= 'http://localhost:3030/api/';

export const signin = (email, password) => 
  axios({
    url: urlBase + 'auth/sign_in',
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    data: { email: email, password: password },
  })
  

export const signup = (email, password, password_confirmation) => 
  axios({
    url: urlBase + 'auth',
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    data: { email: email, password: password, password_confirmation: password_confirmation },
  })

export const session = (authorization) => 
  axios({
    url: urlBase + 'myaccount/profile',
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      'Authorization': `${authorization}`
    }
  })

export const signout = () => {
  localStorage.removeItem("authorization");
};

export default [signup, signout, signin, session]
