class Base::AuthenticatedController < ApplicationController
  
  before_filter :authenticate_user!
  
end  