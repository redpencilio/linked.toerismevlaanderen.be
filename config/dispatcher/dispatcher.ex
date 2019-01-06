defmodule Dispatcher do
  use Plug.Router

  def start(_argv) do
    port = 80
    IO.puts "Starting Plug with Cowboy on port #{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  plug Plug.Logger
  plug :match
  plug :dispatch

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path" do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  get "/agents/*path" do
    Proxy.forward conn, path, "http://resource/agents/"
  end
  get "/ratings/*path" do
    Proxy.forward conn, path, "http://resource/ratings/"
  end
  get "/descriptions/*path" do
    Proxy.forward conn, path, "http://resource/descriptions/"
  end
  get "/creative-works/*path" do
    Proxy.forward conn, path, "http://resource/creative-works/"
  end
  get "/facilities/*path" do
    Proxy.forward conn, path, "http://resource/facilities/"
  end
  get "/registered-organizations/*path" do
    Proxy.forward conn, path, "http://resource/registered-organizations/"
  end
  get "/quality-labels/*path" do
    Proxy.forward conn, path, "http://resource/quality-labels/"
  end
  get "/lodgings/*path" do
    Proxy.forward conn, path, "http://resource/lodgings/"
  end
  get "/media-objects/*path" do
    Proxy.forward conn, path, "http://resource/media-objects/"
  end
  get "/registrations/*path" do
    Proxy.forward conn, path, "http://resource/registrations/"
  end
  get "/rooms/*path" do
    Proxy.forward conn, path, "http://resource/rooms/"
  end
  get "/touristic-regions/*path" do
    Proxy.forward conn, path, "http://resource/touristic-regions/"
  end
  get "/rental-units/*path" do
    Proxy.forward conn, path, "http://resource/rental-units/"
  end
  get "/locations/*path" do
    Proxy.forward conn, path, "http://resource/locations/"
  end
  get "/licenses/*path" do
    Proxy.forward conn, path, "http://resource/licenses/"
  end
  get "/addresses/*path" do
    Proxy.forward conn, path, "http://resource/addresses/"
  end
  get "/contact-points/*path" do
    Proxy.forward conn, path, "http://resource/contact-points/"
  end
  get "/geometries/*path" do
    Proxy.forward conn, path, "http://resource/geometries/"
  end
  get "/identifiers/*path" do
    Proxy.forward conn, path, "http://resource/identifiers/"
  end
  get "/quantitative-values/*path" do
    Proxy.forward conn, path, "http://resource/quantitative-values/"
  end
  get "/locator-designators/*path" do
    Proxy.forward conn, path, "http://resource/locator-designators/"
  end
  get "/points/*path" do
    Proxy.forward conn, path, "http://resource/points/"
  end
  get "/generations/*path" do
    Proxy.forward conn, path, "http://resource/generations/"
  end
  get "/invalidations/*path" do
    Proxy.forward conn, path, "http://resource/invalidations/"
  end
  get "/standardized-units/*path" do
    Proxy.forward conn, path, "http://resource/standardized-units/"
  end
  get "/audiences/*path" do
    Proxy.forward conn, path, "http://resource/audiences/"
  end
  get "/languages/*path" do
    Proxy.forward conn, path, "http://resource/languages/"
  end
  get "/file-formats/*path" do
    Proxy.forward conn, path, "http://resource/file-formats/"
  end
  get "/locator-designator-types/*path" do
    Proxy.forward conn, path, "http://resource/locator-designator-types/"
  end
  get "/registration-statuses/*path" do
    Proxy.forward conn, path, "http://resource/registration-statuses/"
  end
  get "/registration-lodging-types/*path" do
    Proxy.forward conn, path, "http://resource/registration-lodging-types/"
  end

  # Catch-all route
  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
