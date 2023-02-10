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
                "https://data.vlaanderen.be/ns/logies#Faciliteit",
                "http://www.w3.org/ns/regorg#RegisteredOrganization",
                "https://data.vlaanderen.be/ns/logies#ToeristischeRegio",
                "http://purl.org/dc/terms/LicenseDocument"
              ]
            }
          },
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/mapped/public",
            constraint: %ResourceConstraint{
              resource_types: [
                "http://purl.org/dc/terms/Agent",
                "http://schema.org/Rating",
                "https://data.vlaanderen.be/ns/logies#Beschrijving",
                "http://schema.org/CreativeWork",
                "https://data.vlaanderen.be/ns/logies#Kwaliteitslabel",
                "https://data.vlaanderen.be/ns/logies#Logies",
                "https://data.vlaanderen.be/ns/logies#MediaObject",
                "https://data.vlaanderen.be/ns/logies#Registratie",
                "https://data.vlaanderen.be/ns/logies#Ruimte",
                "https://data.vlaanderen.be/ns/logies#Verhuureenheid",
                "http://purl.org/dc/terms/Location",
                "http://www.w3.org/ns/locn#:Address",
                "http://schema.org/ContactPoint",
                "http://www.w3.org/ns/locn#:Geometry",
                "http://www.w3.org/ns/adms#Identifier",
                "http://schema.org/QuantitativeValue",
                "https://data.vlaanderen.be/ns/adres#Locatieaanduiding",
                "http://www.w3.org/2003/01/geo/wgs84_pos#Point",
                "http://www.w3.org/ns/prov#Generation",
                "http://www.w3.org/ns/prov#Invalidation"
              ]
            }
          }
        ]
      },

      %GroupSpec{
        name: "private",
        useage: [:read],
        access: %AccessByQuery{
          vars: [],
          query: "
            PREFIX muAccount: <http://mu.semte.ch/vocabularies/account/>
            PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
            SELECT DISTINCT ?partner_id WHERE {
              <SESSION_ID> muAccount:account/mu:uuid ?vendor_id .
            }"
        },
        graphs: [
          %GraphSpec{
            graph: "http://mu.semte.ch/graphs/mapped/private",
            constraint: %ResourceConstraint{
              resource_types: [
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
