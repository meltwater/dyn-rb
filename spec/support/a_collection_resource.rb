shared_examples 'a collection' do |call_path|
  start_time = 1
  end_time = 2
  start_index = 40

  it 'should be countable' do
    stub = stub_request(:get, "#{@api_base_path}/#{call_path}/count?apikey=#{@default_api_key}&starttime=#{start_time}&endtime=#{end_time}")
    subject.send(:count, start_time, end_time)
    expect(stub).to have_been_requested
  end

  it 'should list results for a date range with the default startindex' do
    stub = stub_request(:get, "#{@api_base_path}/#{call_path}?apikey=#{@default_api_key}&starttime=#{start_time}&endtime=#{end_time}&startindex=0")
    subject.send(:list, start_time, end_time)
    expect(stub).to have_been_requested
  end

  it 'should list results for a date range with a specified start index' do
    stub = stub_request(:get, "#{@api_base_path}/#{call_path}?apikey=#{@default_api_key}&starttime=#{start_time}&endtime=#{end_time}&startindex=#{start_index}")
    subject.send(:list, start_time, end_time, start_index)
    expect(stub).to have_been_requested
  end

end
