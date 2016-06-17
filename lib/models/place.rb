require 'active_triples'

class Place
  include ActiveTriples::RDFSource
  configure base_uri: 'http://sws.geonames.org/', type: 'http://example.org/ns/Place'

  property :name, predicate: RDF::URI('http://www.geonames.org/ontology#name')
  property :latitude, predicate: RDF::GEO.lat
  property :longitude, predicate: RDF::GEO.long
  property :countryCode, predicate: RDF::URI('http://www.geonames.org/ontology#countryCode')
  property :parentFeature, predicate: RDF::URI('http://www.geonames.org/ontology#parentFeature')
end
