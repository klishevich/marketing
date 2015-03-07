#encoding: utf-8
require 'open-uri'
class Request < ActiveRecord::Base

  def self.parse
  	batch, batch_size = [], 1_000 
  	base_url = 'http://www.cbr.ru/credit/102.asp?when=0&dt=20150101&regnum='

	(1..10).each do |ii| 	
		# url = 'http://www.cbr.ru/credit/102.asp?regnum=2209&when=0&dt=20150101'
		url = base_url + ii.to_s
		doc = Nokogiri::HTML(open(url)) rescue nil
		next unless doc
		table0 = doc.xpath('//table[@class="nodata"]').first
		bank_name = table0.xpath('tr/td')[1].children.to_s.encode('UTF-8')
		table = doc.xpath('//table[@class="data lined"]').first
		rows = table.xpath('tr')
		rows.each do |row|
			tds = row.xpath('td')
			if !tds[2].nil?
				code = tds[2].children.to_s
				if !code.blank? && code!='3'
					name = tds[1].children.to_s.encode('UTF-8')
					rub = tds[3].children.to_s.gsub(/\s+/, "")
					foreign = tds[4].children.to_s.gsub(/\s+/, "")
					total = tds[5].children.to_s.gsub(/\s+/, "")		
					# name = "name" 
					# code = "code"
					# rub = 100
					# foreign = 200
					# total = 300				
					batch << Request.new(result: bank_name, bank: ii, p_name: name, p_code: code, p_sum_rub: rub,
						p_sum_foreign: foreign, p_sum_total: total)
					if batch.size >= batch_size
					    Request.import batch
					    batch = []
					end
				end
			end		
		end

		# Rails.logger.info("!!!result: #{name},#{code},#{rub},#{foreign},#{total}")
		# self.bank = 1
		# self.p_name = name.encode('UTF-8')
		# self.p_code = code
		# self.p_sum_rub = rub
		# self.p_sum_foreign = foreign
		# self.p_sum_total = total

		Request.import batch
		batch = []

	end

  end

end
