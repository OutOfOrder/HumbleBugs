class RedirectURL
  def initialize(app, public_host = nil, force_ssl = false)
    @app = app
    @public_host = public_host
    @force_ssl = force_ssl
  end

  def call(env)

    request = Rack::Request.new(env)

    if !@public_host.nil? && request.host != @public_host
      url = request.url.sub("//#{request.host}", "//#{@public_host}")
      url = url.sub("http://", "https://") if @force_ssl
      [302, {"Location" => url}, []]
    else
      @app.call(env)
    end
  end
end