require 'rack'

module Workit
  class Server
    def call(env)
      body = content(env)
      body ? response(body: [body]) : not_found
    end

    private

    def response(status: 200, header: {"Content-Type" => "text/html"}, body: [])
      [status, header, body]
    end

    def content(env)
      begin
        File.read(filepath(env))
      rescue Errno::ENOENT # No such file or directory
        nil
      end
    end

    def filepath(env)
      if route(env).empty?
        filename = "pages/index.html"
      else
        filename = "pages/#{route(env)}.html"
      end
    end

    def route(env)
      env["PATH_INFO"].gsub(/^\//, "")
    end

    def not_found
      response(status: 404, body: ["Not Found"])
    end
  end
end
