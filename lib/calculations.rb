module Calculations
	
	 def avg(var)
     puts "#{var}"
      begin
       grand_total=0
       size=var.size 
        puts "size #{size}"
       avg_minutes=var.map do|x| 
       hour,minute=x.split(':')
        puts "size1"

        total_minutes=hour.to_i*60+minute.to_i 
         puts "total_minutes #{total_minutes}"
        grand_total=grand_total+total_minutes
       end
          puts "avg_minutes #{avg_minutes}"
          puts "grand_total #{grand_total}"
          avg_value=grand_total/size
          
          average_time=avg_value.to_f/60
          #puts "average #{average_time}"
          #return average_time
         rescue Exception => e
           redirect_to "/users",:notice=> "No User Arrived Yet"
            #raise  ZeroDivisionError, "I am raising this exception"
         end 
    end
end		

