# Voorbeelden
Dit document bevat enkele voorbeelden van SPARQL queries en REST/JSON API requests om data op te vragen.

### Voorbeeld: Het basisregister met alle aangemelde en erkende logies
#### SPARQL
```sparql
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>

SELECT DISTINCT ?dataset ?issued
WHERE {
   ?dataset a dcat:Dataset  ; 
      dct:type <http://linked.toerismevlaanderen.be/id/dataset-types/ca82a1e3-8a7c-438e-ba37-cf36063ba060> ;
      dcat:distribution/dct:format "application/x-turtle" ;
      dct:issued ?issued .
} ORDER BY DESC(?issued) LIMIT 1
```

#### REST/JSON API
```bash
GET /datasets?filter[type][:uri:]=http://linked.toerismevlaanderen.be/id/dataset-types/ca82a1e3-8a7c-438e-ba37-cf36063ba060&filter[distributions][format]=application/x-turtle&sort=-issued&page[size]=1
```
---

### Voorbeeld: Alle erkende en aangemelde campings in Vlaanderen
#### SPARQL
```sparql
PREFIX logies: <https://data.vlaanderen.be/ns/logies#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT DISTINCT ?logies ?name ?status WHERE {
  ?logies a logies:Logies ;
    logies:heeftRegistratie ?registration .
  ?registration logies:registratieStatus ?registrationStatus ;
    dct:type <http://linked.toerismevlaanderen.be/id/concepts/d2d28d1d-bd4e-4aac-86ae-6a70861a7a73> .
  FILTER (?registrationStatus IN (
    <http://linked.toerismevlaanderen.be/id/concepts/bb9d1b1b-05ea-4a98-bb54-87084c38da4e>,
    <http://linked.toerismevlaanderen.be/id/concepts/ed624155-305e-4da3-83a0-e4c586ca7b81>,
    <http://linked.toerismevlaanderen.be/id/concepts/f9305a29-0508-4e24-8615-f83bd4bf84a7>
  ))
  OPTIONAL { ?logies schema:name ?name . }
  ?registrationStatus skos:prefLabel ?status .
  FILTER(LANG(?status) = 'nl')
}
```

#### REST/JSON API

---

### Voorbeeld: Overzicht van alle attracties en bezienswaardigheden in Vlaanderen
#### SPARQL
```sparql
PREFIX schema: <http://schema.org/>

SELECT DISTINCT ?s ?name WHERE {
  ?s a schema:TouristAttraction.
  OPTIONAL { ?s schema:name ?name . }
} LIMIT 100
```

#### REST/JSON API
```bash
GET /tourist-attractions?sort=name&page[size]=100
```
---

### Voorbeeld: Alle erkende en aangemelde logies met een toegankelijkheidslabel
#### SPARQL
```sparql
PREFIX logies: <https://data.vlaanderen.be/ns/logies#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT DISTINCT ?logies ?name ?status ?accessibilityPrefLabel WHERE {
  ?logies a logies:Logies ;
    logies:heeftRegistratie ?registration .
  ?registration logies:registratieStatus ?registrationStatus .
  FILTER (?registrationStatus IN (
    <http://linked.toerismevlaanderen.be/id/concepts/bb9d1b1b-05ea-4a98-bb54-87084c38da4e>,
    <http://linked.toerismevlaanderen.be/id/concepts/ed624155-305e-4da3-83a0-e4c586ca7b81>,
    <http://linked.toerismevlaanderen.be/id/concepts/f9305a29-0508-4e24-8615-f83bd4bf84a7>
  ))

  ?logies logies:heeftKwaliteitslabel ?accessibilityLabel .
  ?accessibilityLabel skos:prefLabel ?accessibilityPrefLabel .
  FILTER (CONTAINS(STR(?accessibilityPrefLabel), "Toegankelijkheidslabel"))

  OPTIONAL { ?logies schema:name ?name . }
  ?registrationStatus skos:prefLabel ?status .
  FILTER(LANG(?status) = 'nl')
}
```

#### REST/JSON API

---

