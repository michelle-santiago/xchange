class HomeController < ApplicationController
 before_action :get_user
 def index
  $stocks = show_stocks
 end

 def show_stocks
  response = Faraday.get('https://api.iex.cloud/v1/data/CORE/REF_DATA?token=pk_06f0670b09884fe5aa66d394e4263f00')
  JSON.parse(response.body)
 end

 private

 def get_user
     @user = User.find_by_email(cookies.encrypted[:user_id])
    
     if @user.admin?
        redirect_to admin_users_path
     end
 end
end
