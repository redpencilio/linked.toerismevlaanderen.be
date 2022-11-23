defmodule Dispatcher do
  use Matcher

  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    sparql: [ "application/sparql-results+json" ],
    any: [ "*/*" ]
  ]

  define_layers [ :static, :sparql, :resources, :api_services, :frontend_fallback, :not_found ]

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

  get "/index.html", %{ layer: :static } do
    forward conn, [], "http://frontend/index.html"
  end

  get "/favicon.ico", %{ layer: :static } do
    send_resp( conn, 404, "" )
  end

  ###############
  # SPARQL
  ###############
  get "/sparql", %{ layer: :sparql, accept: %{ html: true } } do
    forward conn, [], "http://frontend/sparql"
  end

  match "/sparql", %{ layer: :sparql, accept: %{ sparql: true } } do
    forward conn, [], "http://database:8890/sparql"
  end

  ###############
  # RESOURCES
  ###############

  # Resources may be exposed via mu-cl-resources to build custom subject pages

  get "/data-dumps/*path" do
    forward conn, path, "http://cache/data-dumps/"
  end

  ###############
  # API SERVICES
  ###############

  get "/files/*path", %{ layer: :api_services, accept: %{ any: true } } do
    forward conn, path, "http://file/files/"
  end

  #################
  # FRONTEND PAGES
  #################
  get "/*path", %{ layer: :frontend_fallback, accept: %{ html: true } } do
    # We forward path for fastboot
    forward conn, path, "http://frontend/"
  end

  #################
  # NOT FOUND
  #################
  match "/*_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
