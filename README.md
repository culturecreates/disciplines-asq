# Disciplines des arts de la scène au Québec
Disciplines des arts de la scène au Québec based on the Scène Pro taxonomy.

Documentation sur le projet:
https://observablehq.com/d/65a8499db70bd875


# Build
The distribution files are located in `/dist` folder. The distribution files are generated from the Turtle file and ruby code in the `/src` folder.

# Publish Guidelines
This taxonomy can be loaded into a triple store and used as is. However, to make it more accessible, and dereferencable, it would be best to publish this taxonomy on the http://scenepro.ca website. This would enable a URI like http://scenepro.ca/taxonomies/disciplines-asq#Jazz to be clickable to access documentation about it.


## Minimal Setup - Machine Only

The minimal setup for machines to access this taxonomy on an Apache server at scenepro.com.

Place the `dist/disciplines-asq.rdf` file in the `/apachedocumentroot/taxonomies/` directory.

Add the following directives to the .htaccess file in the `/apachedocumentroot/taxonomies/` directory on the server:

```
# Directive to ensure *.rdf files served as appropriate content type,
# if not present in main apache config
AddType application/rdf+xml .rdf

# Rewrite engine setup
RewriteEngine On
RewriteBase /taxonomies

# Rewrite rule to serve RDF content from the vocabulary URI
RewriteRule ^disciplines-asq$ disciplines-asq.rdf
```

### Testing the Configuration

If this configuration is working, it should support the following interactions:

Dereference the vocabulary URI

```
GET /taxonomies/disciplines-asq HTTP/1.1
Host: scenepro.com
```
Response header should contain the following fields:
```
HTTP/1.x 200 OK
Content-Type: application/rdf+xml
```

## Enhanced Setup - Human and Machine

The enhanced setup adds the ability for humans to read this taxonomy on an html page as well as machines. It also adds the RDF Turtle format because its popularity.

Place the `dist/disciplines-asq.rdf`, `dist/disciplines-asq.ttl` and `dist/disciplines-asq.html` files in the `/apachedocumentroot/taxonomies/` directory.

Add the following directives to the .htaccess file in the `/apachedocumentroot/taxonomies/` directory on the server:

```
# Turn off MultiViews
Options -MultiViews

# Directive to ensure RDF files served as appropriate content type,
# if not present in main apache config
AddType application/rdf+xml .rdf
AddType text/turtle .ttl

# Rewrite engine setup
RewriteEngine On
RewriteBase /taxonomies

# Rewrite rule to serve RDF content from the vocabulary URI if requested
RewriteCond %{HTTP_ACCEPT} application/rdf+xml
RewriteRule ^disciplines-asq$ disciplines-asq.rdf [R=303]

RewriteCond %{HTTP_ACCEPT} text/turtle
RewriteRule ^disciplines-asq$ disciplines-asq.ttl [R=303]

# Default response - serve HTML content
RewriteRule ^disciplines-asq$ disciplines-asq.html [R=303]
```


## References

http://harth.org/andreas/2016/pedantic-web/

https://www.w3.org/TR/swbp-vocab-pub/

https://httpd.apache.org/docs/current/mod/mod_rewrite.html
