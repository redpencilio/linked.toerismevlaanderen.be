(define-resource tourist-attraction ()
  :class (s-prefix "schema:TouristAttraction")
  :properties `((:name :language-string-set ,(s-prefix "schema:name"))
                 (:alternative-name :language-string-set ,(s-prefix "schema:alternativeName"))
                 (:type :url ,(s-prefix "dct:type"))
                 (:keywords :string-set ,(s-prefix "schema:keywords"))
                 (:opening-hours :lang-string-set ,(s-prefix "schema:openingHours"))
                 (:accepts-reservations :boolean ,(s-prefix "schema:acceptsReservations"))
                 (:modified :string-set ,(s-prefix "dct:modified")))
  :has-one `((address :via ,(s-prefix "locn:address")
               :as "address")
              (geometry :via ,(s-prefix "locn:geometry")
                :as "location")
              (touristic-region :via ,(s-prefix "tvl:belongsToStatisticalRegion")
                :as "statistical-regions")
              (description :via ,(s-prefix "schema:accessibilitySummary")
                :as "accessibility-summary")
              (accessibility-information :via ,(s-prefix "dct:subject")
                :inverse t
                :as "accessibility-information"))
  :has-many `((identifier :via ,(s-prefix "adms:identifier")
                :as "identifiers")
               (touristic-region :via ,(s-prefix "logies:behoortTotToeristischeRegio")
                 :as "touristic-regions")
               (contact-point :via ,(s-prefix "schema:contactPoint")
                 :as "contact-points")
               (quality-label :via ,(s-prefix "logies:heeftKwaliteitslabel")
                 :as "quality-labels")
               (description :via ,(s-prefix "logies:heeftBeschrijving")
                 :as "descriptions")
               (media-object :via ,(s-prefix "logies:heeftMedia")
                 :as "media")
               (media-object :via ,(s-prefix "schema:image")
                 :as "main-media"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/tourist-attractions/")
  :on-path "tourist-attractions")

(define-resource lodging ()
  :class (s-prefix "logies:Logies")
  :properties `((:fod-identifier :string ,(s-prefix "dct:identifier"))
                 (:received-fire-safety-advice :boolean ,(s-prefix "tvl:receivedFireSafetyAdvice"))
                 (:number-of-sleeping-places :number ,(s-prefix "logies:aantalSlaapplaatsen"))
                 (:number-of-rental-units :number ,(s-prefix "logies:aantalVerhuureenheden")))
  :has-one `((address :via ,(s-prefix "logies:onthaalAdres")
               :as "welcome-addresses")
              (geometry :via ,(s-prefix "logies:onthaalLocatie")
                :as "welcome-location")
              (organization :via ,(s-prefix "schema:offeredBy")
                :as "offering-agent")
              (organization :via ,(s-prefix "schema:owns")
                :as "owner"))
  :has-many `((registration :via ,(s-prefix "logies:heeftRegistratie")
                :as "registrations")
               (lodging :via ,(s-prefix "logies:heeftAlternatieveUitbating")
                 :as "alternative-exploitations")
               (lodging :via ,(s-prefix "logies:heeftAlternatieveUitbating")
                 :inverse t
                 :as "is-alternative-exploitation-of")
               (quantitative-value :via ,(s-prefix "logies:capaciteit")
                 :as "capacities")
               (property-value :via ,(s-prefix "schema:additionalProperties")
                 :as "properties")
               (government-permit :via ,(s-prefix "dct:subject")
                 :inverse t
                 :as "permits")
               (rating :via ,(s-prefix "schema:starRating")
                 :as "official-ratings")
               (facility :via ,(s-prefix "schema:amenityFeature")
                 :as "facilities"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/lodgings/")
  :on-path "lodgings")

(define-resource identifier ()
  :class (s-prefix "adms:Identifier")
  :properties `((:notation :string ,(s-prefix "skos:notation"))
                 (:issued-by :string ,(s-prefix "adms:schemaAgency")))
  :has-one `((registered-organization :via ,(s-prefix "dct:creator") ;; AP defines superclass dct:Agent
               :as "creator")
              (tourist-attraction :via ,(s-prefix "adms:identifier")
                :inverse t
                :as "tourist-attraction")
              (registration :via ,(s-prefix "adms:identifier")
                :inverse t
                :as "registration"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/identifiers/")
  :on-path "identifiers")

(define-resource registration ()
  :class (s-prefix "logies:Registratie")
  :properties `((:issued-date :datetime ,(s-prefix "dct:issued")))
  :has-one `((identifier :via ,(s-prefix "adms:identifier")
               :as "identifier")
              (concept :via ,(s-prefix "logies:registratieStatus")
                :as "registration-status")
              (concept :via ,(s-prefix "dct:type")
                :as "type")
              (concept :via ,(s-prefix "tvl:category")
                :as "category")
              (lodging :via ,(s-prefix "logies:heeftRegistratie")
                :inverse t
                :as "lodging")
              (generation :via ,(s-prefix "prov:qualifiedGeneration")
                :inverse t
                :as "generation")
              (invalidation :via ,(s-prefix "prov:qualifiedInvalidation")
                :inverse t
                :as "invalidation"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/registrations/")
  :on-path "registrations")

(define-resource generation ()
  :class (s-prefix "prov:Generation")
  :properties `((:date :datetime ,(s-prefix "prov:atTime")))
  :has-one `((registration :via ,(s-prefix "prov:qualifiedGeneration")
               :inverse t
               :as "registration"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/generations/")
  :on-path "generations")

(define-resource invalidation ()
  :class (s-prefix "prov:Invalidation")
  :properties `((:date :datetime ,(s-prefix "prov:atTime")))
  :has-one `((registration :via ,(s-prefix "prov:qualifiedInvalidation")
               :inverse t
               :as "registration"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/invalidations/")
  :on-path "invalidations")

(define-resource address ()
  :class (s-prefix "locn:Address")
  :properties `((:thoroughfare :string ,(s-prefix "locn:thoroughfare"))
                 (:house-number :string ,(s-prefix "adres:Adresvoorstelling.huisnummer"))
                 (:house-number-suffix :string ,(s-prefix "adres:Adresvoorstelling.busnummer"))
                 (:post-code :string ,(s-prefix "locn:postCode"))
                 (:municipality :language-string-set ,(s-prefix "adres:gemeentenaam"))
                 (:province :language-string-set ,(s-prefix "locn:adminUnitL2"))
                 (:country :language-string-set ,(s-prefix "adres:land")))
  :has-one `((tourist-attraction :via ,(s-prefix "locn:address")
               :inverse t
               :as "tourist-attraction")
              (lodging :via ,(s-prefix "logies:onthaalAdres")
                :inverse t
                :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/addresses/")
  :on-path "addresses")

(define-resource geometry ()
  :class (s-prefix "locn:Geometry")
  :properties `((:as-gml :string ,(s-prefix "geosparql:asGML"))
                 (:as-wkt :string ,(s-prefix "geosparql:asWKT")))
  :has-one `((tourist-attraction :via ,(s-prefix "locn:location")
               :inverse t
               :as "tourist-attraction")
              (lodging :via ,(s-prefix "logies:onthaalLocatie")
                :inverse t
                :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/geometries/")
  :on-path "geometries")

(define-resource touristic-region ()
  :class (s-prefix "logies:ToeristischeRegio")
  :properties `((:label :language-string-set ,(s-prefix "rdfs:label")))
  :has-many `((tourist-attraction :via ,(s-prefix "logies:behoortTotToeristischeRegio")
                :inverse t
                :as "tourist-attraction")
               (tourist-attraction :via ,(s-prefix "tvl:belongsToStatisticalRegion")
                 :inverse t
                 :as "statistical-tourist-attractions"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/touristic-regions/")
  :on-path "touristic-regions")

(define-resource contact-point ()
  :class (s-prefix "schema:ContactPoint")
  :properties `((:name :string ,(s-prefix "foaf:name"))
                 (:honorific-prefix :language-string-set ,(s-prefix "vcard:honorific-prefix"))
                 (:first-name :string ,(s-prefix "foaf:firstName"))
                 (:last-name :string ,(s-prefix "foaf:givenName"))
                 (:email :string ,(s-prefix "schema:email"))
                 (:fax :string ,(s-prefix "schema:faxNumber"))
                 (:page :url ,(s-prefix "foaf:page"))
                 (:telephone :string ,(s-prefix "schema:telephone")))
  :has-one `((tourist-attraction :via ,(s-prefix "schema:contactPoint")
               :inverse t
               :as "tourist-attraction")
              (organization :via ,(s-prefix "schema:contactPoint")
                :inverse t
                :as "organization")
              (address :via ,(s-prefix "locn:address")
                :inverse t
                :as "address"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/contact-points/")
  :on-path "contact-points")

(define-resource media-object ()
  :class (s-prefix "schema:MediaObject")
  :properties `((:content-url :url ,(s-prefix "schema:contentUrl")))
  :has-many `((tourist-attraction :via ,(s-prefix "logies:heeftMedia")
                :inverse t
                :as "tourist-attractions")
               (tourist-attraction :via ,(s-prefix "schema:image")
                 :inverse t
                 :as "main-image-of-tourist-attractions"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/media-objects/")
  :on-path "media-objects")

(define-resource quality-label ()
  :class (s-prefix "logies:Kwaliteitslabel")
  :properties `((:label :language-string-set ,(s-prefix "skos:prefLabel")))
  :has-one `((registered-organization :via ,(s-prefix "schema:author")
               :as "author"))
  :has-many `((tourist-attraction :via ,(s-prefix "logies:heeftKwaliteitslabel")
                :inverse t
                :as "tourist-attractions"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/quality-labels/")
  :on-path "quality-labels")

(define-resource description ()
  :class (s-prefix "logies:Beschrijving")
  :properties `((:text :language-string-set ,(s-prefix "schema:value")))
  :has-one `((tourist-attraction :via ,(s-prefix "logies:heeftBeschrijving")
               :inverse t
               :as "subject"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/descriptions/")
  :on-path "descriptions")

(define-resource accessibility-information ()
  :class (s-prefix "tvl:AccessibilityInformation")
  :properties `((:accessibility-summary :language-string-set ,(s-prefix "schema:accessibilitySummary"))
                 (:description :language-string-set ,(s-prefix "schema:description"))
                 (:information-about-allergies :language-string-set ,(s-prefix "tvl:informationAboutAllergies"))
                 (:information-about-appartement :language-string-set ,(s-prefix "tvl:informationAboutAppartement"))
                 (:information-about-bedroom :language-string-set ,(s-prefix "tvl:informationAboutBedroom"))
                 (:information-about-common-toilet-facilities :language-string-set ,(s-prefix "tvl:informationAboutCommonToiletFacilities"))
                 (:information-about-dining-room :language-string-set ,(s-prefix "tvl:informationAboutDiningRoom"))
                 (:information-about-exhibition-space :language-string-set ,(s-prefix "tvl:informationAboutExhibitionSpace"))
                 (:information-about-extra-care :language-string-set ,(s-prefix "tvl:informationAboutExtraCare"))
                 (:information-about-extra-facilities :language-string-set ,(s-prefix "tvl:informationAboutExtraFacilities"))
                 (:information-about-food-allergies :language-string-set ,(s-prefix "tvl:informationAboutFoodAllergies"))
                 (:information-about-garden :language-string-set ,(s-prefix "tvl:informationAboutGarden"))
                 (:information-about-living-space :language-string-set ,(s-prefix "tvl:informationAboutLivingSpace"))
                 (:information-about-parking :language-string-set ,(s-prefix "tvl:informationAboutParking"))
                 (:information-about-pitch :language-string-set ,(s-prefix "tvl:informationAboutPitch"))
                 (:information-about-playground :language-string-set ,(s-prefix "tvl:informationAboutPlayground"))
                 (:information-about-restaurant :language-string-set ,(s-prefix "tvl:informationAboutRestaurant"))
                 (:information-about-resting-points :language-string-set ,(s-prefix "tvl:informationAboutRestingPoints"))
                 (:information-about-room :language-string-set ,(s-prefix "tvl:informationAboutRoom"))
                 (:information-about-route-and-levels :language-string-set ,(s-prefix "tvl:informationAboutRouteAndLevels"))
                 (:information-about-shop :language-string-set ,(s-prefix "tvl:informationAboutShop"))
                 (:information-about-table-space :language-string-set ,(s-prefix "tvl:informationAboutTableSpace"))
                 (:information-about-toilet-facilities :language-string-set ,(s-prefix "tvl:informationAboutToiletFacilities"))
                 (:information-for-auditive-handicap :language-string-set ,(s-prefix "tvl:informationForAuditiveHandicap"))
                 (:information-for-autism :language-string-set ,(s-prefix "tvl:informationForAutism"))
                 (:information-for-blind :language--string-set ,(s-prefix "tvl:informationForBlind"))
                 (:information-for-deaf :language-string-set ,(s-prefix "tvl:informationForDeaf"))
                 (:information-for-mental-handicap :language-string-set ,(s-prefix "tvl:informationForMentalHandicap"))
                 (:information-for-motorical-handicap :language-string-set ,(s-prefix "tvl:informationForMotoricalHandicap"))
                 (:information-for-visual-andicap :language-string-set ,(s-prefix "tvl:informationForVisualHandicap"))
                 (:information-about-entrances :language-string-set ,(s-prefix "tvl:informationAboutEntrances"))
                 (:support-for-allergies :boolean ,(s-prefix "tvl:supportForAllergies"))
                 (:support-for-auditive-handicap :boolean ,(s-prefix "tvl:supportForAuditiveHandicap"))
                 (:support-for-autism :boolean ,(s-prefix "tvl:supportForAutism"))
                 (:support-for-blind :boolean ,(s-prefix "tvl:supportForBlind"))
                 (:support-for-deaf :boolean ,(s-prefix "tvl:supportForDeaf"))
                 (:support-for-extra-care :boolean ,(s-prefix "tvl:supportForExtraCare"))
                 (:support-for-food-allergies :boolean ,(s-prefix "tvl:supportForFoodAllergies"))
                 (:support-for-mental-handicap :boolean ,(s-prefix "tvl:supportForMentalHandicap"))
                 (:support-for-motorical-handicap :boolean ,(s-prefix "tvl:supportForMotoricalHandicap"))
                 (:support-for-visual-handicap :boolean ,(s-prefix "tvl:supportForVisualHandicap")))
  :has-one `((tourist-attraction :via ,(s-prefix "dct:subject")
               :as "tourist-attraction"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/accessibility-information/")
  :on-path "accessibility-information")

(define-resource rating ()
  :class (s-prefix "schema:Rating")
  :properties `((:rating-value :string ,(s-prefix "schema:ratingValue"))
                 (:best-rating :string ,(s-prefix "schema:bestRating"))
                 (:worst-rating :string ,(s-prefix "schema:worstRating")))
  :has-one `((registered-organization :via ,(s-prefix "schema:author")
               :as "author")
              (lodging :via ,(s-prefix "schema:starRating")
                :inverse t
                :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/ratings/")
  :on-path "ratings")

(define-resource quantitative-value ()
  :class (s-prefix "schema:QuantitativeValue")
  :properties `((:unit :language-string-set ,(s-prefix "schema:unitText"))
                 (:value :number ,(s-prefix "schema:value")))
  :has-one `((lodging :via ,(s-prefix "logies:capaciteit")
               :inverse t
               :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/quantitative-values/")
  :on-path "quantitative-values")

(define-resource property-value ()
  :class (s-prefix "schema:PropertyValue")
  :properties `((:unit :language-string-set ,(s-prefix "schema:unitText"))
                 (:value :number ,(s-prefix "schema:value")))
  :has-one `((lodging :via ,(s-prefix "schema:additionalProperty")
               :inverse t
               :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/property-values/")
  :on-path "property-values")

(define-resource government-permit ()
  :class (s-prefix "schema:GovernmentPermit")
  :properties `((:name :language-string-set ,(s-prefix "schema:name"))
                 (:valid-until :datetime ,(s-prefix "schema:validUntil")))
  :has-one `((lodging :via ,(s-prefix "dct:subject")
               :inverse t
               :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/property-values/")
  :on-path "government-permits")

(define-resource facility ()
  :class (s-prefix "logies:Faciliteit")
  :properties `((:name :language-string-set ,(s-prefix "schema:name"))
                 (:description :language-string-set ,(s-prefix "schema:description")))
  :has-one `((facility :via ,(s-prefix "logies:isSpecialisatieVan")
               :as "is-specialisation-of"))
  :has-many `((facility :via ,(s-prefix "logies:isSpecialisatieVan")
                :inverse t
                :as "specialisations")
               (lodging :via ,(s-prefix "schema:amenityFeature")
                 :inverse t
                 :as "lodgings"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/facilities/")
  :on-path "facilities")

(define-resource organization ()
  :class (s-prefix "org:Organisation")
  :properties `((:legal-name :language-string-set ,(s-prefix "skos:prefLabel")))
  :has-one `((identifier :via ,(s-prefix "adms:identifier")
               :as "identifier"))
  :has-many `((contact-point :via ,(s-prefix "schema:contactPoint")
                :inverse t
                :as "contact-points")
               (lodging :via ,(s-prefix "schema:offeredBy")
                 :inverse t
                 :as "offered-lodgings")
               (lodging :via ,(s-prefix "schema:owns")
                 :inverse t
                 :as "owned-lodgings"))
  :features '(include-uri)
  :resource-base (s-url "http://linked-toerismevlaanderen.be/id/organizations/")
  :on-path "organizations")

(define-resource registered-organization ()
  :class (s-prefix "regorg:RegisteredOrganization")
  :properties `((:legal-name :language-string-set ,(s-prefix "regorg:legalName")))
  :has-one `((identifier :via ,(s-prefix "regorg:registration")
               :as "registration"))
  :has-many `((rating :via ,(s-prefix "schema:author")
                :inverse t
                :as "authored-ratings")
               (quality-label :via ,(s-prefix "schema:author")
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