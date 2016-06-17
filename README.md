# active-triples-demo
================

1.Clone active-triples-demo

```
$ git clone https://github.com/ucsdlib/active-triples-demo
```

2.Install gems

```
$ bundle install
```

3.Console session

```
$ bundle console
```

4.Create Place Object using external data from http://www.geonames.org/

```
$ require './lib/models'

$ place_obj = Place.new('7196083/')
=> #<Place:0x3fcd5258e148(#<Place:0x007f9aa4b1c290>)>

$ place_obj.fetch
=> #<Place:0x3fcd5258e148(#<Place:0x007f9aa4b1c290>)>

$ place_obj.name
=> ["Peterson Hall"]

$ place_obj.latitude
=> ["32.88"]

$ place_obj.longitude
=> ["-117.2402"]

$ place_obj.countryCode
=> ["US"]

$ place_obj.parentFeature.first.fetch
=> #<ActiveTriples::Resource:0x3fcd52179d64(#<ActiveTriples::Resource:0x007f9aa42f3ac8>)>

$ puts place_obj.parentFeature.first.dump :ttl

```

5.Create Photo Object and add the created place_obj

```
$ require './lib/models'

$ photo = Photo.new('1')
=> #<Photo:0x3fcd521fd54c(#<Photo:0x007f9aa43faa98>)>

$ photo.rdf_subject
=> #<RDF::URI:0x3fcd521fc908 URI:http://example.org/resource/1>

$ photo.title = 'My test photo'
=> "My test photo"

$ photo.description = 'Test description'
=> "Test description"

$ photo.creator = 'Me'
=> "Me"

$ photo.date = DateTime.now
=> Fri, 17 Jun 2016 16:03:32 -0700

$ photo.subject = 'Test Subject'
=> "Test Subject"

$ puts photo.dump :ttl
<http://example.org/resource/1> a <http://example.org/ns/Photo>;
   <http://purl.org/dc/terms/title> "My test photo";
   <http://purl.org/dc/terms/creator> "Me";
   <http://purl.org/dc/terms/date> "2016-06-17T16:03:32-07:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>;
   <http://purl.org/dc/terms/description> "Test description";
   <http://purl.org/dc/terms/subject> "Test Subject" .
=> nil

$ photo.location = place_obj
=> #<Place:0x3fcd5258e148(#<Place:0x007f9aa4b1c290>)>

$ puts photo.dump :ttl
<http://example.org/resource/1> a <http://example.org/ns/Photo>;
   <http://purl.org/dc/terms/title> "My test photo";
   <http://purl.org/dc/terms/creator> "Me";
   <http://purl.org/dc/terms/date> "2016-06-17T16:03:32-07:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>;
   <http://purl.org/dc/terms/description> "Test description";
   <http://purl.org/dc/terms/spatial> <http://sws.geonames.org/7196083/>;
   <http://purl.org/dc/terms/subject> "Test Subject" .

<http://sws.geonames.org/7196083/about.rdf> a <http://xmlns.com/foaf/0.1/Document>;
   <http://creativecommons.org/ns#attributionName> "GeoNames";
   <http://creativecommons.org/ns#attributionURL> <http://sws.geonames.org/7196083/>;
   <http://creativecommons.org/ns#license> <http://creativecommons.org/licenses/by/3.0/>;
   <http://purl.org/dc/terms/created> "2010-02-05"^^<http://www.w3.org/2001/XMLSchema#date>;
   <http://purl.org/dc/terms/modified> "2010-02-05"^^<http://www.w3.org/2001/XMLSchema#date>;
   <http://xmlns.com/foaf/0.1/primaryTopic> <http://sws.geonames.org/7196083/> .

<http://sws.geonames.org/7196083/> a <http://example.org/ns/Place>,
     <http://www.geonames.org/ontology#Feature>;
   <http://www.geonames.org/ontology#countryCode> "US";
   <http://www.geonames.org/ontology#featureClass> <http://www.geonames.org/ontology#S>;
   <http://www.geonames.org/ontology#featureCode> <http://www.geonames.org/ontology#S.BLDG>;
   <http://www.geonames.org/ontology#locationMap> <http://www.geonames.org/7196083/peterson-hall.html>;
   <http://www.geonames.org/ontology#name> "Peterson Hall";
   <http://www.geonames.org/ontology#nearbyFeatures> <http://sws.geonames.org/7196083/nearby.rdf>;
   <http://www.geonames.org/ontology#parentADM1> <http://sws.geonames.org/5332921/>;
   <http://www.geonames.org/ontology#parentADM2> <http://sws.geonames.org/5391832/>;
   <http://www.geonames.org/ontology#parentCountry> <http://sws.geonames.org/6252001/>;
   <http://www.geonames.org/ontology#parentFeature> <http://sws.geonames.org/5391832/>;
   <http://www.w3.org/2000/01/rdf-schema#isDefinedBy> <http://sws.geonames.org/7196083/about.rdf>;
   <http://www.w3.org/2003/01/geo/wgs84_pos#alt> "129";
   <http://www.w3.org/2003/01/geo/wgs84_pos#lat> "32.88";
   <http://www.w3.org/2003/01/geo/wgs84_pos#long> "-117.2402" .
=> nil

$ photo.location
=>  [#<Place:0x3fcd5258e148(#<Place:0x007f9aa4b1c290>)>]

$ photo.location.first.fetch
=>  #<Place:0x3fcd5258e148(#<Place:0x007f9aa4b1c290>)>

$ photo.location.first.name
=> ["Peterson Hall"]

```

