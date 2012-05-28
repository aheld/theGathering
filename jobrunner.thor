require './base_fetcher'
require 'Thor'

class Jobrunner < Thor

  desc "fetch sftp JSON",%q(download a file using a config passed in via json

  $ bundle exec thor jobrunner:fetch_sftp '{"fetch_url":"sftp://www.domain.com/","user_name":"username","password" :"password","filename":"filename"}'
   )

  def fetch_sftp(config)
    b = BaseFetcher.new config
    b.fetch
  end

end