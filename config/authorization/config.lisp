;;;;;;;;;;;;;;;;;;;
;;; delta messenger
(in-package :delta-messenger)

;; (push (make-instance 'delta-logging-handler) *delta-handlers*) ;; enable if delta messages should be logged on terminal
(add-delta-messenger "http://delta-notifier/")
(setf *log-delta-messenger-message-bus-processing* nil) ;; set to t for extra messages for debugging delta messenger

;;;;;;;;;;;;;;;;;
;;; configuration
(in-package :client)
(setf *log-sparql-query-roundtrip* nil) ; change nil to t for logging requests to virtuoso (and the response)
(setf *backend* "http://triplestore:8890/sparql")

(in-package :server)
(setf *log-incoming-requests-p* nil) ; change nil to t for logging all incoming requests

;;;;;;;;;;;;;;;;
;;; prefix types
(in-package :type-cache)

(add-type-for-prefix "http://mu.semte.ch/sessions/" "http://mu.semte.ch/vocabularies/session/Session") ; each session URI will be handled for updates as if it had this mussession:Session type

;;;;;;;;;;;;;;;;;
;;; access rights

(in-package :acl)

;; these three reset the configuration, they are likely not necessary
(defparameter *access-specifications* nil)
(defparameter *graphs* nil)
(defparameter *rights* nil)

;; Prefixes used in the constraints below (not in the SPARQL queries)
(define-prefixes
  ;; Core
  :mu "http://mu.semte.ch/vocabularies/core/"
  :session "http://mu.semte.ch/vocabularies/session/"
  :ext "http://mu.semte.ch/vocabularies/ext/"
  :adms "http://www.w3.org/ns/adms#"
  :dcat "http://www.w3.org/ns/dcat#"
  :dct "http://purl.org/dc/terms/"
  :geo "http://www.w3.org/2003/01/geo/wgs84_pos#"
  :locn "http://www.w3.org/ns/locn#"
  :logies "https://data.vlaanderen.be/ns/logies#"
  :nfo "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#"
  :org "http://www.w3.org/ns/org#"
  :ost "http://w3id.org/ost/ns#"
  :prov "http://www.w3.org/ns/prov#"
  :regorg "http://www.w3.org/ns/regorg#"
  :schema "http://schema.org/"
  :skos "http://www.w3.org/2004/02/skos/core#")


;;;;;;;;;
;; Graphs

(define-graph public ("http://mu.semte.ch/graphs/public")
  ("dct:Agent" -> _)
  ("nfo:FileDataObject" -> _)
  ("skos:Collection" -> _)
  ("skos:Concept" -> _)
  ("skos:ConceptScheme" -> _)
  ("dcat:Catalog" -> _)
  ("dcat:Dataset" -> _)
  ("regorg:RegisteredOrganization" -> _)
  ("logies:Faciliteit" -> _)
  ("logies:ToeristischeRegio" -> _))

(define-graph mapped-public ("http://mu.semte.ch/graphs/mapped/public")
  ("schema:Accommodation" -> _)
  ("schema:ContactPoint" -> _)
  ("schema:GovernmentPermit" -> _)
  ("schema:MediaObject" -> _)
  ("schema:Place" -> _)
  ("schema:PropertyValue" -> _)
  ("schema:QuantitativeValue" -> _)
  ("schema:Rating" -> _)
  ("schema:Service" -> _)
  ("schema:TouristAttraction" -> _)
  ("ost:Recreation" -> _)
  ("geo:Point" -> _)
  ("adms:Identifier" -> _)
  ("locn:Address" -> _)
  ("locn:Geometry" -> _)
  ("org:Organisation" -> _)
  ("prov:Generation" -> _)
  ("prov:Invalidation" -> _)
  ("logies:Beschrijving" -> _)
  ("logies:Kwaliteitslabel" -> _)
  ("logies:Logies" -> _)
  ("logies:Registratie" -> _))

(define-graph mapped-private ("http://mu.semte.ch/graphs/mapped/private/")
  ("org:ContactPoint" -> _)
  ("adms:Identifier" -> _)
  ("locn:Address" -> _)
  ("org:Organisation" -> _)
  ("logies:Logies" -> _))

;;;;;;;;;;;;;
;; User roles

(supply-allowed-group "public")

(supply-allowed-group "organization"
  :parameters ("group_id")
  :query "PREFIX session: <http://mu.semte.ch/vocabularies/session/>
      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
      PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

      SELECT DISTINCT ?group_id WHERE {
          <SESSION_ID> session:account ?account .
          ?person foaf:account ?account .
          ?group foaf:member ?person ;
             skos:notation ?group_id .
      } LIMIT 1")

(grant (read)
       :to-graph (public mapped-public)
       :for-allowed-group "public")

(grant (read)
       :to-graph (mapped-private)
       :for-allowed-group "organization")
