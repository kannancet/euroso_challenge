module PricingCalculator
  extend ActiveSupport::Concern

	#Function to calculae pricing
	def calculate_pricing base_price
		send("#{pricing_policy.downcase}_pricing".to_sym, base_price)
	end

	#Flexible pricing calculator
	def flexible_pricing base_price
		neat_text = parse_and_sanitize(FLEXIBLE_SEARCH_SOURCE)
		margin = neat_text.count("a")/100
		final_price(margin, base_price)
	end

	#Function to parse and sanitize content
	def parse_and_sanitize(url)
		doc = nokogiri_parse(url)
		content = Sanitize.clean(doc, :remove_contents => ['script', 'style'])
		content.delete("\n").delete("\t")
	end

	#function to parse using nokogiri
	def nokogiri_parse(url)
		Nokogiri::HTML(open(url))
	end

	#Fixed pricing calculator
	def fixed_pricing base_price
		neat_text = parse_and_sanitize(FIXED_SEARCH_SOURCE)
		margin = neat_text.scan(/status/).size
		final_price(margin, base_price)
	end

	#function  to calcluate final price from margin
	def final_price(margin, base_price)
		(margin + base_price.to_f).round(2)
	end

	#Prestige pricing calculator
	def prestige_pricing base_price
		doc = nokogiri_parse(PRESTIGE_SEARCH_SOURCE)
		margin = doc.xpath("//pubdate").size
		final_price(margin, base_price)
	end

end