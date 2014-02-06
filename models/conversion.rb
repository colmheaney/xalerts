# encoding: UTF-8

class Conversion
	def initialize(symbol, rate, date, time)
		@symbol = symbol.gsub("=X", '')
		@rate = rate.to_f
		@time = time
		@date = date
	end
	def rate
		return @rate
	end
	def symbol
		return @symbol
	end
	def time
		return @time
	end
	def date
		return @date
	end		
end