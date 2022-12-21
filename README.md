# Disciplines des arts de la scène au Québec
Disciplines des arts de la scène au Québec based on the Scène Pro taxonomy.

https://observablehq.com/d/65a8499db70bd875

# Publish Guidelines
This taxonomy can be loaded into a triple store and used as is. However, to make it more accessible, and dereferencable, it would be best to publish this taxonomy on an website. This would enable a URI like http://scenepro.ca/taxonomies/disciplines-asq#Jazz could be clicked to access documentation about it.


## Minimal setup

The minimal setup for machines to access this taxonomy on an Apache server at scenepro.com.

Place the `disciplines-asq.ttl` file in the `/apachedocumentroot/taxonomies/` directory.

Add the following directives to the .htaccess file in the `/apachedocumentroot/taxonomies/` directory on the server:

```
# Directive to ensure *.ttl files served as appropriate content type,
# if not present in main apache config
AddType text/turtle .ttl

# Rewrite engine setup
RewriteEngine On
RewriteBase /taxonomies

# Rewrite rule to serve Turtle content from the vocabulary URI
RewriteRule ^disciplines-asq$ disciplines-asq.ttl
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
Content-Type: text/turtle
```

## Enhanced Setup

The enhanced setup adds the ability for humans to read this taxonomy on an html page as well as machines.

Place the `disciplines-asq.ttl` and `disciplines-asq.html` files in the `/apachedocumentroot/taxonomies/` directory.

Add the following directives to the .htaccess file in the `/apachedocumentroot/taxonomies/` directory on the server:

```
# Turn off MultiViews
Options -MultiViews

# Directive to ensure *.turtle files served as appropriate content type,
# if not present in main apache config
AddType text/turtle .ttl

# Rewrite engine setup
RewriteEngine On
RewriteBase /taxonomies

# Rewrite rule to serve Turtle content from the vocabulary URI if requested
RewriteCond %{HTTP_ACCEPT} text/turtle
RewriteRule ^disciplines-asq$ disciplines-asq.ttl [R=303]

# Default response - serve HTML content
RewriteRule ^disciplines-asq$ disciplines-asq.html [R=303]
```


## References

http://harth.org/andreas/2016/pedantic-web/

https://www.w3.org/TR/swbp-vocab-pub/
