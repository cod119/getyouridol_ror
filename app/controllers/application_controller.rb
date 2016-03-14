class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def rangeArray(key, unit, minmax)
    #minmax가 0이면 min, 1이면 max
    #key는 string오로 입력하면 symbol로 변환함.
    #신장
     @RangeArrayRaw = Idol.select(key.to_sym).distinct.pluck(key.to_sym).flatten
     @MinRaw = (@RangeArrayRaw.min / unit).floor
     @MaxRaw = (@RangeArrayRaw.max / unit).floor
     @RangeArray = {}
     for val in ((@MinRaw+minmax)..(@MaxRaw+minmax))
       @RangeArray[val*unit] = val*unit
     end
     return @RangeArray
  end 
  
end
