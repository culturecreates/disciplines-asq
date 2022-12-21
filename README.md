# Disciplines des arts de la scène au Québec
Disciplines des arts de la scène au Québec based on the Scène Pro taxonomy.

https://observablehq.com/d/65a8499db70bd875

# Content Negotiation
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

## Testing the Configuration

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
