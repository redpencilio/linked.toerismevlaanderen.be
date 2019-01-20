alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec

defmodule Acl.UserGroups.Config do
  def user_groups do
    [
      # // PUBLIC
      %GroupSpec{
        name: "public",
        useage: [:read],
        access: %AlwaysAccessible{},
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/application",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://purl.org/dc/terms/Agent",
                        "http://schema.org/Rating",
                        "https://data.vlaanderen.be/ns/logies#Beschrijving",
                        "http://schema.org/CreativeWork",
                        "https://data.vlaanderen.be/ns/logies#Faciliteit",
                        "http://www.w3.org/ns/regorg#RegisteredOrganization",
                        "https://data.vlaanderen.be/ns/logies#Kwaliteitslabel",
                        "https://data.vlaanderen.be/ns/logies#Logies",
                        "https://data.vlaanderen.be/ns/logies#MediaObject",
                        "https://data.vlaanderen.be/ns/logies#Registratie",
                        "https://data.vlaanderen.be/ns/logies#Ruimte",
                        "https://data.vlaanderen.be/ns/logies#ToeristischeRegio",
                        "https://data.vlaanderen.be/ns/logies#Verhuureenheid",
                        "http://purl.org/dc/terms/Location",
                        "http://purl.org/dc/terms/LicenseDocument",
                        "http://www.w3.org/ns/locn#:Address",
                        "http://schema.org/ContactPoint",
                        "http://www.w3.org/ns/locn#:Geometry",
                        "http://www.w3.org/ns/adms#Identifier",
                        "http://schema.org/QuantitativeValue",
                        "https://data.vlaanderen.be/ns/adres#Locatieaanduiding",
                        "http://www.w3.org/2003/01/geo/wgs84_pos#Point",
                        "http://www.w3.org/ns/prov#Generation",
                        "http://www.w3.org/ns/prov#Invalidation",
                        "http://mu.semte.ch/vocabularies/ext/StandardizedUnit",
                        "http://mu.semte.ch/vocabularies/ext/Audience",
                        "http://mu.semte.ch/vocabularies/ext/Language",
                        "http://mu.semte.ch/vocabularies/ext/FileFormat",
                        "http://mu.semte.ch/vocabularies/ext/LocatorDesignatorType",
                        "http://mu.semte.ch/vocabularies/ext/RegistrationStatus",
                        "http://mu.semte.ch/vocabularies/ext/RegistrationLodgingType",
                        "http://mu.semte.ch/vocabularies/ext/RegistrationPublicationLodgingType",
                        "http://mu.semte.ch/vocabularies/ext/RoomType"
                      ]
                    } } ] }
    ]
  end
end



