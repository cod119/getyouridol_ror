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
  
  def multipleValArray(beforeSelect, key, separator, includeZero)
    #특정 'key' column의 값이 특정 'separator' (예: ',')로 구분되어 있는 경우
    #이를 단위로 분리하여, 중복되지 않는 모든 값으로 이루어진 array를 출력
    #beforeSelect는 select 구문 전에 들어갈 raw db
    #includeZero가 1이면 0을 Hash에 포함하여 출력, 0이면 미포함.
    #key는 string오로 입력하면 symbol로 변환함.
    @multipleValArrayRaw = beforeSelect.select(key.to_sym).distinct.pluck(key.to_sym).flatten
    #@multipleValArrayRaw = beforeSelect.select(key.to_sym).order().distinct.pluck(key.to_sym).flatten
    @newMultipleValArray = []
    for val in @multipleValArrayRaw
        if val.include?(separator)
            splittedArray = val.split(separator)
            splittedArray.each do |value|
                @newMultipleValArray.push(value)
            end
            next
        end
        @newMultipleValArray.push(val)
    end
    if includeZero == 0
        @newMultipleValArray.select! {|v| v != 0}
        @newMultipleValArray.select! {|v| v != "0"}
    end
    return @newMultipleValArray.uniq
  end
  
end
