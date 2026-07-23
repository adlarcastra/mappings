-- Device:            --
-- Module provider:   --
-- sensor data + user defined variables -> additional sensor data values

return function(p)
	local saved_costs_total = ((p.kwh_f32_thermal_energy_total / 8.2) * p.user_gas_cost_per_m3_euro) -
			(p.kwh_f32_electric_energy_total * p.user_electric_cost_per_kwh_euro);
	return {
		euro_f32_saved_costs_total = saved_costs_total
	}
end
