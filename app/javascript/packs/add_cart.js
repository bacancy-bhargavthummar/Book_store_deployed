$(document).ready(function(){

  // $(".add_cart_book").click(function(){
    $(".add_cart_book").change(function(){ 

      var book_id = $(this).data('id')
      var qty = $(this).val()

      // var qty = $(this).parent().siblings().find("#quantity").val()

      $.ajax({
          url: "/line_items" ,
          type: 'POST',
          headers: {
              'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
            },
          data: {
              qty: qty,
              book_id: book_id
          },
          dataType: "script"
          // ContentType: 'application/json'
      })
  });

  $(".delivery_address_form").submit(function(){
    var body = $("#delivery_address").val();

    if (body.length < 1) {
        alert('Please Enter Delivery Address before ordering.');
        return false;
    }
  });
  
})
                          // success: function(result){
                          // location.reload();