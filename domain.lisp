;; domain.lisp generated for http://172.19.0.1:8890/sparql (graph http://localhost:8890/DAV) 
(define-resource identifier
   :class (s-url "http://www.w3.org/ns/adms#Identifier")
   :properties `(
               
               (notation :string ,(s-url "http://www.w3.org/2004/02/skos/core#notation"))
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (schema-agency :string ,(s-url "http://www.w3.org/ns/adms#schemaAgency"))
               
                )
   :has-many `(
               
               (registratie :via ,(s-url "http://www.w3.org/ns/adms#identifier")
                      :inverse t                   
                      :as "registratie")
               
               (tourist-attraction :via ,(s-url "http://www.w3.org/ns/adms#identifier")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "http://www.w3.org/ns/adms#identifier")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "identifiers"
)
(define-resource accessibility-information
   :class (s-url "http://linked.toerismevlaanderen.be/vocabularies/accessibility/AccessibilityInformation")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "http://purl.org/dc/terms/subject")
                                         
                      :as "subject")
               
               (logies :via ,(s-url "http://purl.org/dc/terms/subject")
                                         
                      :as "subject")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "accessibility-informations"
)
(define-resource address
   :class (s-url "http://www.w3.org/ns/locn#Address")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (gemeentenaam :string ,(s-url "https://data.vlaanderen.be/ns/adres#gemeentenaam"))
               
               (post-code :string ,(s-url "http://www.w3.org/ns/locn#postCode"))
               
               (thoroughfare :string ,(s-url "http://www.w3.org/ns/locn#thoroughfare"))
               
               (adresvoorstelling.busnummer :string ,(s-url "https://data.vlaanderen.be/ns/adres#Adresvoorstelling.busnummer"))
               
               (adresvoorstelling.huisnummer :string ,(s-url "https://data.vlaanderen.be/ns/adres#Adresvoorstelling.huisnummer"))
               
               (land :string ,(s-url "https://data.vlaanderen.be/ns/adres#land"))
               
                )
   :has-many `(
               
               (contact-point :via ,(s-url "http://www.w3.org/ns/locn#address")
                      :inverse t                   
                      :as "contact-point")
               
               (tourist-attraction :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalAdres")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalAdres")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "addresss"
)
(define-resource contact-point
   :class (s-url "http://schema.org/ContactPoint")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (first-name :string ,(s-url "http://xmlns.com/foaf/0.1/firstName"))
               
               (given-name :string ,(s-url "http://xmlns.com/foaf/0.1/givenName"))
               
                )
   :has-many `(
               
               (address :via ,(s-url "http://www.w3.org/ns/locn#address")
                                         
                      :as "address")
               
               (tourist-attraction :via ,(s-url "http://schema.org/contactPoint")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "http://schema.org/contactPoint")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "contact-points"
)
(define-resource generation
   :class (s-url "http://www.w3.org/ns/prov#Generation")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (at-time :datetime ,(s-url "http://www.w3.org/ns/prov#atTime"))
               
                )
   :has-many `(
               
               (registratie :via ,(s-url "http://www.w3.org/ns/prov#qualifiedGeneration")
                      :inverse t                   
                      :as "registratie")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "generations"
)
(define-resource point
   :class (s-url "http://www.w3.org/2003/01/geo/wgs84_pos#Point")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (as-gml :string ,(s-url "http://www.opengis.net/ont/geosparql#asGML"))
               
               (lat :string ,(s-url "http://www.w3.org/2003/01/geo/wgs84_pos#lat"))
               
               (as-wkt :string ,(s-url "http://www.opengis.net/ont/geosparql#asWKT"))
               
               (long :string ,(s-url "http://www.w3.org/2003/01/geo/wgs84_pos#long"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "points"
)
(define-resource geometry
   :class (s-url "http://www.w3.org/ns/locn#Geometry")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (as-gml :string ,(s-url "http://www.opengis.net/ont/geosparql#asGML"))
               
               (lat :string ,(s-url "http://www.w3.org/2003/01/geo/wgs84_pos#lat"))
               
               (as-wkt :string ,(s-url "http://www.opengis.net/ont/geosparql#asWKT"))
               
               (long :string ,(s-url "http://www.w3.org/2003/01/geo/wgs84_pos#long"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "geometrys"
)
(define-resource organisation
   :class (s-url "http://www.w3.org/ns/org#Organisation")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "http://schema.org/owns")
                                         
                      :as "owns")
               
               (logies :via ,(s-url "http://schema.org/owns")
                                         
                      :as "owns")
               
               (tourist-attraction :via ,(s-url "http://schema.org/offeredBy")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "http://schema.org/offeredBy")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "organisations"
)
(define-resource government-permit
   :class (s-url "http://schema.org/GovernmentPermit")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (name :string ,(s-url "http://schema.org/name"))
               
               (valid-until :datetime ,(s-url "http://schema.org/validUntil"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "http://purl.org/dc/terms/subject")
                                         
                      :as "subject")
               
               (logies :via ,(s-url "http://purl.org/dc/terms/subject")
                                         
                      :as "subject")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "government-permits"
)
(define-resource kwaliteitslabel
   :class (s-url "https://data.vlaanderen.be/ns/logies#Kwaliteitslabel")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (pref-label :string ,(s-url "http://www.w3.org/2004/02/skos/core#prefLabel"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftKwaliteitslabel")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftKwaliteitslabel")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "kwaliteitslabels"
)
(define-resource quantitative-value
   :class (s-url "http://schema.org/QuantitativeValue")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (unit-text :string ,(s-url "http://schema.org/unitText"))
               
               (value :string ,(s-url "http://schema.org/value"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "https://data.vlaanderen.be/ns/logies#capaciteit")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "https://data.vlaanderen.be/ns/logies#capaciteit")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "quantitative-values"
)
(define-resource property-value
   :class (s-url "http://schema.org/PropertyValue")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (unit-text :string ,(s-url "http://schema.org/unitText"))
               
               (value :string ,(s-url "http://schema.org/value"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "http://schema.org/additionalProperty")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "http://schema.org/additionalProperty")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "property-values"
)
(define-resource rating
   :class (s-url "http://schema.org/Rating")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (best-rating :string ,(s-url "http://schema.org/bestRating"))
               
               (rating-value :string ,(s-url "http://schema.org/ratingValue"))
               
               (worst-rating :string ,(s-url "http://schema.org/worstRating"))
               
                )
   :has-many `(
               
               (tourist-attraction :via ,(s-url "http://schema.org/starRating")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "http://schema.org/starRating")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "ratings"
)
(define-resource registratie
   :class (s-url "https://data.vlaanderen.be/ns/logies#Registratie")
   :properties `(
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
                )
   :has-many `(
               
               (generation :via ,(s-url "http://www.w3.org/ns/prov#qualifiedGeneration")
                                         
                      :as "qualified-generation")
               
               (identifier :via ,(s-url "http://www.w3.org/ns/adms#identifier")
                                         
                      :as "identifier")
               
               (tourist-attraction :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftRegistratie")
                      :inverse t                   
                      :as "tourist-attraction")
               
               (logies :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftRegistratie")
                      :inverse t                   
                      :as "logies")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "registraties"
)
(define-resource tourist-attraction
   :class (s-url "http://schema.org/TouristAttraction")
   :properties `(
               
               (modified :datetime ,(s-url "http://purl.org/dc/terms/modified"))
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (received-fire-safety-advice :boolean ,(s-url "http://linked.toerismevlaanderen.be/vocabularies/accessibility/receivedFireSafetyAdvice"))
               
               (name :string ,(s-url "http://schema.org/name"))
               
               (aantal-slaapplaatsen :integer ,(s-url "https://data.vlaanderen.be/ns/logies#aantalSlaapplaatsen"))
               
               (aantal-verhuureenheden :integer ,(s-url "https://data.vlaanderen.be/ns/logies#aantalVerhuureenheden"))
               
               (alternative-name :string ,(s-url "http://schema.org/alternativeName"))
               
                )
   :has-many `(
               
               (contact-point :via ,(s-url "http://schema.org/contactPoint")
                                         
                      :as "contact-point")
               
               (identifier :via ,(s-url "http://www.w3.org/ns/adms#identifier")
                                         
                      :as "identifier")
               
               (kwaliteitslabel :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftKwaliteitslabel")
                                         
                      :as "heeft-kwaliteitslabel")
               
               (quantitative-value :via ,(s-url "https://data.vlaanderen.be/ns/logies#capaciteit")
                                         
                      :as "capaciteit")
               
               (rating :via ,(s-url "http://schema.org/starRating")
                                         
                      :as "star-rating")
               
               (registratie :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftRegistratie")
                                         
                      :as "heeft-registratie")
               
               (address :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalAdres")
                                         
                      :as "onthaal-adres")
               
               (point :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                                         
                      :as "onthaal-locatie")
               
               (geometry :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                                         
                      :as "onthaal-locatie")
               
               (organisation :via ,(s-url "http://schema.org/offeredBy")
                                         
                      :as "offered-by")
               
               (property-value :via ,(s-url "http://schema.org/additionalProperty")
                                         
                      :as "additional-property")
               
               (accessibility-information :via ,(s-url "http://purl.org/dc/terms/subject")
                      :inverse t                   
                      :as "accessibility-information")
               
               (government-permit :via ,(s-url "http://purl.org/dc/terms/subject")
                      :inverse t                   
                      :as "government-permit")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
               (organisation :via ,(s-url "http://schema.org/owns")
                      :inverse t                   
                      :as "organisation")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "tourist-attractions"
)
(define-resource logies
   :class (s-url "https://data.vlaanderen.be/ns/logies#Logies")
   :properties `(
               
               (modified :datetime ,(s-url "http://purl.org/dc/terms/modified"))
               
               (uuid :string ,(s-url "http://mu.semte.ch/vocabularies/core/uuid"))
               
               (received-fire-safety-advice :boolean ,(s-url "http://linked.toerismevlaanderen.be/vocabularies/accessibility/receivedFireSafetyAdvice"))
               
               (name :string ,(s-url "http://schema.org/name"))
               
               (aantal-slaapplaatsen :integer ,(s-url "https://data.vlaanderen.be/ns/logies#aantalSlaapplaatsen"))
               
               (aantal-verhuureenheden :integer ,(s-url "https://data.vlaanderen.be/ns/logies#aantalVerhuureenheden"))
               
               (alternative-name :string ,(s-url "http://schema.org/alternativeName"))
               
                )
   :has-many `(
               
               (contact-point :via ,(s-url "http://schema.org/contactPoint")
                                         
                      :as "contact-point")
               
               (identifier :via ,(s-url "http://www.w3.org/ns/adms#identifier")
                                         
                      :as "identifier")
               
               (kwaliteitslabel :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftKwaliteitslabel")
                                         
                      :as "heeft-kwaliteitslabel")
               
               (quantitative-value :via ,(s-url "https://data.vlaanderen.be/ns/logies#capaciteit")
                                         
                      :as "capaciteit")
               
               (rating :via ,(s-url "http://schema.org/starRating")
                                         
                      :as "star-rating")
               
               (registratie :via ,(s-url "https://data.vlaanderen.be/ns/logies#heeftRegistratie")
                                         
                      :as "heeft-registratie")
               
               (address :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalAdres")
                                         
                      :as "onthaal-adres")
               
               (point :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                                         
                      :as "onthaal-locatie")
               
               (geometry :via ,(s-url "https://data.vlaanderen.be/ns/logies#onthaalLocatie")
                                         
                      :as "onthaal-locatie")
               
               (organisation :via ,(s-url "http://schema.org/offeredBy")
                                         
                      :as "offered-by")
               
               (property-value :via ,(s-url "http://schema.org/additionalProperty")
                                         
                      :as "additional-property")
               
               (accessibility-information :via ,(s-url "http://purl.org/dc/terms/subject")
                      :inverse t                   
                      :as "accessibility-information")
               
               (government-permit :via ,(s-url "http://purl.org/dc/terms/subject")
                      :inverse t                   
                      :as "government-permit")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                      :inverse t                   
                      :as "statement")
               
               (statement :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                      :inverse t                   
                      :as "statement")
               
               (organisation :via ,(s-url "http://schema.org/owns")
                      :inverse t                   
                      :as "organisation")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "logiess"
)
(define-resource statement
   :class (s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#Statement")
   :properties `(
               
               (object :string ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object"))
               
               (object :datetime ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object"))
               
               (object :string ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object"))
               
               (object :integer ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object"))
               
               (object :boolean ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object"))
               
                )
   :has-many `(
               
               (address :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (accessibility-information :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (identifier :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (identifier :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (address :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (contact-point :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (contact-point :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (geometry :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (point :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (generation :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (geometry :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (point :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (generation :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (organisation :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (government-permit :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (organisation :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (registratie :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (kwaliteitslabel :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (rating :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (quantitative-value :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (property-value :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (kwaliteitslabel :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (rating :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (quantitative-value :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (property-value :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (registratie :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (tourist-attraction :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (logies :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#object")
                                         
                      :as "object")
               
               (tourist-attraction :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
               (logies :via ,(s-url "http://www.w3.org/1999/02/22-rdf-syntax-ns#subject")
                                         
                      :as "subject")
               
              )
   :resource-base(s-url "http://example.com/catalog/")
   :on-path "statements"
)
