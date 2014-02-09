# encoding: UTF-8

require 'sinatra/base'
require 'pony'
include Sinatra::ResponseWithRedirect

module Sinatra
  module AlertHelpers
		def get_alerts()
			conversion_symbols = Alert.all(:fields => [:symbol], :unique => true)

			array = Array.new
			conversion_symbols.each do |c|
				array << c.symbol
			end

			conversions = get_response_with_redirect(array)
			alerts = Alert.all

			conversions.each do |conversion|
				alerts.each do |alert|
					if conversion.symbol == alert.symbol
						if conversion.rate > alert.upper_rate || conversion.rate < alert.lower_rate
							send_mail(alert, conversion)
							Alert.get(alert.id).destroy
						end
					end
				end
			end
		end

		def send_mail(alert, conversion)
			body = "You requested an alert when the #{conversion.symbol} changed.\nThe rate is currently #{conversion.rate}\nTo set an new alert visit http://xalerts.colmheaney.com"
			Pony.mail({
				:from => 'root@pc.home',
				:to => alert.email,
				:subject =>'DO-NOT-REPLY: xAlert Service',
				:body => body,
				:via => :sendmail
			})		
		end
	end
end