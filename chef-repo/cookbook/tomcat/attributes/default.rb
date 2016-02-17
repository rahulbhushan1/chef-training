#pankaj explore
 default['tomcat'].tap do | tomcat |
		#Installation Location Settings goes here:
		tomcat['home_dir'] = '/opt/softwares/tomcat'
		tomcat['log_dir'] = '/opt/softwares/logs'
		tomcat['config_dir'] = '/opt/softwares/conf'
		
		#Port Settings goes here:
		tomcat['port'] = 8080
		tomcat['proxy_port'] = nil
		tomcat['redirect_port'] = 8443
		tomcat['ssl_proxy_port'] = nil
		tomcat['ajp_port'] = 8009
		tomcat['shutdown_port'] = 8005
		tomcat['java_options'] = nil #Can be replaced depending on requirements

		#Grabbing the tarball from location
		tomcat['package_dir'] = 'tomcat-installer'
		tomcat['package_url'] = 'http://a.mbbsindia.com/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz'

end
