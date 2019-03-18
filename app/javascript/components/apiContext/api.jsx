


 export const deleteRecord=(url,id)=>{
   
   return  fetch(url + '/' + id, {
      method: 'DELETE'
    }).then(response =>
      response.json().then(json => {
        return json;
      })
    );
  }