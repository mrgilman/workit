require 'rack'

module Workit
  class Server
    class Response < Rack::Response; end

    def call(env)
      body = content(env)
      body ? response([body]) : not_found
    end

    def response(body=[], status=200, header={"Content-Type" => "text/html"})
      Response.new(body, status, header)
    end

    def content(env)
      begin
        if route(env).empty?
          File.read("pages/index.html")
        else
          File.read("pages/#{route(env)}.html")
        end
      rescue Errno::ENOENT # No such file or directory
        nil
      end
    end

    def route(env)
      env["PATH_INFO"].gsub(/^\//, "")
    end

    def not_found
      response("Not Found", 404, {"Content-Type" => "text/plain"})
    end
  end
end
