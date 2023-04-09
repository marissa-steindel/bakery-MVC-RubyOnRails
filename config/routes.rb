Rails.application.routes.draw do
  root "customers#index"
  resources :customers
  resources :provinces
  resources :categories
  resources :products
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