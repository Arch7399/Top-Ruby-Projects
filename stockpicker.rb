def stock_picker(prices)
  lowest_price = prices[0]
  profit_pair = [0, 0]

  prices.each_with_index do |current_price, current_index|
    lowest_price = current_price if current_price < lowest_price

    if current_price - lowest_price > prices[profit_pair[1]] - prices[profit_pair[0]]
      profit_pair = [prices.index(lowest_price), current_index]
    end
  end

  profit_pair
end


p stock_picker([17,3,6,9,15,8,6,1,10])