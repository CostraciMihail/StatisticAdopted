#tasks for StatisticAdopted project

require 'fileutils'

task :make_commit_and_push do 

sh %{ clear }

puts "\n***************************"
puts "\nmake_commit_and_push in progress ..."

sh %{echo "shell is executing" 
echo "is still executing"	}  

puts "\nmake_commit_and_push completed \n"
puts "\n *************************** \n"
end



task :script_example do
sh %{ clear }
puts "script_example executing ..."

sh %{ 
	  var_n=`expr 12 + 20` 
	   echo "Total var_n =$var_n"
	}


puts "script_example completed"

end
