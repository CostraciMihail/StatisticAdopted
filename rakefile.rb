#tasks for StatisticAdopted project

require 'fileutils'

task :make_commit_push do 

sh %{ clear }
puts "\nmake_commit_and_push in progress ..."
sh %{
git add -A
git commit -m "Automatic commit"
git push 
}  

puts "\nmake_commit_and_push completed \n"
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
