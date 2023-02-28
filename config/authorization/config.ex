alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  def user_groups do
    [
      %GroupSpec{
        name: "public",
        useage: [:read],
        access: %AlwaysAccessible{},
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/public",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://purl.org/dc/terms/Agent",
                "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject",
                "http://www.w3.org/2004/02/skos/core#Collection",
                "http://www.w3.org/2004/02/skos/core#Concept",
                "http://www.w3.org/2004/02/skos/core#ConceptScheme",
                "http://www.w3.org/ns/dcat#Catalog",
                "http://www.w3.org/ns/dcat#Dataset",
                "http://www.w3.org/ns/regorg#RegisteredOrganization",
                "https://data.vlaanderen.be/ns/logies#Faciliteit",
                "https://data.vlaanderen.be/ns/logies#ToeristischeRegio"
              ]
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/mapped/public",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://linked.toerismevlaanderen.be/vocabularies/accessibility/AccessibilityInformation",
                "http://schema.org/Accommodation",
                "http://schema.org/ContactPoint",
                "http://schema.org/GovernmentPermit",
                "http://schema.org/MediaObject",
                "http://schema.org/Place",
                "http://schema.org/PropertyValue",
                "http://schema.org/QuantitativeValue",
                "http://schema.org/Rating",
                "http://schema.org/Service",
                "http://schema.org/TouristAttraction",
                "http://w3id.org/ost/ns#Recreation",
                "http://www.w3.org/2003/01/geo/wgs84_pos#Point",
                "http://www.w3.org/ns/adms#Identifier",
                "http://www.w3.org/ns/locn#Address",
                "http://www.w3.org/ns/locn#Geometry",
                "http://www.w3.org/ns/org#Organisation",
                "http://www.w3.org/ns/prov#Generation",
                "http://www.w3.org/ns/prov#Invalidation",
                "https://data.vlaanderen.be/ns/logies#Beschrijving",
                "https://data.vlaanderen.be/ns/logies#Kwaliteitslabel",
                "https://data.vlaanderen.be/ns/logies#Logies",
                "https://data.vlaanderen.be/ns/logies#Registratie"
              ]
            }
          }
        ]
      },

      %GroupSpec{
        name: "private",
        useage: [:read],
        access: %AccessByQuery{
          vars: ["group_id"],
          query: "
            PREFIX session: <http://mu.semte.ch/vocabularies/session/>
            PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
            PREFIX foaf: <http://xmlns.com/foaf/0.1/>
            PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

            SELECT DISTINCT ?group_id WHERE {
              <SESSION_ID> session:account ?account .
              ?person foaf:account ?account .
              ?group foaf:member ?person ;
                 skos:notation ?group_id .
            }"
        },
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/mapped/private/",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://schema.org/ContactPoint",
                "http://www.w3.org/ns/adms#Identifier",
                "http://www.w3.org/ns/locn#Address",
                "http://www.w3.org/ns/org#Organisation",
                "https://data.vlaanderen.be/ns/logies#Logies",
              ]
            }
          }
        ]
      },

      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
