require 'spec_helper'

describe Dyn::Messaging::Client do

  describe 'accounts()' do

    start_index = 40
    username = 'some-user-name'
    xheader1 = 'a'
    xheader2 = 'b'
    xheader3 = 'c'
    xheader4 = 'd'

    subject do
      dyn = Dyn::Messaging::Client.new(@default_api_key)
      dyn.accounts
    end

    it 'should list results with the default startindex' do
      stub = stub_request(:get, "#{@api_base_path}/accounts?apikey=#{@default_api_key}&startindex=0")
      subject.send(:list)
      expect(stub).to have_been_requested
    end

    it 'should list results with a specified start index' do
      stub = stub_request(:get, "#{@api_base_path}/accounts?apikey=#{@default_api_key}&startindex=#{start_index}")
      subject.send(:list, start_index)
      expect(stub).to have_been_requested
    end

    it 'should create account' do
      account_data = { 'username' => 'a', 'password' => 'b', 'companyname' => 'c', 'phone' => 'd', 'address' => 'e', 'city' => 'f', 'state' => 'g', 'zipcode' => 'h', 'country' => 'i', 'timezone' => 'j', 'bounceurl' => 'k', 'spamurl' => 'l', 'unsubscribeurl' => 'm', 'tracelinks' => 'n', 'trackunsubscribes' => 'o', 'generatenewapikey' => 'p' }

      stub = stub_request(:post, "#{@api_base_path}/accounts")
             .with(body: { 'apikey' => "#{@default_api_key}" }.merge(account_data))

      subject.send(:create, account_data['username'], account_data['password'], account_data['companyname'], account_data['phone'], account_data['address'], account_data['city'], account_data['state'], account_data['zipcode'], account_data['country'], account_data['timezone'], account_data['bounceurl'], account_data['spamurl'], account_data['unsubscribeurl'], account_data['tracelinks'], account_data['trackunsubscribes'], account_data['generatenewapikey'])

      expect(stub).to have_been_requested
    end

    it 'should destroy account with the given email address' do
      stub = stub_request(:post, "#{@api_base_path}/accounts/delete")
             .with(body: { 'apikey' => "#{@default_api_key}", 'username' => username })

      subject.send(:destroy, username)

      expect(stub).to have_been_requested
    end

    it 'should list xheaders' do
      stub = stub_request(:get, "#{@api_base_path}/accounts/xheaders?apikey=#{@default_api_key}")
      subject.send(:list_xheaders)
      expect(stub).to have_been_requested
    end

    it 'should update xheaders' do
      stub = stub_request(:post, "#{@api_base_path}/accounts/xheaders")
             .with(body: { 'apikey' => "#{@default_api_key}", 'xheader1' => xheader1, 'xheader2' => xheader2, 'xheader3' => xheader3, 'xheader4' => xheader4 })

      subject.send(:update_xheaders, xheader1, xheader2, xheader3, xheader4)

      expect(stub).to have_been_requested
    end

  end

end
