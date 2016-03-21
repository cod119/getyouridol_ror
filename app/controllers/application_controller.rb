class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def rangeArray(key, unit, isminmax)
    #isminmax가 0이면 min, 1이면 max
    #key는 string오로 입력하면 symbol로 변환함.
    #신장
     @RangeArrayRaw = Idol.select(key.to_sym).distinct.pluck(key.to_sym).flatten
     @RangeArrayRaw.select! {|v| v>=0}
     @MinRaw = (@RangeArrayRaw.min / unit).floor
     @MaxRaw = (@RangeArrayRaw.max / unit).floor
     @RangeArray = {}
     for val in ((@MinRaw+isminmax)..(@MaxRaw+isminmax))
       @RangeArray[val*unit] = val*unit
     end
     return @RangeArray
  end 
  
  def nonRangeArray(key, includeZero)
    #includeZero가 1이면 0을 Hash에 포함하여 출력, 0이면 미포함.
    #key는 string오로 입력하면 symbol로 변환함.
    @nonRangeArrayRaw = Idol.select(key.to_sym).distinct.pluck(key.to_sym).flatten
    if includeZero == 0
        @nonRangeArrayRaw.select! {|v| v != 0}
        @nonRangeArrayRaw.select! {|v| v != "0"}
    end
    return @nonRangeArrayRaw
  end
  
end
