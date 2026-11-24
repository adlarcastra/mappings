-- Device:            Aurora 3 pro
-- Module provider:   Insmart
-- parameter_name + value -> insmart api calls

return function(current_data, parameter_name, new_value)
	local mappings = {
		enum_f32_heating_mode = function(_, value)
			return {
				{ "363", value - 1 }
			}
		end,
		onoff_f32_power_on = function(_, value)
			return {
				{ "357", value }
			}
		end
	}

	local mapping = mappings[parameter_name]

	if not mapping then
		error("No write mapping found for parameter: " .. parameter_name)
	end

	return mapping(current_data, new_value)
end
