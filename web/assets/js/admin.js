/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function askToDelete(idBook) {
    swal({
        title: "Are you sure to delete this book?",
        icon: "warning",
        buttons: true,
        dangerMode: true
    }).then((willDelete) => {
        if (willDelete) {
            window.location.href = "deleteBook?idBook=" + idBook;
        }
    });

}