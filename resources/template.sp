PREFIX core: <https://flow.recipes/ns/core#>
PREFIX fs: <https://flow.recipes/ns/schemes#>

CONSTRUCT {
#  recipe	
	?recipeInstance a core:Recipe ;
				 a owl:NamedIndividual  ;
				core:instructions _:list ; 
				rdfs:label ?recipeName ;
	.
	_:list rdfs:member ?instruction .
#  instructions
	?instruction a core:Instruction ;
		a owl:NamedIndividual  ;
		?hasComponent [
			core:hasComponent ?ingredientConceptInstance ;
			core:weight ?weight ;
			core:componentAddition ?addition ;
		] ;
		core:hasMethod ?methodConceptInstance ;
		core:time ?time ;
		core:direction ?direction ;
		core:depVariationInstruction ?depVariationInstruction .
# method concepts
	?methodConceptInstance a skos:Concept .
	?methodConceptInstance skos:prefLabel ?method .
# ingredient concepts
	?ingredientConceptInstance a skos:Concept .
	?ingredientConceptInstance skos:prefLabel ?ingredient .
}
WHERE {
	BIND("testfork" AS ?recipeName) .		
	VALUES (?method ?weight	?ingredient	?addition ?dep ?time ?direction)  {
		("step1" "40g" "sjalot" "1" UNDEF UNDEF "test1d")
		("step3" "20g" "knoflook" "1" "step1" UNDEF UNDEF)
		("step4" "20g" "gember" UNDEF "step1" UNDEF UNDEF) 
		("step5" "20g" "gember" UNDEF "step3" UNDEF UNDEF)
		("step5" "20g" "gember" UNDEF "step4" UNDEF UNDEF)
		("step6" "20g" "gember" UNDEF "step5" UNDEF "test2des")
	}
# don't modify the following lines
    
    # bind method
	OPTIONAL { ?methodConcept skos:prefLabel ?method . } .
	BIND(IF(BOUND(?methodConcept), ?methodConcept, IRI(CONCAT("fs:",STR(NOW()), "-", ?method))) AS ?methodConceptInstance) .
	
	# bind ingredients
	BIND(IF(BOUND(?ingredient), core:hasComponentUnit, ?dummy) AS ?hasComponent) .
	
	
	OPTIONAL { ?ingredientConcept skos:prefLabel ?ingredient . } .
	BIND(IF(BOUND(?ingredientConcept), ?ingredientConcept, IRI(CONCAT("fs:",STR(NOW()), "-", ?ingredient))) AS ?ingredientConceptInstance) .
	
	# bind instruction
	BIND( IRI(CONCAT(?recipeName,STR(NOW()), "-", ?method)) AS ?instruction) .
	
	# bind variation
	BIND(IF(!BOUND(?dep), ?dummy, IRI(CONCAT(?recipeName,STR(NOW()), "-", ?dep))) AS ?depVariationInstruction) .
	
	# bind recipe
	BIND( IRI(CONCAT(?recipeName,STR(NOW()))) AS ?recipeInstance) .
}