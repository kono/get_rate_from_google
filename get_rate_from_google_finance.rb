require 'open-uri'
require 'nokogiri'
require 'httpclient'

def get_data(url)
    client=HTTPClient.new
    response = client.get(url)

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(response.body, nil, "UTF-8")

    target_names = ['data-source','data-target','data-last-price','data-last-normal-market-timestamp']
    result = {}
    doc.xpath('//div').each do |node|
        temp_result = {}
        node.attribute_nodes.each do |att|
            if target_names.index(att.name)
                temp_result[att.name]=att.value
            end
        end
        if temp_result['data-last-price']
            result = temp_result.clone
        end
    end
    result
end

#######################  主処理
if __FILE__ == $0
    cur_ar = ['USD','MYR','VND','EUR','MXN']

    cur_ar.each do |cur|
        url = "https://www.google.com/finance/quote/#{cur}-JPY?hl=ja"
        p get_data(url)
    end

    # data-source="VND" data-target="JPY" data-last-price="0.0058783575339999995" data-last-normal-market-timestamp="1684546136"
end