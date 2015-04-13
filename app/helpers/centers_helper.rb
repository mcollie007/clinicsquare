module CentersHelper

	def self.name_format(str)

		if str && str.length > 40 
			str[0..38].gsub(/\s\w+\s*$/,'...')
		else
			str
		end
	end

	def name_format(str)
		CentersHelper.name_format(str)
	end

	def self.web_format(str)
		if str && str.length > 50
			str[0..50].gsub(/\s\w+\s*$/,'...')
		else
			str
		end
	end

	def web_format(str)
		CentersHelper.web_format(str)
	end

	def self.zipcode_format(str)
		if (str)
			zip = str.split("-")
			return zip[0]
		else
			str = "N/A"
			return str
		end
	end

	def zipcode_format(str)
		CentersHelper.zipcode_format(str)
	end

	def self.title_format(str)
		str.sub(/\S/, &:upcase)
	end

	def title_format(str)
		CentersHelper.title_format(str)
	end

	def self.link_format(str)
		if(str)
			if str[0..6] != "http://"
				"http://"+str
			else
				str
			end
		end
	end

	def link_format(str)
		rCentersHelper.link_format(str)
	end

	def self.state_array
		state_arr = ["States","AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID", "IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY", "OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]
	end

	def state_array
		CentersHelper.state_array
	end
         
	def self.url_present
		url_array = [nil, "" , "unkn", "na", "n/a", "none", "NA", "N/A" ]
	end

	def url_present
		CentersHelper.url_present
	end


end
