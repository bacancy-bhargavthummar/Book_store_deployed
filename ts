<h2>Edit <%= resource_name.to_s.humanize %></h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>


  <div class="field">
    <%= f.label :user_name %><br />
    <%= f.text_field :name, autofocus: true, autocomplete: "user_name" %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
    <div>Currently waiting confirmation for: <%= resource.unconfirmed_email %></div>
  <% end %>


  <div class="field">
    <%= f.label :phone_no %><br />
    <%= f.text_field :phone_no, autofocus: true, autocomplete: "phone_no" %>
  </div>
  <div class="field">
    <b>Gender</b><br />
    <%= f.radio_button :gender, 'male' %> male<br />
    <%= f.radio_button :gender, 'female' %> female<br />
    <%= f.radio_button :gender, 'other' %> other<br />    
  </div>

  <div class="field">
    <%= f.label :password %> <i>(leave blank if you don't want to change it)</i><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
    <% if @minimum_password_length %>
      <br />
      <em><%= @minimum_password_length %> characters minimum</em>
    <% end %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :current_password %> <i>(we need your current password to confirm your changes)</i><br />
    <%= f.password_field :current_password, autocomplete: "current-password" %>

  </div>

  <div class="actions">
    <%= f.submit "Update" %>
  </div>
<% end %>

<!-- <h3>Cancel my account</h3>

<p>Unhappy? <%= button_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p> -->

<%= link_to "Back", :back %>

------------------------------------------------------------------------------------------


<!-- Page Content 
<div class="container">

  <div class="row">

    <div class="col-lg-3">
      <h1 class="my-4">Book</h1>
      <div class="list-group">
        <% if @book_seller.present? %>
          <% if current_user && (@book_seller.seller_id == current_user.id || current_user.admin) %>
            <%= link_to 'Edit Book Details', edit_book_path(@book ,@book_seller), class: "list-group-item" %>
          <% end %>
        <% end %>
        <% if current_user && current_user.admin %>
            <%= link_to 'Destroy', @book, method: :delete, data: { confirm: 'Are you sure?' }, class: "list-group-item" %>
        <% end %> 
        <%= link_to 'Back', '/', class: "list-group-item" %>
        <!--  <a href="#" class="list-group-item">Category 3</a> -->
      </div>
    </div>
    <!-- /.col-lg-3 -->

    <div class="col-lg-9">

      <div class="card mt-4">
        <% if @book.image.present? %>
          <div style="width:600px; heigth: auto" >
          <%= image_tag(@book.image, style: "width:100%", class: "card-img-top img-fluid") %>
          </div>
        <% else %>
        <br>
          <h3>&nbsp Image is not uploaded </h3>
        <br>
        <% end %>
        <div class="card-body">
          <h3 class="card-title"><%= @book.name %></h3>
          <hr>
          <h5 class="card-title">Author : <%= @book.author %></h5>
          <h5 class="card-title">ISBN : <%= @book.isbn %></h5>
          <h5 class="card-title">Category : <%= @book.category.name %></h5>
          <% if current_user && current_user.admin %>
          <p>
          <strong>Total Qty:</strong>
          <h5 class="card-title">Total Quantity : <%= @book.total_qty %></h5>
          </p>
          <% end %>

          <h4>$<%= @book.price %></h4>
          <p class="card-text"><%= @book.description %></p>
          <span class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9734;</span>
        </div>
      </div>
      <!-- /.card -->

      <div class="card card-outline-secondary my-4">
        <div class="card-header">
          Comments
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
          <small class="text-muted">Posted by Anonymous on 3/1/17</small>
          <hr>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
          <small class="text-muted">Posted by Anonymous on 3/1/17</small>
          <hr>
          <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
          <small class="text-muted">Posted by Anonymous on 3/1/17</small>
          <hr>
          <a href="#" class="btn btn-success">Leave a Review</a>
        </div>
      </div>
      <!-- /.card -->

    </div>
    <!-- /.col-lg-9 -->

  </div>

</div>
<!-- /.container -->

<!-- Footer -->
<footer class="py-5 bg-dark">
  <div class="container">
    <p class="m-0 text-center text-white">Copyright &copy; Your Website 2019</p>
  </div>
  <!-- /.container -->
</footer>



  <% if @book.image.present? %>
  <div style="width:400px; hiegth:auto" >
  <%= image_tag(@book.image, style:"width:100%") %>
  </div>
  <% else %>
  <h3> Image is not uploaded </h3>
  <% end %>

  <p>
    <strong>Name:</strong>
    <%= @book.name %>
  </p>

  <p>
    <strong>Description:</strong>
    <%= @book.description %>
  </p>

  <p>
    <strong>Author:</strong>
    <%= @book.author %>
  </p>

  <p>
    <strong>ISBN no:</strong>
    <%= @book.isbn %>
  </p>

  <p>
    <strong>Price:</strong>
    <%= @book.price %>
  </p>

  <p>
    <strong>Total Qty:</strong>
    <%= @book.total_qty %>
  </p>

  <p>
    <strong>Category:</strong>
    <%= @book.category.name %>
  </p>

  <hr>
  <h2>Comments</h2>
   <%= render @book.comments %>
   <hr>

   <% if current_user %>
  <h2> Add Comments here </h2>
  <%= render 'comments/form' %>
  <% else %>
  <h3> Please Sign in for add comments </h3>
  <% end %> -->

----------------------------------------------------------------------------------------------------------

<%= render "devise/shared/error_messages", resource: resource %>
<body class="text-center">
  <div class="form-signin">
    <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
    <label for="inputEmail" class="sr-only">Email address</label>
      <%= form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :post }) do |f| %>
      <br>
        <div class="field">
          <%= f.email_field :email, autofocus: true, autocomplete: "email", class: "form-control", placeholder: "Email" %>
        </div>
        <br>
        <div class="actions">
          <%= f.submit "Send Email", class: "btn btn-lg btn-primary btn-block" %>
        </div>
      <% end %>
    <%= render "devise/shared/links" %>
  </div>
