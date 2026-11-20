-- Device:            Aurora 3 pro
-- Module provider:   Insmart
-- parameter_name + value -> insmart api calls

return function(current_data, parameter_name, new_value)
	local mappings = {
		test = function(_, value)
			return {
				{ "367", value }
			}
		end,
		degrees_f32_set_water_temp = function(p, value)
			local mode = p.enum_f32_heating_mode:unwrap_or(9999)

			if mode == 0 then
				return {
					{ "593", value } -- heating
				}
			elseif mode == 1 then
				return {
					{ "367", value } -- cooling
				}
			end

			error("Unsupported water temperature mode: " .. tostring(mode))
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
