def signup_error(params)
  empty_fields = ["must enter"]
  if params[:username] == ""
    empty_fields << "username"
  end
  if params[:password] == ""
    empty_fields << "password"
  end
  if params[:email] == ""
    empty_fields << "email"
  end
  if empty_fields.size == 1
    empty_fields = ""
  else
    empty_fields = empty_fields.join(" ")
  end
  empty_fields
end
<<<<<<< HEAD

def slugify(slug)
  spots = slug.length
  dex = 0
  ray = slug.split("")
  ray.each do |spot|
    if spot == " "
      ray[dex] = "-"
    end
    dex += 1
  end
  value = ray.join
end



def deslugify(slug)
  spots = slug.length
  dex = 0
  ray = slug.split("")
  ray.each do |spot|
    if spot == "-"
      ray[dex] = " "
    end
    dex += 1
  end
  value = ray.join
end
=======
>>>>>>> e498e2874dc1c65b9572a3cc6e96705b3cab98ce
