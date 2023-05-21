require_relative './test_helper'
require 'get_rate_from_google_finance'


class CheckOndemandWeb_test < Test::Unit::TestCase
    test "it can test" do
        assert true
    end

    test "it can get data" do
        test_url = "https://www.google.com/finance/quote/VND-JPY?hl=ja"
        obj = Object.new   # HTTPClientのmock
        obj2 = Object.new  # HTTPClientでgetしたresponseのmock
        stub(HTTPClient).new{obj}
        stub(obj).get(test_url){obj2}
        stub(obj2).body{File.read("#{File.dirname(__FILE__)}/testinput.html")}
        result = get_data(test_url)
        assert_equal result, {"data-source"=>"VND", "data-target"=>"JPY", "data-last-price"=>"0.0058783575339999995", 
                 "data-last-normal-market-timestamp"=>"1684546136"}
    end

    # test "it can check timestamp and return false" do
    #     obj = Object.new
    #     stub(Time).now{Time.new(2023,05,13,20,00,00)}
    #     stub(File::Stat).new('./check_ondemand_web.check'){obj}
    #     stub(obj).mtime{Time.new(2023,05,13,20,00,00)}
    #     stub(File).exist?('./check_ondemand_web.check'){true}
    #     assert_false check_file_timestamp
    # end
end
