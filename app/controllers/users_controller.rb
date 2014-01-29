require 'gchart'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate :page=>params[:page],:per_page=>2
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user=current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def analytics
    @average_time= avg(UserTime.all.where("date(arrival_time)=?",DateTime.now.to_date).map{|e|e.arrival_time.in_time_zone('Mumbai').strftime("%H:%M")})
    @all_user_max_arrival_time=max_arrival_time(UserTime.all.where("date(arrival_time)=?",DateTime.now.to_date).map{|e|e.arrival_time.in_time_zone('Mumbai').strftime("%H")})
    @image_url=Gchart.line(:data => UserTime.all.where("date(arrival_time)=?",DateTime.now.to_date).map{|e|e.arrival_time.in_time_zone('Mumbai').strftime("%H:%M").to_i})


  end

   # def avg_times(var)
   #   puts "#{var}"
   #    begin
   #     grand_total=0
   #     size=var.size 
   #      puts "size #{size}"
   #     avg_minutes=var.map do|x| 
   #     hour,minute=x.split(':')
   #      puts "size1"

   #      total_minutes=hour.to_i*60+minute.to_i 
   #       puts "total_minutes #{total_minutes}"
   #      grand_total=grand_total+total_minutes
   #     end
   #        puts "avg_minutes #{avg_minutes}"
   #        puts "grand_total #{grand_total}"
   #        avg_value=grand_total/size
          
   #        average_time=avg_value.to_f/60
   #        #puts "average #{average_time}"
   #        #return average_time
   #       rescue Exception => e
   #         redirect_to "/users",:notice=> "No User Arrived Yet"
   #          #raise  ZeroDivisionError, "I am raising this exception"
   #       end 
   #  end
   
   def each_user_analytics
     @user=User.find(params[:id])
     #puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#{@user.id}"
     #puts "----------#{@each_user}"
     #return @each_user
     @each_user_average=avg(@user.user_times.map{|c|c.arrival_time.in_time_zone("Mumbai").strftime("%H:%M")})
     @user_max_arrival_time=max_arrival_time(@user.user_times.map{|c|c.arrival_time.in_time_zone("Mumbai").strftime("%H")})
     @image_url=Gchart.pie_3d(:data => @user.user_times.map{|c|c.arrival_time.in_time_zone("Mumbai").strftime("%H").to_i})

   end

   
   def max_arrival_time(var)
      freq=var.inject(Hash.new(0)){|h,v| h[v]+=1;h}
      var.sort_by{|v|freq[v]}.last           
   
   end

   def statistics
      #@user=User.find(params[:id])
      @users = User.all

      #@user=User.find(params[:id])
      # @res=@users.map do|user|
      #     @avg_state=avg_times(user.user_times.map{|e|e.arrival_time.in_time_zone("Mumbai").strftime("%H:%M")})
      #     a={user:user,time: @avg_state}
      # end  
   end
       
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :role)
    end
end
