# linked.toerismevlaanderen.be

Semantic platform of Toerisme Vlaanderen hosted at [https://linked.toerismevlaanderen.be](https://linked.toerismevlaanderen.be).

The platform converts data of Toerisme Vlaanderen to Linked Open Data (LOD) and makes the data publically available in several formats (e.g. annotated subject pages, JSON/REST API, SPARQL endpoint, etc.).

## Getting started
### Running the application
To run the application, clone the repository and spin up the application using `docker-compose`:

```bash
git clone https://github.com/redpencilio/linked.toerismevlaanderen.be.git
cd linked.toerismevlaanderen.be
docker-compose up -d
```

### Create a new user account
A [script](https://github.com/mu-semtech/registration-service#generate-a-new-useraccount) is available to generate a new user account. The script will print the contents of a migration file which can be loaded in the triplestore using the migrations service.

To execute the script, first install [mu-cli](https://github.com/mu-semtech/mu-cli).

Next run the interactive script by executing
```bash
mu script registration generate-account
```

Copy the contents printed to the console to a new migration file in `./config/migrations`.

Next, restart the migrations service.
```bash
docker-compose restart migrations
```

The new user will be available in the triplestore and can login in the application.

## Reference
### Application stack
The stack is built using [Semantic.works](https://semantic.works), a microservice framework fuelled by Linked Data. The main idea behind the framework is explained in more depth [here](http://usewod.org/files/workshops/2015/papers/USEWOD15_versteden_pauwels_papantaniou.pdf).

The stack consists of several microservices, all listed and wired together in the `docker-compose.yml` file. The services can be divided into 3 categories:
1. Core services
2. Common services
3. Metis services
4. Custom services

Each of the categories and the services it consists of are briefly explained below. A reference to the documentation of each service where one can find more technical and in-depth information is provided.

#### Core services
Core microservices of the semantic.works framework. Most of them are just included as-is. Some require some application/domain specific configuration via environment variables or mounted configs.

##### Identifier
Microservice that serves an HTTP proxy for identifying sessions so microservices can act on them.

Configured such that unauthenticated users can only see public data by default.

Documentation: https://github.com/mu-semtech/mu-identifier

##### Dispatcher
Microservice for dispatching requests to the preferred microservice.

The dispatcher rules are configured in `./config/dispatcher/dispatcher.ex`.

Documentation: https://github.com/mu-semtech/mu-dispatcher

##### Database
Microservice put in front of the SPARQL endpoint of the triplestore to ensure authorization. It rewrites SPARQL queries based on the session information of the user and the access rights on the data.

Access rights on the data are configured in `./config/authorization/config.ex`.

Documentation: https://github.com/mu-semtech/mu-authorization

##### Triplestore
Microservice hosting a Virtuoso triplestore. This is the database in which all triples are stored.

The data is mounted in `./data/db`.
The Virtuoso configuration is mounted in `./config/db/virtuoso.ini`.

Documentation: https://github.com/redpencilio/docker-virtuoso

##### Delta notifier
Microservice notifying subscribers about changes in the triplestore.

Subscribers are configured in `./data/delta/rules.js`.

Documentation: https://github.com/mu-semtech/delta-notifier

#### Common services
Common services providing typical application features and therefore widely used in most semantic.work application stacks. Most of them are just included as-is. Some require some application/domain specific configuration via environment variables or mounted configs.

##### Migrations
Microservice executing database migrations on startup.

Migrations files are mounted in `./config/migrations`.

Documentation: https://github.com/mu-semtech/mu-migrations-service

##### Resources
Microservice that generates a JSON:API compliant API for a configured domain model.

Resources are configured in Common Lisp in `./config/resources`.

Documentation: https://github.com/mu-semtech/mu-cl-resources

##### Cache
Microservice put in frontend of the `resource` service to cache API requests.

Documentation: https://github.com/mu-semtech/mu-cache

##### File
Microservice to store files and their metadata used a.o. to provide downloadable datasets in CSV and TTL format.

Files are mounted in `./data/files`.

Documentation: https://github.com/mu-semtech/file-service

##### Login
Microservice to login, i.e. associate a session with a user account.

Documentation: https://github.com/mu-semtech/login-service

##### Registration
Microservice to create user accounts. The registration is only included in the stack to provide a [mu-script](https://github.com/mu-semtech/mu-cli) to [generate new user accounts](https://github.com/mu-semtech/registration-service#generate-a-new-useraccount). Therefore, the service is disabled and will immediately exit when the application is started.

Documentation: https://github.com/mu-semtech/registration-service

#### Metis services
Services required to construct subject pages for the Linked Data resources using [ember-metis](https://github.com/redpencilio/ember-metis) in the frontend.

##### URI info
Microservice yielding information about a supplied URI.

Documentation: https://github.com/redpencilio/mu-uri-info-service

##### Resource labels
Microservice to retrieve a  human-readable label for a URI.

A mu-cache instance, named `resource-labels-cache`, is put in front of the service to cache the requests and improve performance.

Documentation: https://github.com/lblod/resource-label-service

#### Custom services
##### Frontend
[Frontend application built in Ember.js](https://github.com/redpencilio/frontend-linked.toerismevlaanderen.be) provided subject pages for the Linked Data resources. The subject pages are provided by [ember-metis](https://github.com/redpencilio/ember-metis).

##### Import
Microservice to transform data of Toerisme Vlaanderen originating from an SQL database to Linked Data. The conversion process and configuration is described in detail in the service documentation.

Documentation: https://github.com/redpencilio/logies-data-converter-service

##### Dataset generator
Microservice generating and publishing downloadable DCAT datasets.

Generated files are written to `./data/files` such that they can be hosted by the `file`-service.

Documentation: https://github.com/redpencilio/logies-dataset-generator-service

### Data model
The platform currently publishes data about tourist attractions as Linked Data using standardized vocabularies. The data model is mainly based on the [Logies Basis Application Profile](https://data.vlaanderen.be/doc/applicatieprofiel/logies-basis/) of Flanders and https://schema.org.

Data is published on the `http://linked.toerismevlaanderen.be` domain.

### Published data

#### Subject pages
Subject pages provide a human-readable HTML page with all the information known about a particular subject URL. Since the pages are annotated with RDFa, the information is also interpretable by machines, e.g. crawlers and search engines.

The subject pages are provided by [Metis](#Metis-services).

#### JSON/REST API
The platform provides a REST API to query the Linked Data resources. This API is in line with the [JSON:API specification](https://jsonapi.org). Pagination, sorting and filtering is done using query parameters [as described in the documentation of the framework](https://github.com/mu-semtech/mu-cl-resources#querying-the-api).

#### SPARQL endpoint
The platform provides a SPARQL endpoint to query the Linked Data using [the SPARQL 1.1 query language](https://www.w3.org/TR/sparql11-query/). This way all published data can be queried. The endpoint is available at `/sparql`.

The SPARQL endpoint has the following constraints:
- SPARQL queries can only be sent [via HTTP GET with percent encoded query parameters](https://www.w3.org/TR/2013/REC-sparql11-protocol-20130321/#query-via-get)
- Only [SPARQL SELECT queries](https://www.w3.org/TR/2013/REC-sparql11-query-20130321/#select) are supported.
- The SPARQL query must comply to [the SPARQL EBNF format](https://www.w3.org/TR/sparql11-query/#sparqlGrammar).
- query results can only be obtained [in the application/sparql-results+json format](https://www.w3.org/TR/sparql11-results-json/)

Note that SPARQL update queries do not return an error message, but the requested data manipulations will not be performed since users don't have update access rights on the data.

#### Downloadable datasets
The platform provides downloadable datasets in TTL and CSV format. The files can be downloaded via `/datasets` or be retrieved via the JSON/REST API by doing a `GET` request on `/datasets`.

New dataset versions are generated after each conversion. Permanent links, starting with `/perm/` are available to download the latest version of a specific dataset.

### Data access rights
Not all data is publicly available. Authorization is provided by the [mu-authorization service](https://github.com/mu-semtech/mu-authorization) service. Access rights on the data are configured in `./config/authorization/config.ex`.

Data is spread in the triplestore amongst the following graphs:

| Graph | Description |
|-------|-------------|
| `http://mu.semte.ch/graphs/public` | Public graph containing static data like codelists |
| `http://mu.semte.ch/graphs/mapped/public` | Graph containing the public data of the conversion process |
| `http://mu.semte.ch/graphs/mapped/private/<group>` | Graph containing private data of the conversion process only accessible to a specific group. Current known groups are `cjt`, `fod-economy`, `province-flemish-brabant`, `province-west-flanders`, `province-east-flanders`, `province-antwerp`, `province-limburg` |

### Authentication
Not all data is publicly available, but only accessible to autenticated users depending on the group they belong to.

#### Via GUI
To login via the web application, navigate to `/login`. Enter the username and password and click 'Login'.

To logout navigate back to `/login`. If the user is logged in, a 'Logout' button will be shown.

#### Via API
To authorize a request via the JSON/REST API, the user must first login to collect a cookie. Afterwards, the cookie needs to be set on the next requests. The requests to login/logout are documented in the [login service](https://github.com/mu-semtech/login-service#api)

To login a request `POST /sessions` must be sent with the following request body:
```json
{
  "data": {
    "type":"sessions",
    "attributes": {
      "nickname": "username",
      "password":"secret"
    }
  }
}
```

The response will contain a `Set-Cookie` header for the `proxy_session` cookie. The cookie needs to be set on the next requests.

To logout a request `DELETE /sessions/current` must be sent with the cookie.




