class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks
    
    def self.find_by_sticker(sticker_symbol)
      where(sticker: sticker_symbol).first  
    end
    
   def self.new_from_lookup(sticker_symbol)
    begin
      looked_up_stock = StockQuote::Stock.quote(sticker_symbol)
      new(name: looked_up_stock.company_name,  sticker: looked_up_stock.symbol, 
      last_price: looked_up_stock.latest_price,)
    rescue Exception => e
    return nil
    end
   end
end
