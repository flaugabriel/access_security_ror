import axios from 'axios';

const urlBase = 'http://localhost:3030/api/';

export const index = (authorization) => 
  axios({
    url: urlBase + 'cnabs',
    method: "GET",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      'Authorization': `${authorization}`
    },
  });

export const upload = (file, authorization) =>
  axios({
    url: urlBase + 'cnabs/import',
    method: "POST",
    headers: {
      Accept: "application/json",
      'Authorization': `${authorization}`
    },
    data: file
  });

export const delete_all = (authorization) => 
  axios({
    url: urlBase + 'cnabs',
    method: "DELETE",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
      'Authorization': `${authorization}`
    },
  })

export default [delete_all, upload, index]