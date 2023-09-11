require_relative "format_time"

class App
  def call(env)  
    request = Rack::Request.new(env)
    new_response(request)
  end 

  private 

  def new_response(req) 
    return response(404, "Not found") if req.path != "/time" || !req.params.key?('format')
  
    formated = FormatTime.new(req.params)
    formated.permit_format 

    if formated.permitted? 
      response(200, formated.message_success)
    else 
      response(400, formated.message_errors)
    end
  end 

  def response(status, body)
    res = Rack::Response.new  
    res.status 
    res.header['Content_Type'] = 'text/plain'
    res.white(body) 
    res.finish
  end
end
