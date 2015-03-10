class DateOffset
  attr_reader :given_date
  def initialize(date = nil)
    @given_date = date
  end

  def date_not_provided?
    @given_date == nil
  end

  def today_date
    today = Time.now
    format_numerically(today)
  end

  def format_numerically(date)
    @given_date = date.strftime("%d%m%y")
  end

  def square(formated_date)
    formated_date ** 2
  end

  def splice_final_four(squared_value)
    squared_value.to_s[-4..-1]
  end

  def calculate_date_offset(date = @given_date)
    if date_not_provided?
      today_date
    end
    squared = square(remove_leading_zero)
    spliced = splice_final_four(squared)
    spliced.chars
  end

  def remove_leading_zero
    manipulated_date = @given_date.dup
    if manipulated_date[0] == "0"
      manipulated_date[0] = ""
    end
    manipulated_date.to_i
  end

end
