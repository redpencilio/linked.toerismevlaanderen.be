;;;;;;
;;;
;;; Classes specified in Logies AP
;;;
;;;;;;

;; (define-resource agent ()
;;   :class (s-prefix "dct:Agent")
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/agents/")
;;   :on-path "agents")

(define-resource rating ()
  :class (s-prefix "schema:Rating")
  :properties `((:rating-value :string ,(s-prefix "schema:ratingValue"))
                ;; (:description :language-string-set ,(s-prefix "schema:description"))
                (:best-rating :string ,(s-prefix "schema:bestRating"))
                (:worst-rating :string ,(s-prefix "schema:worstRating")))
                ;; (:issued-date :datetime ,(s-prefix "dct:issued")))
  :has-one `((registered-organization :via ,(s-prefix "ext:ratingAuthor") ;; subprop of schema:author
                                      :as "author")
             (lodging :via ,(s-prefix "schema:starRating")
                      :inverse t
                      :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/ratings/")
  :on-path "ratings")

(define-resource description ()
  :class (s-prefix "logies:Beschrijving")
  :properties `((:text :language-string-set ,(s-prefix "schema:value")))
                ;; (:modified-on :datetime ,(s-prefix "schema:dateModified"))
                ;; (:name :language-string-set ,(s-prefix "schema:name"))
                ;; (:publication-date :datetime ,(s-prefix "schema:datePublished")))
  ;;; TODO add 'heeft_auteur ?
  :has-one `(;; (creative-work :via ,(s-prefix "schema:exampleOfWork")
             ;;                :as "example-of")
             ;; (creative-work :via ,(s-prefix "schema:translationOfWork")
             ;;                :as "translation-of")
             ;; (license :via ,(s-prefix "schema:license")
             ;;          :as "license")
             ;; (audience :via ,(s-prefix "schema:audience")
             ;;           :as "audience")
             (lodging :via ,(s-prefix "logies:heeftBeschrijving")
                      :inverse t
                      :as "subject"))
  ;; :has-many `((creative-work :via ,(s-prefix "schema:exampleOfWork")
  ;;                            :inverse t
  ;;                            :as "examples")
  ;;             (creative-work :via ,(s-prefix "schema:translationOfWork")
  ;;                            :inverse t
  ;;                            :as "translations"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/descriptions/")
  :on-path "descriptions")

;; (define-resource creative-work ()
;;   :class (s-prefix "schema:CreativeWork")
;;   :properties `((:modified-on :datetime ,(s-prefix "schema:dateModified"))
;;                 (:name :language-string-set ,(s-prefix "schema:name"))
;;                 (:publication-date :datetime ,(s-prefix "schema:datePublished")))
;;   ;;; TODO add 'heeft_auteur ?
;;   :has-one `((creative-work :via ,(s-prefix "schema:exampleOfWork")
;;                             :as "example-of")
;;              (creative-work :via ,(s-prefix "schema:translationOfWork")
;;                             :as "translation-of")
;;              (license :via ,(s-prefix "schema:license")
;;                       :as "license")
;;              (audience :via ,(s-prefix "schema:audience")
;;                        :as "audience"))
;;   :has-many `((creative-work :via ,(s-prefix "schema:exampleOfWork")
;;                              :inverse t
;;                              :as "examples")
;;               (creative-work :via ,(s-prefix "schema:translationOfWork")
;;                              :inverse t
;;                              :as "translations"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/creative-works/")
;;   :on-path "creative-works")

(define-resource facility ()
  :class (s-prefix "logies:Faciliteit")
  :properties `(;; (:valid-through :datetime ,(s-prefix "schema:validThrough"))
                ;; (:valid-from :datetime ,(s-prefix "schema:validFrom"))
                (:name :language-string-set ,(s-prefix "schema:name"))
                (:description :language-string-set ,(s-prefix "schema:description")))
  :has-one `((facility :via ,(s-prefix "logies:isSpecialisatieVan")
                       :as "is-specialisation-of"))
  :has-many `((facility :via ,(s-prefix "logies:isSpecialisatieVan")
                        :inverse t
                        :as "specialisations"))
              ;; (lodging :via ,(s-prefix "schema:amenityFeature")
              ;;          :inverse t
              ;;          :as "lodgings")
              ;; (rental-unit :via ,(s-prefix "schema:amenityFeature")
              ;;              :inverse t
              ;;              :as "rental-units")
              ;; (room :via ,(s-prefix "schema:amenityFeature")
              ;;       :inverse t
              ;;       :as "rooms"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/facilities/")
  :on-path "facilities")

(define-resource registered-organization ()
  :class (s-prefix "regorg:RegisteredOrganization")
  :properties `((:legal-name :language-string-set ,(s-prefix "regorg:legalName")))
                ;; (:legal-personality :url ,(s-prefix "organisatie:rechtspersoonlijkheid"))
                ;; (:legal-form :url ,(s-prefix "organisatie:rechtsvorm"))
                ;; (:legal-status :url ,(s-prefix "organisatie:rechtstoestand")))
  :has-one `((identifier :via ,(s-prefix "regorg:registration")
                         :as "registration"))
  :has-many `((rating :via ,(s-prefix "ext:ratingAuthor") ;; subprop of schema:author
                      :inverse t
                      :as "authored-ratings")
              (quality-label :via ,(s-prefix "ext:qualityLabelAuthor") ;; subprop of schema:author
                             :inverse t
                             :as "authored-quality-labels")
              (identifier :via ,(s-prefix "dct:creator")
                          :inverse t
                          :as "issued-identifiers")
              (registration :via ,(s-prefix "logies:verantwoordelijkeOrganisatie")
                            :inverse t
                            :as "registrations"))
  :features '(include-uri)
  :resource-base (s-url "http://linked-toerismevlaanderen.be/id/registered-organizations/")
  :on-path "registered-organizations")

(define-resource quality-label ()
  :class (s-prefix "logies:Kwaliteitslabel")
  :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
                ;; (:description :language-string-set ,(s-prefix "schema:description"))
                ;; (:issued-date :datetime ,(s-prefix "dct:issued")))
  :has-one `((registered-organization :via ,(s-prefix "ext:qualityLabelAuthor") ;; subprop of schema:author
                                      :as "author"))
  :has-many `((lodging :via ,(s-prefix "logies:heeftKwaliteitslabel")
                       :inverse t
                       :as "lodgings"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/quality-labels/")
  :on-path "quality-labels")

(define-resource lodging ()
  :class (s-prefix "logies:Logies")
  :properties `((:name :language-string-set ,(s-prefix "schema:name"))
                (:alternative-name :language-string-set ,(s-prefix "schema:alternativeName"))
                (:number-of-sleeping-places :number ,(s-prefix "logies:aantalSlaapplaatsen"))
                (:number-of-rental-units :number ,(s-prefix "logies:aantalVerhuureenheden")))
  :has-one `((identifier :via ,(s-prefix "ext:lodgingIdentifier") ;; subprop of adms:identifier
                         :as "identifier")
             (geometry :via ,(s-prefix "logies:onthaalLocatie")
                    :as "welcome-location"))
  :has-many `((address :via ,(s-prefix "logies:onthaalAdres")
                       :as "welcome-addresses")
              (touristic-region :via ,(s-prefix "logies:behoortTotToeristischeRegio")
                                :as "belongs-to-touristic-regions")
              (contact-point :via ,(s-prefix "schema:contactPoint")
                             :as "contact-points")
              (quantitative-value :via ,(s-prefix "logies:capaciteit")
                                  :as "capacities")
              (lodging :via ,(s-prefix "logies:heeftAlternatieveUitbating")
                       :as "alternative-exploitations")
              (lodging :via ,(s-prefix "logies:heeftAlternatieveUitbating")
                       :inverse t
                       :as "is-alternative-exploitation-of")
              (registration :via ,(s-prefix "logies:heeftRegistratie")
                            :as "registrations")
              (rating :via ,(s-prefix "schema:starRating")
                      :as "official-ratings")
              (quality-label :via ,(s-prefix "logies:heeftKwaliteitslabel")
                             :as "quality-labels")
              (description :via ,(s-prefix "logies:heeftBeschrijving")
                           :as "descriptions")
              (media-object :via ,(s-prefix "logies:heeftMedia")
                            :as "media"))
              ;; (audience :via ,(s-prefix "schema:audience")
              ;;           :as "audiences")
              ;; (facility :via ,(s-prefix "schema:amenityFeature")
              ;;           :as "facilities")
              ;; (rental-unit :via ,(s-prefix "logies:heeftVerhuureenheid")
              ;;              :as "rental-units")              
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/lodgings/")
  :on-path "lodgings")

(define-resource media-object ()
  :class (s-prefix "schema:MediaObject")
  :properties `((:content-url :url ,(s-prefix "schema:contentUrl")))
                ;; (:modified-on :datetime ,(s-prefix "schema:dateModified"))
                ;; (:name :language-string-set ,(s-prefix "schema:name"))
                ;; (:publication-date :datetime ,(s-prefix "schema:datePublished"))
                ;; (:description :language-string-set ,(s-prefix "schema:description"))
                ;; (:caption :language-string-set ,(s-prefix "schema:caption"))
                ;; (:exif-data :url ,(s-prefix "schema:exifDate"))
                ;; (:thumbnail-url :url ,(s-prefix "schema:thumbnailUrl")))
  ;;; TODO add 'heeft_auteur ?
  ;; :has-one `((creative-work :via ,(s-prefix "schema:isBasedOn")
  ;;                           :as "based-on")
  ;;            (creative-work :via ,(s-prefix "schema:translationOfWork")
  ;;                           :as "translation-of")
  ;;            (license :via ,(s-prefix "schema:license")
  ;;                     :as "license")
  ;;            (audience :via ,(s-prefix "schema:audience")
  ;;                      :as "audience")
  ;;            (file-format :via ,(s-prefix "dct:format")
  ;;                         :as "format")
  ;;            (quantitative-value :via ,(s-prefix "schema:width")
  ;;                                :as "width")
  ;;            (quantitative-value :via ,(s-prefix "schema:height")
  ;;                                :as "height")
  ;;            (geometry :via ,(s-prefix "logies:locatie")
  ;;                      :as "location"))
  :has-many `((lodging :via ,(s-prefix "logies:heeftMedia")
                       :inverse t
                       :as "lodgings"))
              ;; (creative-work :via ,(s-prefix "schema:isBasedOn")
              ;;                :inverse t
              ;;                :as "derivations")
              ;; (creative-work :via ,(s-prefix "schema:translationOfWork")
              ;;                :inverse t
              ;;                :as "translations")
              ;; (language :via ,(s-prefix "schema:inLanguage")
              ;;           :as "languages"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/media-objects/")
  :on-path "media-objects")

(define-resource registration ()
  :class (s-prefix "logies:Registratie")
  :properties `((:issued-date :datetime ,(s-prefix "dct:issued")))
  :has-one `((identifier :via ,(s-prefix "ext:registrationIdentifier") ;; subprop of adms:identifier
                         :as "identifier")
             (concept :via ,(s-prefix "logies:registratieStatus")
                      :as "registration-status")
             (concept :via ,(s-prefix "dct:type")
                      :as "type")
             (concept :via ,(s-prefix "ext:tvlCategory")
                      :as "category")
             (lodging :via ,(s-prefix "logies:heeftRegistratie")
                      :inverse t
                      :as "lodging")
             (registered-organization :via ,(s-prefix "logies:verantwoordelijkeOrganisatie")
                                      :as "responsible-organization"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/registrations/")
  :on-path "registrations")

;; (define-resource room ()
;;   :class (s-prefix "logies:Ruimte")
;;   :properties `((:description :language-string-set ,(s-prefix "schema:description")))
;;   :has-many `((facility :via ,(s-prefix "schema:amenityFeature")
;;                         :as "facilities"))
;;   :has-one `((locator-designator :via ,(s-prefix "logies:locatieaanduiding")
;;                                  :as "locator-designator")
;;              (rental-unit :via ,(s-prefix "logies:heeftKamer") ;; TODO must this be has-many?
;;                           :inverse t
;;                           :as "rental-unit")
;;              (room-type :via ,(s-prefix "dct:type")
;;                         :as "type"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/rooms/")
;;   :on-path "rooms")

(define-resource touristic-region ()
  :class (s-prefix "logies:ToeristischeRegio")
  :properties `((:label :language-string-set ,(s-prefix "rdfs:label")))
  :has-many `((lodging :via ,(s-prefix "logies:behoortTotToeristischeRegio")
                       :inverse t
                       :as "contains-lodgings"))
              ;; (location :via ,(s-prefix "logies:bevatPlaats")
              ;;           :as "contains-location"))
  ;; :has-one `((geometry :via ,(s-prefix "locn:geometry")
  ;;                      :as "geometry"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/touristic-regions/")
  :on-path "touristic-regions")

;; (define-resource rental-unit ()
;;   :class (s-prefix "logies:Verhuureenheid")
;;   :properties `((:number-of-rooms :number ,(s-prefix "schema:numberOfRooms"))
;;                 (:number-of-sleeping-places :number ,(s-prefix "logies:aantalSlaapplaatsen"))
;;                 (:name :language-string-set ,(s-prefix "schema:name")))
;;   :has-many `((quantitative-value :via ,(s-prefix "logies:capaciteit")
;;                                  :as "capacities")
;;               (facility :via ,(s-prefix "schema:amenityFeature")
;;                         :as "facilities")
;;               (room :via ,(s-prefix "logies:heeftKamer")
;;                     :as "rooms")
;;               (lodging :via ,(s-prefix "logies:heeftVerhuureenheid")
;;                        :inverse t
;;                        :as "lodgings"))
;;   :has-one `( (geometry :via ,(s-prefix "logies:locatie")
;;                        :as "location"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/rental-units/")
;;   :on-path "rental-units")

;;;;;;
;;;
;;; Classes not specified in Logies AP
;;;
;;;;;;

;; (define-resource location ()
;;   :class (s-prefix "dct:Location")
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/locations/")
;;   :on-path "locations")


;; (define-resource license ()
;;   :class (s-prefix "dct:LicenseDocument")
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/licenses/")
;;   :on-path "licenses")

;;;;;;
;;;
;;; Datatypes
;;;
;;;;;;

(define-resource address ()
  :class (s-prefix "locn:Address")
  :properties `(;; (:admin-unit-level-1 :language-string-set ,(s-prefix "locn:adminUnitL1"))
                ;; (:admin-unit-level-2 :language-string-set ,(s-prefix "locn:adminUnitL2"))
                ;; (:address-area :language-string-set ,(s-prefix "locn:addressArea"))
                (:thoroughfare :string ,(s-prefix "locn:thoroughfare"))
                (:house-number :string ,(s-prefix "adres:Adresvoorstelling.huisnummer"))
                (:house-number-suffix :string ,(s-prefix "adres:Adresvoorstelling.busnummer"))
                (:post-code :string ,(s-prefix "locn:postCode"))
                (:municipality :language-string-set ,(s-prefix "adres:gemeentenaam"))
                (:country :language-string-set ,(s-prefix "adres:land")))
                ;; (:locator-designator :string ,(s-prefix "locn:locatorDesignator"))
                ;; (:locator-name :language-string-set ,(s-prefix "locn:locatorName"))
                ;; (:po-box :string ,(s-prefix "locn:poBox"))
                ;; (:post-name :string ,(s-prefix "locn:postName"))
                ;; (:references :url ,(s-prefix "adres:verwijstNaar"))
                ;; (:full-address :language-string-set ,(s-prefix "locn:fullAddress"))
  :has-one `((lodging :via ,(s-prefix "logies:onthaalAdres")
                      :inverse t
                      :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/addresses/")
  :on-path "addresses")

(define-resource contact-point ()
  :class (s-prefix "schema:ContactPoint")
  :properties `(;; (:honorific-prefix :language-string-set ,(s-prefix "vcard:honorific-prefix"))
                (:email :string ,(s-prefix "schema:email"))
                ;; (:fax :string ,(s-prefix "schema:faxNumber"))
                ;; (:name :string ,(s-prefix "foaf:name"))
                (:page :url ,(s-prefix "foaf:page"))
                (:telephone :string ,(s-prefix "schema:telephone")))
  :has-one `((lodging :via ,(s-prefix "schema:contactPoint")
                      :inverse t
                      :as "lodging"))
  ;;; TODO add openingsuren
  ;;; TOOD add uren beschikbaarheid
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/contact-points/")
  :on-path "contact-points")

(define-resource geometry ()
  :class (s-prefix "locn:Geometry")
  :properties `((:as-gml :string ,(s-prefix "geosparql:asGML"))
                (:as-wkt :string ,(s-prefix "geosparql:asWKT")))
  :has-one `((lodging :via ,(s-prefix "logies:onthaalLocatie")
                      :inverse t
                      :as "is-welcome-address-of"))
             ;; (media-object :via ,(s-prefix "logies:locatie")
             ;;               :inverse t
             ;;               :as "is-location-of")
             ;; (touristic-region :via ,(s-prefix "logies:locatie")
             ;;                   :inverse t
             ;;                   :as "touristic-region"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/geometries/")
  :on-path "geometries")

(define-resource identifier ()
  :class (s-prefix "adms:Identifier")
  :properties `((:notation :string ,(s-prefix "skos:notation"))
                (:issued-by :string ,(s-prefix "adms:schemaAgency")))
                ;; (:issued-date :datetime ,(s-prefix "dct:issued")))
  :has-one `((registered-organization :via ,(s-prefix "dct:creator") ;; AP defines superclass dct:Agent
                    :as "creator")
             (lodging :via ,(s-prefix "ext:lodgingIdentifier") ;; subprop of adms:identifier
                      :inverse t
                      :as "lodging")
             (registration :via ,(s-prefix "ext:registrationIdentifier") ;; subprop of adms:identifier
                           :inverse t
                           :as "registration"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/identifiers/")
  :on-path "identifiers")

(define-resource quantitative-value ()
  :class (s-prefix "schema:QuantitativeValue")
  :properties `((:unit :language-string-set ,(s-prefix "schema:unitText"))
                (:value :number ,(s-prefix "schema:value")))
  :has-one `((lodging :via ,(s-prefix "logies:capaciteit")
                      :inverse t
                      :as "is-capacity-of"))
             ;; (standardized-unit :via ,(s-prefix "schema:unitCode")
             ;;                    :as "standardized-unit")
             ;; (media-object :via ,(s-prefix "schema:width")
             ;;               :inverse t
             ;;               :as "is-width-of")
             ;; (media-object :via ,(s-prefix "schema:height")
             ;;               :inverse t
             ;;               :as "is-height-of"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/quatitative-values/")
  :on-path "quantitative-values")


;; (define-resource locator-designator ()
;;   :class (s-prefix "adres:Locatieaanduiding")
;;   :properties `((:designator :string ,(s-prefix "adres:Locatieaanduiding.aanduiding")))
;;   :has-one `((locator-designator-type :via ,(s-prefix "adres:Locatieaanduiding.type")
;;                                       :as "type"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/locator-designators/")
;;   :on-path "locator-designators")

;;;;;;
;;;
;;; Codelists
;;;
;;;;;;

(define-resource concept ()
  :class (s-prefix "skos:Concept")
  :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
  :features '(include-uri)
  :has-many `((conceptscheme :via ,(s-prefix "skos:inScheme")
                              :as "concept-schemes")
              (conceptscheme :via ,(s-prefix "skos:topConceptOf")
                             :as "top-concept-of")
              (concept :via ,(s-prefix "skos:broader")
                       :as "broader-concepts")
              (concept :via ,(s-prefix "skos:broader")
                       :inverse t
                       :as "narrower-concepts")
              (concept :via ,(s-prefix "skos:broadMatch")
                       :as "broad-matches")
              (concept :via ,(s-prefix "skos:broadMatch")
                       :inverse t
                       :as "narrower-matches"))
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/concepts/")
  :on-path "concepts")

(define-resource conceptscheme ()
  :class (s-prefix "skos:ConceptScheme")
  :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
  :features '(include-uri)
  :has-many `((concept :via ,(s-prefix "skos:inScheme")
                       :inverse t
                       :as "concepts")
              (concept :via ,(s-prefix "skos:topConceptOf")
                       :inverse t
                       :as "top-concepts"))
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/conceptschemes/")
  :on-path "conceptschemes")

;; (define-resource standardized-unit ()
;;   :class (s-prefix "ext:StandardizedUnit")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/standardized-units/")
;;   :on-path "standardized-units")

;; (define-resource audience ()
;;   :class (s-prefix "ext:Audience")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/audiences/")
;;   :on-path "audiences")

;; (define-resource language ()
;;   :class (s-prefix "ext:Language")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/languages/")
;;   :on-path "languages")

;; (define-resource file-format ()
;;   :class (s-prefix "ext:FileFormat")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/file-formats/")
;;   :on-path "file-formats")

;; (define-resource locator-designator-type ()
;;   :class (s-prefix "ext:LocatorDesignatorType")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://inspire.ec.europa.eu/codelist/LocatorDesignatorTypeValue/")
;;   :on-path "locator-designator-types")

;; (define-resource registration-status ()
;;   :class (s-prefix "ext:RegistrationStatus")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :has-one `((registration :via ,(s-prefix "logies:registratieStatus")
;;                            :inverse t
;;                            :as "registration"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/registration-statuses/")
;;   :on-path "registration-statuses")

;; (define-resource registration-lodging-type ()
;;   :class (s-prefix "ext:RegistrationLodgingType")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :has-one `((registration :via ,(s-prefix "dct:type")
;;                            :inverse t
;;                            :as "registration")
;;              (registration-publication-lodging-type :via ,(s-prefix "skos:broadMatch")
;;                            :as "registration-publication-type"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/registration-lodging-type/")
;;   :on-path "registration-lodging-types")

;; (define-resource registration-publication-lodging-type ()
;;   :class (s-prefix "ext:RegistrationPublicationLodgingType")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :has-many `((registration-lodging-type :via ,(s-prefix "skos:broadMatch")
;;                                          :inverse t
;;                                          :as "registration-types"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/registration-publication-lodging-type/")
;;   :on-path "registration-publication-lodging-types")

;; (define-resource room-type ()
;;   :class (s-prefix "ext:RoomType")
;;   :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
;;   :has-one `((room :via ,(s-prefix "dct:type")
;;                    :inverse t
;;                    :as "room"))
;;   :features '(include-uri)
;;   :resource-base (s-url "http://linked.toerismevlaanderen.be/id/room-type/")
;;   :on-path "room-types")
