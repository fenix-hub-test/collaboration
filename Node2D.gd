extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var query_string : String = "query { user(login: \"fenix-hub\" ) { repositories( ownerAffiliations: [OWNER,COLLABORATOR,ORGANIZATION_MEMBER], first: 100) { nodes { name owner { login } description url isFork isPrivate forkCount stargazerCount isInOrganization collaborators(affiliation: DIRECT, first: 100) { nodes {login} } mentionableUsers(first: 100){ nodes{ login } } defaultBranchRef { name } refs(refPrefix: \"refs/heads/\", first: 100){ nodes{ name } } } } } }"
	var query : Dictionary = { "query" : query_string }
	var endpoint : String = "https://api.github.com/graphql"
	var headers : PoolStringArray = ["Authorization: Bearer 5622f1b5d355dd263e99472be2014fe79868c10a"]
	$HTTPRequest.request(endpoint, headers, true, HTTPClient.METHOD_POST, JSON.print(query))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HTTPRequest_request_completed(result, response_code, headers, body : PoolByteArray):
	var datas : Dictionary = (JSON.parse(body.get_string_from_utf8()).result)
	print(datas.data)
