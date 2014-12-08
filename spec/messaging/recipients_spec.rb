require 'spec_helper'

describe Dyn::Messaging::Client do

  describe 'recipients()' do
    emailaddress = 'abc@foobar.com'

    subject { @dyn.recipients }

    it 'should retrieve the status of an email address' do

      stub = stub_request(:get, "#{@api_base_path}/recipients/status?apikey=#{@default_api_key}&emailaddress=#{emailaddress}")

      subject.send(:status, emailaddress)

      expect(stub).to have_been_requested
    end

    it 'should activate an email address' do
      stub = stub_request(:post, "#{@api_base_path}/recipients/activate")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress })

      subject.send(:activate, emailaddress)

      expect(stub).to have_been_requested
    end
  end

end
