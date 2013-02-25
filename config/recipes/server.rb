namespace :essentials
  desc "Install server essentials"

  
end

namespace :postgres
  desc "Install PostgreSQL"
  task :install, :roles => :db do
    "#{sudo} apt-get install postgresql libpgsql-ruby -y"
  end
  
  desc :install_client, :roles => :app do
    
  end  
end   