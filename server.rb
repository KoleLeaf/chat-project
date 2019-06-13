require "sinatra"
require 'csv'


def array_of_messages
  messages = []
  CSV.foreach('messages_list.csv', headers: true) do |row|
    messages << [row["message"]]
  end

messages
end

get '/' do
  redirect '/homepage'
end

get '/homepage' do
  erb :homepage
end

get '/chat' do
    @messages = array_of_messages
    erb :chat
end

get '/people' do
@url = params[:grocery]

erb :people
end

post '/chat' do


  @message = params[:Message]
  if @message != ""
    CSV.open('messages_list.csv', 'a') do |line|
      line << [@message]
    end
    redirect '/chat'
  else
    @error = "error - you must submit a message"
    erb :chat

  end


end
