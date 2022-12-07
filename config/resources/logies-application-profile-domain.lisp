(define-resource lodging ()
  :class (s-prefix "logies:Logies")
  :properties `((:name :language-string-set ,(s-prefix "schema:name"))
                (:alternative-name :language-string-set ,(s-prefix "schema:alternativeName")))
  :has-one `((identifier :via ,(s-prefix "ext:lodgingIdentifier") ;; subprop of adms:identifier
                         :as "identifier"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/lodgings/")
  :on-path "lodgings")

(define-resource identifier ()
  :class (s-prefix "adms:Identifier")
  :properties `((:notation :string ,(s-prefix "skos:notation"))
                (:issued-by :string ,(s-prefix "adms:schemaAgency")))
  :has-one `((lodging :via ,(s-prefix "ext:lodgingIdentifier") ;; subprop of adms:identifier
                      :inverse t
                      :as "lodging"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/identifiers/")
  :on-path "identifiers")
