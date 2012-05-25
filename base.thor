require 'net/ssh'
require 'net/sftp'
require 'csv'
require 'Thor'
class Base < Thor
  desc "fetch File", "get file from sftp"
  
  def fetch(file)
  	Net::SFTP.start('www.aaronheld.com', 'aarontest', :password => 'PASSWORD') do |sftp|
    	sftp.download!(file, file)
    end
  end

  desc "calidate_row ROW", "validate a row of data"
  def validate_row(row)
  	row
  end

  desc "transform_and_validate FILE", "validate and convert"
  def transform_and_validate(file)
	#open destination file
	CSV.open("cleaned#{file}", "wb") do |csv|
  		#open source file
  		CSV.foreach(file) do |row|
			csv << validate_row(row)  		
  		end
	end
  end

  desc "doit FILE", "download validate and xform data"
  def doit(file)
  	fetch(file)
  	transform_and_validate(file)
  end

end