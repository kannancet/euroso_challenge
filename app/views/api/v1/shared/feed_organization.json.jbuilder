json.result "success"
json.message @message
json.data do
	json.organizations @organizations
	json.count @organizations.count
end