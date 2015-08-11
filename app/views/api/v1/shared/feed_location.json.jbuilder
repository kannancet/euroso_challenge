json.result "success"
json.message @message
json.data do
	json.locations @locations
	json.count @locations.count
end