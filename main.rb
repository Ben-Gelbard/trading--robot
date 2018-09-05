# require gems
require 'stock_quote'
   
# require modules
require_relative 'methods.rb'

# create User class
class User

    attr_accessor :account_name, :account_balance, :user_stocks, :cart

    def initialize name
        @account_name = name
        @account_balance = 0
        @user_stocks = []
        @cart = []
    end

    def add_stock_to_portfolio stock
        @user_stocks << stock
    end
end

# create Stock class
class Stock

    attr_accessor :name, :symbol, :price, :pe_ratio, :change_percent, :quantity, :subtotal_cost

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
        @price = StockQuote::Stock.quote(symbol).latest_price
        @pe_ratio = StockQuote::Stock.quote(symbol).pe_ratio
        @change_percent = StockQuote::Stock.quote(symbol).change_percent
        @quantity = quantity
        @subtotal_cost = subtotal_cost
    end

end

# Create User instances
account1 = User.new("Ben")
account2 = User.new("Aitzu")

# Create Stock instances
apple = Stock.new('Apple', 'AAPL')
netflix = Stock.new('Netflix', "NFLX")
facebook = Stock.new('Facebook', "FB")
amazon = Stock.new('Amazon', "AMZN")
amex = Stock.new('American Express', "AXP")
tesla = Stock.new('Tesla', "TSLA")
alibaba = Stock.new('Alibaba', "BABA")
a_airlines = Stock.new('American Airlines', "AAL")
nike = Stock.new('Nike', "NKE")
brk = Stock.new('BERKSHIRE HATHAWAY', "BRK.A")

# Add stocks to the user account
account2.add_stock_to_portfolio(apple)
account2.add_stock_to_portfolio(netflix)
account2.add_stock_to_portfolio(facebook)
account2.add_stock_to_portfolio(amazon)
account2.add_stock_to_portfolio(amex)
account2.add_stock_to_portfolio(tesla)
account2.add_stock_to_portfolio(alibaba)
account2.add_stock_to_portfolio(a_airlines)
account2.add_stock_to_portfolio(nike)
account2.add_stock_to_portfolio(brk)

# run the code 
Methods.cash_deposit(account2)