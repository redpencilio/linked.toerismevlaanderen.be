(define-resource catalogs ()
  :class (s-prefix "dcat:Catalog")
  :properties `((:title :string ,(s-prefix "dct:title"))
                 (:description :string ,(s-prefix "dct:description"))
                 (:issued :datetime ,(s-prefix "dct:issued")))
  :has-many `((registered-organization :via ,(s-prefix "dct:publisher")
                :as "publishers")
               (datasets :via ,(s-prefix "dcat:dataset")
                 :as "datasets"))
  :resource-base(s-url "http://linked.toerismevlaanderen.be/id/catalogs/")
  :on-path "catalogs")

(define-resource datasets ()
  :class (s-prefix "dcat:Dataset")
  :properties `((:title :string ,(s-prefix "dct:title"))
                 (:description :string ,(s-prefix "dct:description"))
                 (:created :datetime ,(s-prefix "dct:created"))
                 (:modified :datetime ,(s-prefix "dct:modified"))
                 (:issued :datetime ,(s-prefix "dct:issued")))
  :has-one `((concept :via ,(s-prefix "dct:type")
               :as "type")
              (dataset :via ,(s-prefix "prov:wasRevisionOf")
                :as "previous-version")
              (dataset :via ,(s-prefix "prov:wasRevisionOf")
                :inverse t
                :as "next-version")
              (catalog :via ,(s-prefix "dcat:dataset")
                :inverse t
                :as "catalog"))
  :has-many `((file :via ,(s-prefix "dcat:distribution")
                :as "distributions"))
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/datasets/")
  :on-path "datasets")

(define-resource file ()
  :class (s-prefix "nfo:FileDataObject")
  :properties `((:filename :string ,(s-prefix "nfo:fileName"))
                 (:format :string ,(s-prefix "dct:format"))
                 (:size :number ,(s-prefix "nfo:fileSize"))
                 (:extension :string ,(s-prefix "dbpedia:fileExtension"))
                 (:created :datetime ,(s-prefix "dct:created"))
                 (:modified :datetime ,(s-prefix "dct:modified"))
                 (:issued :datetime ,(s-prefix "dct:issued")))
  :has-one `((file :via ,(s-prefix "nie:dataSource")
               :inverse t
               :as "download")
              (dataset :via ,(s-prefix "dcat:distribution")
                :inverse t
                :as "dataset"))
  :resource-base (s-url "http://linked.toerismevlaanderen.be/id/files/")
  :on-path "files")
