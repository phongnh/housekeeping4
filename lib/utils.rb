# encoding: utf-8

class Fixnum
  
  def mon(locale=I18n.locale)
    MONTHS[locale].try(:[], self)
  end
  
  private
  MONTHS = {
    :vi => {
      1  => "Tháng 1",
      2  => "Tháng 2",
      3  => "Tháng 3",
      4  => "Tháng 4",
      5  => "Tháng 5",
      6  => "Tháng 6",
      7  => "Tháng 7",
      8  => "Tháng 8",
      9  => "Tháng 9",
      10 => "Tháng 10",
      11 => "Tháng 11",
      12 => "Tháng 12"
    },
    
    :en => {
      1  => "January",
      2  => "February",
      3  => "March",
      4  => "April",
      5  => "May",
      6  => "June",
      7  => "July",
      8  => "August",
      9  => "September",
      10 => "October",
      11 => "November",
      12 => "December"
    } 
  }
end
