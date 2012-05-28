require 'rspec'
require './base_fetcher.rb'

describe BaseFetcher do
	it "should login to ftp server" do
	  sftp = mock('SFtp server').as_null_object
	  Net::SFTP.should_receive(:start).with('www.rspect-test-domain.com', 
	  							'rspec_username', 
	  							:password => 'rspec_password').and_yield(sftp)
	  sftp.should_receive(:download!).with("test.csv", "test.csv")

	  b = BaseFetcher.new '{"fetch_url":"sftp://www.rspect-test-domain.com/",
	  			"user_name":"rspec_username",
	  			"password" :"rspec_password",
	  			"filename":"test.csv"}'
	  b.fetch
	end
end