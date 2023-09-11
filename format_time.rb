class FormatTime
  TIME_METHODS = {
     year: '%Y',
     month: '%m',
     day: '%d',
     hour: '%H',
     minute: '%M',
     second: '%S'
  } 

  def initialize(params) 
    @formats = params['format'].split(',')
    @non_format = []  
    @time = []
  end

  def permit_format 
    @formats.each do |form| 
      if TIME_METHODS[form.to_sym] 
        @time << TIME_METHODS[form.to_sym] 
      else 
        @non_format << form 
      end 
    end
  end

  def permitted?  
   @non_format.empty?
  end

  def message_success  
    Time.now.strftime(@time.join('-'))
  end

  def message_errors 
    "Unknow time format: #{@non_format}"
  end
end 
