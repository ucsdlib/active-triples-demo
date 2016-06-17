require 'active_triples'

class Photo
  include ActiveTriples::RDFSource
  configure base_uri: 'http://example.org/resource', type: 'http://example.org/ns/Photo'

  property :title, predicate: RDF::Vocab::DC.title
  property :description, predicate: RDF::Vocab::DC.description
  property :creator, predicate: RDF::DC.creator
  property :date, predicate: RDF::DC.date
  property :subject, predicate: RDF::Vocab::DC.subject
  property :location, predicate: RDF::DC.spatial
end
