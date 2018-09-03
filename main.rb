require "stock_quote"

apple.stock = StockQuote::Stock.quote("tsla")
apple.stock = StockQuote::Stock.quote("fb")
apple.stock = StockQuote::Stock.quote("googl")
apple.stock = StockQuote::Stock.quote("aapl")

p apple.stock 
