require 'rdf'
require 'linkeddata'

include RDF # include built-in vocabularies

graph = RDF::Graph.load('disciplines-asq.ttl')

##########################################
#  Add .rdf file to distribution folder  #
##########################################
RDF::RDFXML::Writer.open('../dist/disciplines-asq.rdf') do |writer|
  writer << graph
end

##########################################
#  Add .ttl file to distribution folder  #
##########################################
RDF::Turtle::Writer.open('../dist/disciplines-asq.ttl') do |writer|
  writer << graph
end


##########################################
#  Add .html file to distribution folder #
##########################################

# load ontologies so we can dynamically dereference labels
graph <<  RDF::Graph.load('https://www.w3.org/2009/08/skos-reference/skos')
graph <<  RDF::Graph.load('http://www.w3.org/1999/02/22-rdf-syntax-ns')

skos = RDF::Vocabulary.new("http://www.w3.org/2004/02/skos/core#")
spt = RDF::Vocabulary.new("http://scenepro.ca/taxonomies/disciplines-asq#")

query = RDF::Query.new({
  concept: {
    RDF.type  => skos.Concept,
    skos.prefLabel => :prefLabel,
    :p => :o,
  }
}, **{})

title = graph.query(RDF::Query::Pattern.new(spt.SceneProTaxonomie, skos.prefLabel, :o))&.first&.object
version = graph.query(RDF::Query::Pattern.new(spt.SceneProTaxonomie, OWL.versionInfo, :o))&.first&.object

# HTML template start
html_ouput = "<!DOCTYPE html><html><body>"
html_ouput += "<h1>#{title} #{version}</h1>"
html_ouput += "<h4>Comment on Github: <a href='https://github.com/culturecreates/disciplines-asq'>disciplines-asq</a></h4>"

html_ouput += "<ul>"
previous_concept = ""
query.execute(graph) do |solution|
  if solution.concept != previous_concept
    html_ouput += "
      </ul> 
      <h2 id='#{solution.concept.to_s.split('#')[1]}'>
        #{solution.prefLabel}
      </h2>
      <ul> 
        <li> 
          URI: <a href='#{solution.concept}'>#{solution.concept}</a>
        </li>
    "
  end
  previous_concept = solution.concept
  prop = graph.query(RDF::Query::Pattern.new(solution.p, RDFS.label, :o))&.first&.object || solution.p
  obj = if solution.o.uri?
          "<a href='#{solution.o}'>#{solution.o.to_s.split('#')[1]}</a>"
        else
          solution.o.to_s
        end
  html_ouput += "
    <li> #{prop}: #{obj}</li>
    "
end
html_ouput += "</ul>"
html_ouput += "</body></html>"
# HTML template end

File.open("../dist/disciplines-asq.html", "w") {|f| f << html_ouput}
