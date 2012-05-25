require 'rspec'
load 'base.thor'

describe Base do
	it "should login to ftp server" do
	  sftp = mock('SFtp server').as_null_object
	  Net::SFTP.should_receive(:start).with('www.aaronheld.com', 'aarontest', :password => 'PASSWORD').and_yield(sftp)
	  sftp.should_receive(:download!).with("test.csv", "test.csv")

	  b = Base.new
	  b.fetch('test.csv')
	end
end