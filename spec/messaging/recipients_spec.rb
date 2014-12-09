require 'spec_helper'

describe Dyn::Messaging::Client do

  describe 'recipients()' do
    email_address = 'abc@foobar.com'
    email_address_2 = 'another@foobar.com'
    email_addresses_string = email_address + ', ' + email_address_2
    email_addresses_array = [email_address, email_address_2]

    subject { @dyn.recipients }

    it 'should retrieve the status of an email address' do

      stub = stub_request(:get, "#{@api_base_path}/recipients/status?apikey=#{@default_api_key}&emailaddress=#{email_address}")

      subject.send(:status, email_address)

      expect(stub).to have_been_requested
    end

    it 'should retrieve the status of an list of email addresses' do

      stub = stub_request(:get, "#{@api_base_path}/recipients/status?apikey=#{@default_api_key}&emailaddress=#{email_addresses_string}")

      subject.send(:statuses, email_addresses_array)

      expect(stub).to have_been_requested
    end

    it 'should activate an email address' do
      stub = stub_request(:post, "#{@api_base_path}/recipients/activate")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => email_address })

      subject.send(:activate, email_address)

      expect(stub).to have_been_requested
    end
  end

end