### Voorbeeld: Alle erkende en aangemelde jeugdverblijven
#### SPARQL
```sparql
PREFIX logies: <https://data.vlaanderen.be/ns/logies#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT DISTINCT ?logies ?name ?status WHERE {
  ?logies a logies:Logies ;
    logies:heeftRegistratie ?registration .
  ?registration logies:registratieStatus ?registrationStatus ;
    dct:type <http://linked.toerismevlaanderen.be/id/concepts/3fc52ed7-75b5-4690-a8ba-115662d1f1aa> .
  FILTER (?registrationStatus IN (
    <http://linked.toerismevlaanderen.be/id/concepts/bb9d1b1b-05ea-4a98-bb54-87084c38da4e>,
    <http://linked.toerismevlaanderen.be/id/concepts/ed624155-305e-4da3-83a0-e4c586ca7b81>,
    <http://linked.toerismevlaanderen.be/id/concepts/f9305a29-0508-4e24-8615-f83bd4bf84a7>
  ))
  OPTIONAL { ?logies schema:name ?name . }
  ?registrationStatus skos:prefLabel ?status .
  FILTER(LANG(?status) = 'nl')
}
```

#### REST/JSON API

---

### Voorbeeld: Alle erkende en aangemelde hotels met meer dan 3 sterren
#### SPARQL
```sparql
PREFIX logies: <https://data.vlaanderen.be/ns/logies#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT DISTINCT ?logies ?name ?status ?ratingValue WHERE {
  ?logies a logies:Logies ;
    logies:heeftRegistratie ?registration .
  ?registration logies:registratieStatus ?registrationStatus ;
    dct:type <http://linked.toerismevlaanderen.be/id/concepts/149c732c-1369-4448-b0ea-d7a26ee8757f> .
  FILTER (?registrationStatus IN (
    <http://linked.toerismevlaanderen.be/id/concepts/bb9d1b1b-05ea-4a98-bb54-87084c38da4e>,
    <http://linked.toerismevlaanderen.be/id/concepts/ed624155-305e-4da3-83a0-e4c586ca7b81>,
    <http://linked.toerismevlaanderen.be/id/concepts/f9305a29-0508-4e24-8615-f83bd4bf84a7>
  ))

  ?logies schema:starRating/schema:ratingValue ?ratingValue .
  FILTER(?ratingValue IN ("3 * sup", "4 *", "4 * sup", "5 *", "5 * sup"))

  OPTIONAL { ?logies schema:name ?name . }
  ?registrationStatus skos:prefLabel ?status .
  FILTER(LANG(?status) = 'nl')
} LIMIT 100
```

#### REST/JSON API

---

### Voorbeeld: Alle erkende en aangemelde vakantiewoningen in Oost-Vlaanderen
#### SPARQL
```sparql
PREFIX logies: <https://data.vlaanderen.be/ns/logies#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>
PREFIX locn: <http://www.w3.org/ns/locn#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

SELECT DISTINCT ?logies ?name ?status WHERE {
  ?logies a logies:Logies ;
    logies:heeftRegistratie ?registration ;
    logies:onthaalAdres/locn:adminUnitL2 "Oost-Vlaanderen"@nl .
  ?registration logies:registratieStatus ?registrationStatus ;
    dct:type <http://linked.toerismevlaanderen.be/id/concepts/5b37541f-fd32-4ef8-8ca9-5881f30dd4d7> .
  FILTER (?registrationStatus IN (
    <http://linked.toerismevlaanderen.be/id/concepts/bb9d1b1b-05ea-4a98-bb54-87084c38da4e>,
    <http://linked.toerismevlaanderen.be/id/concepts/ed624155-305e-4da3-83a0-e4c586ca7b81>,
    <http://linked.toerismevlaanderen.be/id/concepts/f9305a29-0508-4e24-8615-f83bd4bf84a7>
  ))

  OPTIONAL { ?logies schema:name ?name . }
  ?registrationStatus skos:prefLabel ?status .
  FILTER(LANG(?status) = 'nl')
} LIMIT 100
```

#### REST/JSON API

