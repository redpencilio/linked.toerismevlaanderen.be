(in-package :mu-cl-resources)

(defparameter *cache-count-queries* nil)
(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(setf *cache-model-properties-p* t)
(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *max-group-sorted-properties* nil)

(define-resource tourist-attraction ()
  :class (s-prefix "schema:TouristAttraction")
  :properties `((:name :language-string-set ,(s-prefix "schema:name"))
                 (:alternative-name :language-string-set ,(s-prefix "schema:alternativeName")))
  :has-one `((identifier :via ,(s-prefix "adms:identifier")
               :as "identifier"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/tourist-attractions/")
  :on-path "tourist-attractions")

(define-resource identifier ()
  :class (s-prefix "adms:Identifier")
  :properties `((:notation :string ,(s-prefix "skos:notation"))
                 (:issued-by :string ,(s-prefix "adms:schemaAgency")))
  :has-one `((tourist-atraction :via ,(s-prefix "adms:identifier")
               :inverse t
               :as "tourist-attraction"))
  :features '(include-uri)
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/identifiers/")
  :on-path "identifiers")

(read-domain-file "data-dumps-domain.lisp")
