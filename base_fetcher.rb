require 'net/ssh'
require 'net/sftp'
require 'uri'
require 'csv'
require 'json'

class BaseFetcher

  def initialize(config)
    @raw_config = config
    @config = JSON.parse config
    uri = URI(@config['fetch_url'])
    @host = uri.host
  end

  def fetch
    Net::SFTP.start(@host, @config['user_name'], :password => @config['password']) do |sftp|
    	sftp.download!(@config['filename'],@config['filename'])
    end
  end

  def validate_row(row)
  	row
  end

  def transform_and_validate(file)
  	#open destination file
	  CSV.open("cleaned#{file}", "wb") do |csv|
  		#open source file
  		CSV.foreach(file) do |row|
			csv << validate_row(row)  		
  		end
	  end
  end

  def doit(file)
  	fetch(file)
  	transform_and_validate(file)
  end

end