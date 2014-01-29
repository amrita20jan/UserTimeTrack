class SessionController < ApplicationController
  def new
  end

  def login
  	puts "_____________________________________"
  	 if @user=User.find_by_username(params[:username])
              session[:user_id] = @user.id
             a=Time.now.to_datetime.in_time_zone('Mumbai')
             if (10<=a.hour)&&(00==a.min)
				        puts " ______________________You Logged at right time  : #{a}" 
		         else
				        puts "___________________________ You Logged late  : #{a}"
		   	     end
		   	    @user.user_times.create(:arrival_time=>a)
            if @user.present? && @user.role=="admin"
             render layout: "admin"
       
            elsif @user.present? && @user.role=="employee"
           #format.html { redirect_to users_path, notice: ' Username does not Exist ' }            
          #redirect_to "/users"
            puts @user.username

            redirect_to user_path(@user)
            else
             redirect_to "/users",:notice=> "Improper Username OR Username does not exist"

            end 
    else
          redirect_to "/users",:notice=> "Improper Username OR Username does not exist"
    end

  end

  def logout
  	  session[:user_id]=nil
      redirect_to "/users"
  end
end
