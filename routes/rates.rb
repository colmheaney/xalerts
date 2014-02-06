# encoding: UTF-8

get '/' do
  @currencies = Currency.all
  erb :home
end

post '/' do
  @conversion = get_response_with_redirect(params[:currency_from] + params[:currency_to])
  erb :current_rate
end

post '/alert' do
  @alert = Alert.create(:current_rate => params[:current_rate], :upper_rate => params[:upper_rate], 
                    :lower_rate => params[:lower_rate], :email => params[:email], 
                    :symbol => params[:symbol],
                    :created_at => Time.now, :updated_at => Time.now)
  redirect '/'
end

