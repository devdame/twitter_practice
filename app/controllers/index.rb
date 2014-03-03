get '/' do
  # Look in app/views/index.erb
  erb :index
end


get '/:username' do
  @user = params[:username]
  @timeline = $client.user_timeline(@user).take(10)
  erb :username
end

#!/usr/bin/env ruby
