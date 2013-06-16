require 'rack'

class Server
  class Response < Rack::Response; end

  def self.call(env)
    body = content(env)
    body ? response([body]) : not_found
  end

  def self.response(body=[], status=200, header={"Content-Type" => "text/html"})
    Response.new(body, status, header)
  end

  def self.content(env)
    begin
      if route(env).empty?
        File.read("app/index.html")
      else
        File.read("app/#{route(env)}.html")
      end
    rescue Errno::ENOENT # No such file or directory
      nil
    end
  end

  def self.route(env)
    env["PATH_INFO"].gsub(/^\//, "")
  end

  def self.not_found
    response("Not Found", 404, {"Content-Type" => "text/plain"})
  end
end

run Server
