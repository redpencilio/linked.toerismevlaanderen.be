defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    sparql: [ "application/sparql-results+json" ],
    any: [ "*/*" ]
  ]

  # Note: web_page is fairly early on because user agents which expect
  # web pages tend to accept any content type which is not under our
  # control.
  define_layers [ :static, :web_page, :sparql, :api_services, :resources, :not_found ]

  options "/*_path", _ do
    conn
    |> Plug.Conn.put_resp_header( "access-control-allow-headers", "content-type,accept" )
    |> Plug.Conn.put_resp_header( "access-control-allow-methods", "*" )
    |> send_resp( 200, "{ \"message\": \"ok\" }" )
  end

  ###############
  # STATIC
  ###############
  get "/assets/*path", %{ layer: :static } do
    forward conn, path, "http://frontend/assets/"
  end

  get "/favicon.ico", %{ layer: :static } do
    send_resp( conn, 404, "" )
  end

  #################
  # FRONTEND PAGES
  #################
  get "/files/:id/download", %{ layer: :web_page, accept: %{ any: true } } do
    forward conn, [], "http://file/files/" <> id <> "/download"
  end

  get "/*path", %{ layer: :web_page, accept: %{ html: true } } do
    # We forward path for fastboot
    forward conn, path, "http://frontend/"
    # In case of non-fastboot frontend, change to line below
    # forward conn, [], "http://frontend/index.html"
  end

  ###############
  # SPARQL
  ###############
  match "/sparql", %{ layer: :sparql, accept: %{ sparql: true } } do
    forward conn, [], "http://database:8890/sparql"
  end

  ###############
  # API SERVICES
  ###############
  post "/sessions", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, [], "http://login/sessions"
  end

  get "/sessions/current", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, [], "http://login/sessions/current"
  end

  delete "/sessions/current", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, [], "http://login/sessions/current"
  end

  get "/resource-labels/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://resource-labels-cache/"
  end

  get "/uri-info/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://uri-info/"
  end

  get "/perm/*path", %{ layer: :api_services, accept: %{ json: true } } do
    #    forward conn, path, "http:///dataset-generator/perm/"
        forward conn, path, "http://dataset-generator/perm/"
  end

  ###############
  # RESOURCES
  ###############

  get "/catalogs/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/catalogs/"
  end

  get "/datasets/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/datasets/"
  end

  get "/files/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/files/"
  end

  get "/concepts/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/concepts/"
  end

  get "/concept-schemes/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/concept-schemes/"
  end

  get "/tourist-attractions/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/tourist-attractions/"
  end

  get "/lodgings/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/lodgings/"
  end

  get "/identifiers/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/identifiers/"
  end

  get "/registrations/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/registrations/"
  end

  get "/generations/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/generations/"
  end

  get "/invalidations/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/invalidations/"
  end

  get "/addresses/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/addresses/"
  end

  get "/geometries/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/geometries/"
  end

  get "/touristic-regions/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/touristic-regions/"
  end

  get "/contact-points/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/contact-points/"
  end

  get "/media-objects/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/media-objects/"
  end

  get "/quality-labels/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/quality-labels/"
  end

  get "/descriptions/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/descriptions/"
  end

  get "/accessibility-information/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/accessibility-information/"
  end

  get "/ratings/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/ratings/"
  end

  get "/quantitative-values/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/quantitative-values/"
  end

  get "/property-values/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/property-values/"
  end

  get "/government-permits/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/government-permits/"
  end

  get "/facilities/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/facilities/"
  end

  get "/organizations/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/organizations/"
  end

  get "/registered-organizations/*path", %{ layer: :resources, accept: %{ json: true } } do
    forward conn, path, "http://cache/registered-organizations/"
  end

  #################
  # NOT FOUND
  #################
  match "/*_", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
