require 'spec_helper'

describe Dyn::Messaging::Client do

  describe 'recipients()' do

    start_index = 40
    emailaddress = 'my-sender@foobar.com'
    seeding = 1
    dkim = '[identifier]._domainkey.[senderdomain]'

    subject { @dyn.senders }

    it 'should list results with the default startindex' do
      stub = stub_request(:get, "#{@api_base_path}/senders?apikey=#{@default_api_key}&startindex=0")
      subject.send(:list)
      expect(stub).to have_been_requested
    end

    it 'should list results with a specified start index' do
      stub = stub_request(:get, "#{@api_base_path}/senders?apikey=#{@default_api_key}&startindex=#{start_index}")
      subject.send(:list, start_index)
      expect(stub).to have_been_requested
    end

    it 'should create sender with default seeding' do
      stub = stub_request(:post, "#{@api_base_path}/senders")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress, 'seeding' => '0' })

      subject.send(:create, emailaddress)

      expect(stub).to have_been_requested
    end

    it 'should create sender with specified seeding' do
      stub = stub_request(:post, "#{@api_base_path}/senders")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress, 'seeding' => "#{seeding}" })

      subject.send(:create, emailaddress, seeding)

      expect(stub).to have_been_requested
    end

    it 'should update sender with default seeding' do
      stub = stub_request(:post, "#{@api_base_path}/senders")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress, 'seeding' => '0' })

      subject.send(:update, emailaddress)

      expect(stub).to have_been_requested
    end

    it 'should update sender with specified seeding' do
      stub = stub_request(:post, "#{@api_base_path}/senders")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress, 'seeding' => "#{seeding}" })

      subject.send(:update, emailaddress, seeding)

      expect(stub).to have_been_requested
    end

    it 'should destroy sender with the given email address' do
      stub = stub_request(:post, "#{@api_base_path}/senders/delete")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress })

      subject.send(:destroy, emailaddress)

      expect(stub).to have_been_requested
    end

    it 'should get details' do
      stub = stub_request(:get, "#{@api_base_path}/senders/details?apikey=#{@default_api_key}&emailaddress=#{emailaddress}")
      subject.send(:details, emailaddress)
      expect(stub).to have_been_requested
    end

    it 'should get status' do
      stub = stub_request(:get, "#{@api_base_path}/senders/status?apikey=#{@default_api_key}&emailaddress=#{emailaddress}")
      subject.send(:status, emailaddress)
      expect(stub).to have_been_requested
    end

    it 'should set the dkim for the given email address' do
      stub = stub_request(:post, "#{@api_base_path}/senders/dkim")
             .with(body: { 'apikey' => "#{@default_api_key}", 'emailaddress' => emailaddress, 'dkim' => dkim })

      subject.send(:dkim, emailaddress, dkim)

      expect(stub).to have_been_requested
    end

  end

end
