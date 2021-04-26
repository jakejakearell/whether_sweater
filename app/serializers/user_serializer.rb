class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key, :email
end
