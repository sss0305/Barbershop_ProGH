#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3",database: "barbershop.db"}
# "sqlite3:barbershop.db"

# создаем сущность
class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
	validates :name, presence: true
end

class Contact < ActiveRecord::Base
	validates :username, presence: true
	validates :email, presence: true
	validates :text, presence: true
end


before do
	@barbers = Barber.all
end


get '/' do
	# @barbers = Barber.all

	@barbers = Barber.order "created_at ASC"
	 erb :index
end

get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do
	# @username =	params[:username]
	# @phone =	params[:phone]
	# @date =		params[:date]
	# @barber =	params[:barber]
	# @color =	params[:color]


	# Client.create :name => "#{@username}", :phone => "#{@phone}", :datestamp => "#{@date}", :barber => "#{@barber}", :color => "#{@color}"
	#lame method

	@c = Client.new params[:clientabc]
	if @c.save
		erb "Thanks, <%= @c.name %>. Barber <%= @c.barber %> will be waiting for you on <%= @c.datestamp %>. " 
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end

end

get '/contacts' do
	@cont = Contact.new
	erb :contacts
end

post '/contacts' do
	# @username = params[:username]
	# @email = params[:email]
	# @text = params[:text]

	# Contact.create :username => "#{@username}", :email => "#{@email}", :text => "#{@text}"
	# erb  "Thanks, #{@username}!"

	@cont = Contact.new params[:contactabc]
	if @cont.save
		erb 'OK'
	else
		@error = @cont.errors.full_messages.first
		erb :contacts
	end
end

get '/admin' do
	@b = Barber.new
	erb :admin	
end


post '/admin' do
	@b = Barber.new params[:barberabc]
	if @b.save
		erb "Thanks, barber <%= @b.name %> is added."
	else
		@error = @b.errors.full_messages.first
		erb :admin
	end
end
