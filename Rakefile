require 'dm-migrations'

desc "List all routes for this application"
task :routes do
  puts `grep '^[get|post|put|delete].*do$' routes/*.rb | sed 's/ do$//'`
end

namespace :db do
	desc "auto migrates the database"
	task :migrate do
	  require './main'
	  DataMapper.auto_migrate!
	end

	desc "auto upgrades the database"
	task :upgrade do
	  require './main'
	  DataMapper.auto_upgrade! 
	end

	desc "auto populates currencies"
	task :populate_currencies do
		require 'csv'
		require './main'
		Currency.all.destroy
		CSV.foreach("./currencies.csv") do |row|
		  Currency.create(symbol: row[0])
		end	
	end
end

namespace :emails do
	desc "send out alerts"
	task :send do
		require './main'
		include Sinatra::AlertHelpers
		get_alerts
	end
end
