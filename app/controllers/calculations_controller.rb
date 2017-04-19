class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.split

    @word_count = text_split_into_array.length

    text_into_characters_with_spaces = @text.split("")

    @character_count_with_spaces = text_into_characters_with_spaces.length

    text_into_characters = @text.gsub(/\s+/, "")

    @character_count_without_spaces = text_into_characters.length

    lowercase_text=@text.downcase

    special_text=lowercase_text.gsub(/[^a-z0-9\s]/i, "")

    special_word_text = special_text.split

    @occurrences = special_word_text.count{|x| x==@special_word}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.rtm
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    monthly_rate=@apr/1200
    number_of_payments=@years*12

    payment=(monthly_rate)/(1-(1+monthly_rate)**-number_of_payments)

    @monthly_payment = payment*@principal

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    time_convert=@ending-@starting



    @seconds = @ending-@starting
    @minutes = time_convert/60
    @hours = time_convert/3600
    @days = time_convert/86400
    @weeks =time_convert/604800
    @years = time_convert/31557600

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================


    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    def median
      sorted = @numbers.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    @median = median

    @sum = @numbers.sum

    sum_number=@numbers.sum
    number_total=@numbers.count

    @mean = sum_number/number_total

    def var
      m=@mean
      @numbers.sum{|i| (i-m)**2} /@numbers.size
    end

    @variance = var

    def dev
      m=@mean
      p=@numbers.sum{|i| (i-m)**2} /@numbers.size
      Math.sqrt(p)
    end

    @standard_deviation = dev

    frequency = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by { |v| frequency[v] }


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
