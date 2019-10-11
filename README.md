# recipes

(echo "@prefix core:  <https://flow.recipes/ns/core#> .  @prefix skos: <http://www.w3.org/2008/05/skos#> ." &  comunica-sparql-file https://flow.recipes/ns/core https://flow.recipes/ns/schemes -f risotto.sp ) | curl  --data-urlencode content@-  http://rdf-translator.appspot.com/convert/n3/xml/content > example4.xm
