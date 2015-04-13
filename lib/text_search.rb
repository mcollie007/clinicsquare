class TextSearch
	require 'redis'

	def initialize(text, from_number, command, loc)
		@text = text
		@user_number = from_number
		@command = command
		@location = loc
		
		@service_number = "+19545555454" #+19542660026"
		@help_message = 'Service Commands:  CLINIC and ASSIST. Commands use: 
		CLINIC@zip_code and ASSIST lists service commands.' 
	end

	def search
		
		case @command
		when 'CLINIC', 'clinic', 'Clinic'
			
			@search = Center.search(search_params)
			@search.sorts = 'zip_code asc' if @search.sorts.empty?
			
			data = @search.result(distinct: true)
			
			total = data.count
			
			@user = find_user
			if @user.update(data: data, total: total)
				results_clear(@user)
				results_pages(data, @user)
				@search = text_page( @user, total, 3)
			end
		when 'MORE', 'More', 'more'
			 
			@user = find_user
			if @user 
				data = @user.data
				
				total = @user.total
				
				@search = text_page( @user, total, 3)
			end
		when 'ASSIST', 'assist', 'Assist'
			#send help info to user
			
			@search = sendTwilo(@help_message)
		when 'CLEAR', 'clear', 'Clear'
			@user = find_user
			if @user
<<<<<<< HEAD
				results_clear(@user)	
=======
				results_clear(@user)
				#Rails.logger.debug("CLEARED list")
>>>>>>> parent of 62ab367... cleaning files
			end
		else
			#send help info to user
			@search = sendTwilo("Service Commands are: ASSIST and CLINIC")
			
		end

	end

	def search_params
		
		#params = @location
		params = {"zip_code_cont" => @location }
	
	end

	def text_page(user, total, amount)

		list_size = results_amount(user)
		
		if list_size < amount 
			amount = list_size
		else
			sendTwilo("#{list_size} search results found. Text MORE to receive added results.")
		end
		
		#@user = find_user
		for i in 0...amount
			data_id = results_page(user)
			data = find_data(data_id[1].to_i)
		    message = message_generator(data)
			sendTwilo(message)
			
		end

		
		
=begin
			data.each do |msg|
				message = message_generator(msg)
			##Rails.logger.debug(message)
				send(message)
			end
=end
	end

	
	def sendTwilo(msge)
	    @client = Twilio::REST::Client.new ENV['PRO_SID'], ENV['PRO_TOKEN']
 
        message = @client.account.messages.create(:body => msge,
            :to => @user_number,     # Replace with your phone number
            :from => @service_number)   # Replace with your Twilio number
        puts message.sid
	end

	def send(message)
		#p = RestApi.new(ENV['AUTH_ID'], ENV['AUTH_TOKEN'])

		params = {
			'src' => @service_number,
			'dst' => @user_number,
			'text' => message,
			'type' => 'sms',
			'url' => 'http://webservice.com/status',
			'method' => 'POST'
		}

		#response = p.send_message(params)
		#Rails.logger.debug(params)

		#uuid = response[1]['message_uuid'][0]

		#params1 = {
		#	'record_id' => uuid
		#}

		return params
		#response = p.get_message(params1) #save to log db

	end

	def find_user
		User.find_by(phone: @user_number) 
	end

	def find_data(id)
		Center.find(id)
	end

	private

		def user_params
			params.require(:user).permit(:phone, :query, :data, :total)
		end

	protected 

		def message_generator(data)
			"#{data.site_name}, Phone: #{data.phone_number}, Fax: #{data.fax_number} Mgmt: #{data.admin_number}; Address: #{data.address} #{data.city}, #{data.state}, #{data.zip_code}, #{data.county_name}."
		end

		def page_generator(total)
			if total %4 == 0
				total / 4 
			
			elsif total %3 == 0
				total / 3

			else 
				total / 2
			end
		end
#=begin
		def results_pages(data, user)
			for i in 0...data.length do
				$redis.rpush("page:#{user.id}", data[i].id)
			end
		end

		def results_page(user)
			$redis.blpop("page:#{user.id}", 30)
		end

		def results_amount(user)
			$redis.llen("page:#{user.id}")
		end

		def results_clear(user)
			$redis.ltrim("page:#{user.id}", 1, 0)
		end
#=end

end