5.Create Collection Object and add the Photo object

```
$ collection = Collection.new('2')
=> #<Collection:0x3fefa59cad90(#<Collection:0x007fdf4b395b20>)>

$ collection.name = 'My Test Photo Collection'
=> "My Test Photo Collection"

$ collection.description = 'Collection description'
=> "Collection description"

$ collection.members = photo
=> #<Photo:0x3fcd521fd54c(#<Photo:0x007f9aa43faa98>)>

$ puts collection.dump :ttl
<http://example.org/collection/2> a <http://example.org/ns/Collection>;
   <http://purl.org/dc/terms/title> "My Test Photo Collection";
   <http://purl.org/dc/terms/description> "Collection description";
   <http://purl.org/dc/terms/hasPart> <http://example.org/resource/1> .

<http://example.org/resource/1> a <http://example.org/ns/Photo>;
   <http://purl.org/dc/terms/title> "My test photo";
   <http://purl.org/dc/terms/creator> "Me";
   <http://purl.org/dc/terms/date> "2016-06-17T16:03:32-07:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>;
   <http://purl.org/dc/terms/description> "Test description";
   <http://purl.org/dc/terms/spatial> <http://sws.geonames.org/7196083/>;
   <http://purl.org/dc/terms/subject> "Test Subject" .

<http://sws.geonames.org/7196083/about.rdf> a <http://xmlns.com/foaf/0.1/Document>;
   <http://creativecommons.org/ns#attributionName> "GeoNames";
   <http://creativecommons.org/ns#attributionURL> <http://sws.geonames.org/7196083/>;
   <http://creativecommons.org/ns#license> <http://creativecommons.org/licenses/by/3.0/>;
   <http://purl.org/dc/terms/created> "2010-02-05"^^<http://www.w3.org/2001/XMLSchema#date>;
   <http://purl.org/dc/terms/modified> "2010-02-05"^^<http://www.w3.org/2001/XMLSchema#date>;
   <http://xmlns.com/foaf/0.1/primaryTopic> <http://sws.geonames.org/7196083/> .

<http://sws.geonames.org/7196083/> a <http://example.org/ns/Place>,
     <http://www.geonames.org/ontology#Feature>;
   <http://www.geonames.org/ontology#countryCode> "US";
   <http://www.geonames.org/ontology#featureClass> <http://www.geonames.org/ontology#S>;
   <http://www.geonames.org/ontology#featureCode> <http://www.geonames.org/ontology#S.BLDG>;
   <http://www.geonames.org/ontology#locationMap> <http://www.geonames.org/7196083/peterson-hall.html>;
   <http://www.geonames.org/ontology#name> "Peterson Hall";
   <http://www.geonames.org/ontology#nearbyFeatures> <http://sws.geonames.org/7196083/nearby.rdf>;
   <http://www.geonames.org/ontology#parentADM1> <http://sws.geonames.org/5332921/>;
   <http://www.geonames.org/ontology#parentADM2> <http://sws.geonames.org/5391832/>;
   <http://www.geonames.org/ontology#parentCountry> <http://sws.geonames.org/6252001/>;
   <http://www.geonames.org/ontology#parentFeature> <http://sws.geonames.org/5391832/>;
   <http://www.w3.org/2000/01/rdf-schema#isDefinedBy> <http://sws.geonames.org/7196083/about.rdf>;
   <http://www.w3.org/2003/01/geo/wgs84_pos#alt> "129";
   <http://www.w3.org/2003/01/geo/wgs84_pos#lat> "32.88";
   <http://www.w3.org/2003/01/geo/wgs84_pos#long> "-117.2402" .
=> nil

```
