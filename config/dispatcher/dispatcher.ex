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

  match "/sparql/*path" do
    Proxy.forward conn, path, "http://sparql:8890/sparql/"
  end

  match "/id/*path" do
    Proxy.forward conn, path, "http://cache/"
  end

  # get "/agents/*path" do
  #   Proxy.forward conn, path, "http://cache/agents/"
  # end
  get "/ratings/*path" do
    Proxy.forward conn, path, "http://cache/ratings/"
  end
  get "/descriptions/*path" do
    Proxy.forward conn, path, "http://cache/descriptions/"
  end
  # get "/creative-works/*path" do
  #   Proxy.forward conn, path, "http://cache/creative-works/"
  # end
  get "/facilities/*path" do
    Proxy.forward conn, path, "http://cache/facilities/"
  end
  get "/registered-organizations/*path" do
    Proxy.forward conn, path, "http://cache/registered-organizations/"
  end
  get "/quality-labels/*path" do
    Proxy.forward conn, path, "http://cache/quality-labels/"
  end
  get "/lodgings/*path" do
    Proxy.forward conn, path, "http://cache/lodgings/"
  end
  get "/media-objects/*path" do
    Proxy.forward conn, path, "http://cache/media-objects/"
  end
  get "/registrations/*path" do
    Proxy.forward conn, path, "http://cache/registrations/"
  end
  # get "/rooms/*path" do
  #   Proxy.forward conn, path, "http://cache/rooms/"
  # end
  get "/touristic-regions/*path" do
    Proxy.forward conn, path, "http://cache/touristic-regions/"
  end
  # get "/rental-units/*path" do
  #   Proxy.forward conn, path, "http://cache/rental-units/"
  # end
  # get "/locations/*path" do
  #   Proxy.forward conn, path, "http://cache/locations/"
  # end
  # get "/licenses/*path" do
  #   Proxy.forward conn, path, "http://cache/licenses/"
  # end
  get "/addresses/*path" do
    Proxy.forward conn, path, "http://cache/addresses/"
  end
  get "/contact-points/*path" do
    Proxy.forward conn, path, "http://cache/contact-points/"
  end
  # get "/geometries/*path" do
  #   Proxy.forward conn, path, "http://cache/geometries/"
  # end
  get "/identifiers/*path" do
    Proxy.forward conn, path, "http://cache/identifiers/"
  end
  get "/quantitative-values/*path" do
    Proxy.forward conn, path, "http://cache/quantitative-values/"
  end
  # get "/locator-designators/*path" do
  #   Proxy.forward conn, path, "http://cache/locator-designators/"
  # end
  get "/points/*path" do
    Proxy.forward conn, path, "http://cache/points/"
  end
  get "/generations/*path" do
    Proxy.forward conn, path, "http://cache/generations/"
  end
  get "/invalidations/*path" do
    Proxy.forward conn, path, "http://cache/invalidations/"
  end
  get "/concepts/*path" do
    Proxy.forward conn, path, "http://cache/concepts/"
  end
  get "/conceptschemes/*path" do
    Proxy.forward conn, path, "http://cache/conceptschemes/"
  end
  # get "/standardized-units/*path" do
  #   Proxy.forward conn, path, "http://cache/standardized-units/"
  # end
  # get "/audiences/*path" do
  #   Proxy.forward conn, path, "http://cache/audiences/"
  # end
  # get "/languages/*path" do
  #   Proxy.forward conn, path, "http://cache/languages/"
  # end
  # get "/file-formats/*path" do
  #   Proxy.forward conn, path, "http://cache/file-formats/"
  # end
  # get "/locator-designator-types/*path" do
  #   Proxy.forward conn, path, "http://cache/locator-designator-types/"
  # end
  # get "/registration-statuses/*path" do
  #   Proxy.forward conn, path, "http://cache/registration-statuses/"
  # end
  # get "/registration-lodging-types/*path" do
  #   Proxy.forward conn, path, "http://cache/registration-lodging-types/"
  # end
  # get "/registration-publication-lodging-types/*path" do
  #   Proxy.forward conn, path, "http://cache/registration-publication-lodging-types/"
  # end

  # Data dumps
  get "/files/:id/download" do
    Proxy.forward conn, [], "http://file/files/" <> id <> "/download"
  end
  get "/files/*path" do
    Proxy.forward conn, path, "http://cache/files/"
  end
  get "/data-dumps/*path" do
    Proxy.forward conn, path, "http://cache/data-dumps/"
  end

  # Catch-all route
  match _ do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
