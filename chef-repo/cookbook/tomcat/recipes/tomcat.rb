service 'tomcat' do
  action :nothing
end

#Creating the directory hierarchy:

directory "#{node['tomcat']['home_dir']}" do
	recursive true
	owner "tomcat"
        group "tomcat"
	action :create
	mode 0755
end

directory "#{node['tomcat']['config_dir']}" do
	recursive true
	owner "tomcat"
	group "tomcat"
	action :create
	mode 0755
end

directory "#{node['tomcat']['log_dir']}" do
	recursive true
	owner "tomcat"
        group "tomcat"
	action :create
	mode 0755
end

remote_file '/tmp/apache-tomcat-7.0.62.tar.gz' do
  source node['tomcat']['package_url']
  action :create
  not_if { ::File.exist?('tmp/apache-tomcat-7.0.62.tar.gz') }
end

#tar_extract '/tmp/apache-tomcat-7.0.62.tar.gz' do
#	target_dir "#{node[':tomcat'][':home'][:dir]}"
#	action :extract_local
#end

extract_path = "#{node['tomcat']['home_dir']}"

bash 'extract_tomcat_tar' do
	code <<-EOH
		mkdir /tmp/temp
		tar -zxvf /tmp/apache-tomcat-7.0.62.tar.gz -C /tmp/temp/
		mv /tmp/temp/*/* #{extract_path}
		rm -rf /tmp/temp
	EOH
end

#Startup Script Part:
template "/etc/init.d/tomcat" do
  source "tomcat_init.erb"
  mode  744
  action :create
end

#Tomcat configuration comes here:
template "#{node['tomcat']['config_dir']}/server.xml" do
  source 'server.xml.erb'
  action :create
  notifies :restart, 'service[tomcat]', :delayed
end

#Service part:
service "tomcat" do
  supports :status => :true, :restart => :true, :reload => :true
  action [ :enable ]
end

