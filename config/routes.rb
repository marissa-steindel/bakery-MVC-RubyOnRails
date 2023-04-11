Rails.application.routes.draw do
  root "products#index"
  resources :customers
  resources :provinces
  resources :categories
  resources :products
  resources :orders
  resources :product_categories

  post    'add_to_cart/:id',          to: "products#add_to_cart",         as: "add_to_cart"
  delete  'remove_from_cart/:id',     to: "products#remove_from_cart",    as: "remove_from_cart"
  delete  'decrement_from_cart/:id',  to: "products#decrement_from_cart", as: "decrement_from_cart"
  get     'clear_cart',               to: "products#clear_cart",          as: "clear_cart"

  get     "login",  to: "customers#login",        as: "show_login_form"
  post    "login",  to: "customers#authenticate", as:"authenticate"
  delete  "logout", to: "customers#logout",       as:"logout"

  get "checkout", to: "checkout#index", as: "checkout"
  get "thankyou", to: "checkout#thankyou"

  get "invoice", to: "orders#invoice", as: "invoice"

end


  # GET	      /photos	          photos#index	  display a list of all photos
  # POST	    /photos	          photos#create	  create a new photo
  # GET	      /photos/new	      photos#new	    return an HTML form for creating a new photo
  # GET	      /photos/:id	      photos#show	    display a specific photo
  # PATCH/PUT	/photos/:id	      photos#update	  update a specific photo
  # DELETE	  /photos/:id	      photos#destroy	delete a specific photo
  # GET	      /photos/:id/edit	photos#edit	    return an HTML form for editing a photo

  # photos_path           returns /photos
  # new_photo_path        returns /photos/new
  # edit_photo_path(:id)  returns /photos/:id/edit (edit_photo_path(10) returns /photos/10/edit)
  # photo_path(:id)       returns /photos/:id (photo_path(10) returns /photos/10)