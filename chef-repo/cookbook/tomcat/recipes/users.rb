user 'tomcat' do
	action :create
	comment "Tomcat user"
	#home "#{node[':tomcat'][':home'][':dir']}"
	home '/secondary/users/appuser'
	shell "/bin/bash"
end

group 'tomcat' do
	action :modify
	members 'tomcat'
	append true
end

directory node[:tomcat][:home][:dir] do
	owner "tomcat"
	group "tomcat"
	mode 00755
	action :create
end

