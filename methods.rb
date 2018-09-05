module Methods

    # This method prompts user to deposit to the account and update the account balance
    def self.cash_deposit account
        puts "Hello #{account.account_name}! Your current balance is $#{account.account_balance}"
        print "How much would you like to deposit? "
        new_deposit = gets.strip.to_f
        account.account_balance = account.account_balance + new_deposit
        puts """
        Successfully deposited $#{new_deposit} to your account!
        Your current account balance is $#{account.account_balance}
        """
        self.back_to_menu account
    end

    # This methods brings users back to the main menu
    def self.back_to_menu account
        print "Press 'X' to go to Menu..."
        user_input = gets.strip.downcase
            if user_input == 'x'
                self.display_menu account
            else 
                self.back_to_menu account
            end
    end

    # Display the menu
    def self.display_menu account
        puts """
        Menu
        
        [D] Cash Deposit
        [W] My Watchlist
        [P] Stock price
        [E] PE Ratio
        [C] Change Percentage
        [I] Invest
        [S] Cart 
        """
        self.menu_selection account
    end

    # This method prompts users to select a directory from the menu
    def self.menu_selection account
        print "Please select directory: "
        menu_selection = gets.strip.upcase
        case menu_selection
        when "D"
            self.cash_deposit account
        when "W"
            self.my_watchlist account
        when "P"
            self.display_price account
        when "E"
            self.display_ratio account
        when "C"
            self.display_percent account
        when "I"
            self.invest account
        when "S"
            self.display_cart account
        else
            self.menu_selection account
        end
    end

    # Display the user's saved watchlist 
    def self.my_watchlist account
        account.user_stocks.each_with_index do |name, index|
            require 'colorize'
            if account.user_stocks[index].change_percent >= 0 
                x = account.user_stocks[index].change_percent.to_s.colorize(:green)
            else
                x = account.user_stocks[index].change_percent.to_s.colorize(:red)
            end

        print """
        #{index+1}. #{account.user_stocks[index].name}
        Symbol: #{account.user_stocks[index].symbol}
        Price: $#{account.user_stocks[index].price}
        PE Ratio: #{account.user_stocks[index].pe_ratio}
        % Change: #{x}
        """
        end
        puts ""

        self.back_to_menu account
    end

    # Display the price of the stocks
    def self.display_price account
        puts "Stock Price"
        account.user_stocks.each_with_index do |name, index|
        print "
        #{index+1}. #{account.user_stocks[index].name}: $#{account.user_stocks[index].price} \n"
        end
        puts ""
        self.back_to_menu account
    end

    # Display the PE ratio of the stocks
    def self.display_ratio account
        puts "PE Ratio"
        account.user_stocks.each_with_index do |name, index|
        print "
        #{index+1}. #{account.user_stocks[index].name}: #{account.user_stocks[index].pe_ratio} \n"
        end
        puts ""
        self.back_to_menu account
    end

    # Display the percentage change of the stocks
    def self.display_percent account
        puts "Percentage Change"
        account.user_stocks.each_with_index do |name, index|
            require 'colorize'
            if account.user_stocks[index].change_percent >= 0 
                x = account.user_stocks[index].change_percent.to_s.colorize(:green)
            else
                x = account.user_stocks[index].change_percent.to_s.colorize(:red)
            end

        print "
        #{index+1}. #{account.user_stocks[index].name}: #{x}\n"
        end
        puts ""
        self.back_to_menu account
    end

    # Prompt user to enter what stock(and how many shares) he would like to invest and add the stock to the cart 
    def self.invest account
        print "Which stock would you like to invest in (symbol): "
        order_stock = gets.strip.upcase
        chosen_stock = account.user_stocks.find do |stock|
            stock.symbol == order_stock  
        end 

        print "Quantity of shares? "
        order_quantity = gets.strip.to_i
        order_cost = (chosen_stock.price * order_quantity).round(2)

        if account.account_balance >= order_cost
            account.account_balance = (account.account_balance - order_cost).round(2)
            chosen_stock.quantity = order_quantity
            chosen_stock.subtotal_cost = order_cost
            account.cart << chosen_stock
            puts "
        Successfully added #{order_quantity} share(s) of #{chosen_stock.symbol} (#{chosen_stock.name}) to your cart!
        Total cost: $#{order_cost}
        Current account balance: $#{account.account_balance}
            "
        else
            puts "
        Sorry! Insufficient funds!!!! 
            "
        end

        print "Would you like to invest in another stock? (Y/N) "
        answer = gets.strip.downcase
            if answer == "y"
                self.invest(account)
            else
                self.back_to_menu account
            end
    end

    # Display the user's cart/summary
    def self.display_cart account
        account.cart.each_with_index do |stock, index|
        print "
        #{index+1}. #{account.cart[index].name} (#{account.cart[index].symbol})
        Quantity: #{account.cart[index].quantity}
        Cost: $#{account.cart[index].subtotal_cost}
        "
        end
        puts "
        Your remaining balance: $#{account.account_balance}
        "
        self.back_to_menu account
    end
end