</body>

-----------------------------------------------------------------------------------------------

<% @carts.each do |cart| %>
            <hr>
            <h4>Date of Cart :<%= cart.created_at %>.</h4>
            <h5>Invoice_id: <%="#{cart.id}."%> </h5>
            <hr>
            <table class="table">
            <thead class="thead-dark">
                <th>Quantity</th>
                <th>Book Name</th>
                <th>Cost/Unit</th>
                <th>Cost</th>                
            </thead>
                <% cart.line_items.each do |line_item| %>
                <tr>
                    <td><%= line_item.quantity %></td>
                    <td><%= line_item.book.name %></td>
                    <td><%= line_item.book.price %></td>
                    <td><%= line_item.total_price %></td> 
                </tr>
                <% end %>
            <tfoot>
                <tr>
                    <th colspan="3">Total:</th>
                    <td class="price"><%= cart.total_price %> INR</td>
                </tr>
                <tr>
                    <th colspan="5"></th>
                    <td>Order status is successfull and Request is Pending.</td>    
                </tr>      
            </tfoot>
            </table>
            <hr>
        <% end %>
-----------------------------------------------------------------------------------------------------------
<% cache @books do %>
    <% @books.each do |book| %>
        <% cache book do %>
-----------------------------------------------------------------------------------------------------------

<%= button_to 'Place order',charge_order_path(@cart), method: :get, class: "btn btn-danger" %>

  @book = Book.find(params[:book_id])
        comment=params[:comment]
        @comment = @book.comments.new

         @comment.commenter = session[:commenter] 
         @comment.body = comment[:body]
        if @comment.save 
        redirect_to book_path(@book)
        end




        <%= form_tag("/books/index2", method: "get", remote: false) do %>
  <%= text_field_tag :query, params[:query] %>
  <%= submit_tag "search" %>
  <% end %>
  <br>



  <%= search_form_for @book do |b| %>
  <%= b.search_field :book_name_or_book_author_or_isbn_cont %>
  <%= b.submit "Search" %>
  <% end %>
  <br>


  <%= b.submit "Search", class: "btn btn-elegant btn-rounded btn-sm my-0"  %>

  <%= submit_tag "search" %>

  <!-- <td><%= link_to 'Delete Profile',destroy_user_path(user), :method => :delete, data: { confirm: 'Are you sure?' } %></td> -->

  delete '/users/:id' => 'users#destroy', :as => :destroy_user

  get 'index' , on: :collection , action: :index

  <%= render 'common', cart: @cart.line_items %>



      book = Book.find_by(isbn: book_params[:isbn])
      if Book.find_by(isbn: book_params[:isbn]).present? && BookSeller.find_by(seller_id: current_user.id, book_id: book.id).present?

Updates than Atclwc

=> Your cart functionality added.
=> Book creation and updatation issues solved.
=> On present quantity in stock add to cart managed.
=> PDF generated.
=> invoice mail send on placing order.

$(".my_comment_form").trigger('reset');