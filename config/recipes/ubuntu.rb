namespace :ubuntu do
   desc "Setup Environment"
   task :setup_env, :roles => :app do
      update_apt_get
      install_dev_tools
      install_git
      #install_subversion
      #install_sqlite3
      # Install and setup RVM instead of old Rails stack
      #install_rails_stack
      setup_rvm
      #install_apache
      # This is now done in RVM setup
      #install_passenger
      #config_passenger
      #install_imagemagick
      #install_mysql
      #install_mysql_bindings
      install_postgres
      #install_dos2unix
   end
   
   desc "Setup RVM environment with Rails"
   task :setup_rvm, :roles => :app do
     install_rvm
     install_rvm_ruby
     install_rvm_passenger
     install_rvm_rails
   end
   
   # Forces a quiet install for particularly annoying packages requiring complex input
   def apt_quiet_install(*packages)
     apt_get = "DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get"
     sudo "#{apt_get} -qyu --force-yes install #{packages}"
   end
   
   desc "Update apt-get sources"
   task :update_apt_get, :roles => :app do
     run "#{sudo} apt-get update"
   end

   desc "Install and setup RVM"
   task :install_rvm, :roles => :app do
     # https://github.com/wayneeseguin/rvm/raw/master/contrib/install-system-wide
     sudo "bash < <( curl -L -k http://bit.ly/rvm-install-system-wide )", :shell => false
     puts <<-EOS
Put this at the end of ~/.bashrc:
[[ -s "/usr/local/lib/rvm" ]] && . "/usr/local/lib/rvm"  # This loads RVM into a shell session.
     EOS
     run "source /usr/local/lib/rvm", :shell => false
     sudo "adduser #{user} rvm"
   end

   desc "Install RVM ruby and set as default"
   task :install_rvm_ruby, :roles => :app do
     sudo "rvm install 1.8.7"
     sudo "rvm --default use 1.8.7"
   end

   desc "Install and setup RVM Passenger"
   task :install_rvm_passenger, :roles => :app do
     set :default_environment, {
       'PATH' => "/usr/local/rvm/gems/ruby-1.8.7-p302/bin:/usr/local/rvm/gems/ruby-1.8.7-p302@global/bin:/usr/local/rvm/rubies/ruby-1.8.7-p302/bin:/usr/local/rvm/bin:/usr/local/bin:/usr/bin:/bin",
       'RUBY_VERSION' => 'ruby 1.8.7',
       'GEM_HOME'     => '/usr/local/rvm/gems/ruby-1.8.7-p302',
       'GEM_PATH'     => '/usr/local/rvm/gems/ruby-1.8.7-p302'#,
       #'BUNDLE_PATH'  => '/home/deploy/.rvm/gems/ruby-1.8.7-p302@leadnuke'  # If you are using bundler.
     }

     run "rvm 1.8.7 --passenger"
     run "rvm 1.8.7"
     run "rvmsudo gem install passenger -v=2.2.15 --no-ri --no-rdoc" do |ch, stream, out|
       print out
       ch.send_data "#{user_passphrase}\n" if out =~ /password for #{user}:/
     end

     input = ''
     run "rvmsudo passenger-install-apache2-module" do |ch,stream,out|
       next if out.chomp == input.chomp || out.chomp == ''
       print out
       ch.send_data(input = $stdin.gets) if out =~ /(Enter|ENTER)/
     end
     puts <<-EOS
replace PassengerRuby in passenger conf with:
PassengerRuby /usr/local/rvm/bin/passenger_ruby
     EOS
   end

   desc "Install RVM Rails"
   task :install_rvm_rails, :roles => :app do
     #require 'rvm/capistrano'
     #set :rvm_ruby_string, 'some-ruby' # Defaults to 'default'
     run "gem install -v=2.3.9 rails"
   end

   desc "Install Development Tools"
   task :install_dev_tools, :roles => :app do
     sudo "apt-get install build-essential -y"
   end
   
   desc "Install Git"
   task :install_git, :roles => :app do
     sudo "apt-get install git-core git-svn -y"
   end
   
   desc "Install Subversion"
   task :install_subversion, :roles => :app do
     sudo "apt-get install subversion -y"
   end
   
   desc "Install MySQL"
   task :install_mysql, :roles => :app do
     apt_quiet_install('mysql-server libmysql-ruby')
     #sudo "apt-get install mysql-server libmysql-ruby -y"
   end
   
   desc "Install PostgreSQL"
   task :install_postgres, :roles => :app do
     sudo "apt-get install postgresql libpgsql-ruby -y"
   end
   
   desc "Install SQLite3"
   task :install_sqlite3, :roles => :app do
     sudo "apt-get install sqlite3 libsqlite3-ruby -y"
   end
   
   desc "Install Ruby, Gems, and Rails"
   task :install_rails_stack, :roles => :app do
     [ "sudo apt-get install ruby ruby1.8-dev irb ri rdoc libopenssl-ruby1.8 -y",
       "mkdir -p src",
       "cd src",
       "wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz",
       "tar xzvf rubygems-1.3.1.tgz",
       "cd rubygems-1.3.1/ && sudo ruby setup.rb",
       "sudo ln -s /usr/bin/gem1.8 /usr/bin/gem",
       "sudo gem update --system",
       "sudo gem install rails --no-ri --no-rdoc"
     ].each {|cmd| run cmd}
   end
   
   desc "Install MySQL Rails Bindings"
   task :install_mysql_bindings, :roles => :app do
     apt_quiet_install('libmysql-ruby1.8 libmysqlclient15-dev')
     #sudo "aptitude install libmysql-ruby1.8 libmysqlclient15-dev -y"
   end
   
   desc "Install ImageMagick"
   task :install_imagemagick, :roles => :app do
     sudo "apt-get install libxml2-dev libmagick9-dev imagemagick -y"
     #sudo "gem install rmagick"
   end
   
   desc "Install Apache"
   task :install_apache, :roles => :app do
     sudo "apt-get install apache2 apache2.2-common apache2-mpm-prefork
           apache2-utils libexpat1 apache2-prefork-dev libapr1-dev -y"
     sudo "chown :sudo /var/www"
     sudo "chmod g+w /var/www"
   end
   
   desc "Install Passenger"
   task :install_passenger, :roles => :app do
     run "sudo gem install passenger --no-ri --no-rdoc"
     input = ''
     run "sudo passenger-install-apache2-module" do |ch,stream,out|
       next if out.chomp == input.chomp || out.chomp == ''
       print out
       ch.send_data(input = $stdin.gets) if out =~ /(Enter|ENTER)/
     end
   end
   
   desc "Configure Passenger"
   task :config_passenger, :roles => :app do
     passenger_config =<<-EOF
 LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-2.2.4/ext/apache2/mod_passenger.so
 PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-2.2.4
 PassengerRuby /usr/bin/ruby1.8    
     EOF
     put passenger_config, "src/passenger"
     sudo "mv src/passenger /etc/apache2/conf.d/passenger"
   end
   
   desc "Install dos2unix"
   task :install_dos2unix, :roles => :app do
     sudo "aptitude install tofrodos"
   end
   
end