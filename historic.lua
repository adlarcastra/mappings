-- Device:					--
-- Module provider:	--
-- intermediate representation -> historic representation
return function(p)
	return {
		degrees_f32_desired_temp        = p.degrees_f32_desired_temp,
		degrees_f32_outside_temp        = p.degrees_f32_outside_temp,
		degrees_f32_return_temp         = p.degrees_f32_return_temp,
		degrees_f32_room_temp           = p.degrees_f32_room_temp,
		degrees_f32_supply_temp         = p.degrees_f32_supply_temp,
		enum_f32_heating_curve_preset   = p.enum_f32_heating_curve_preset,
		onoff_f32_custom_heating_curve  = p.onoff_f32_custom_heating_curve,
		degrees_f32_set_water_temp      = p.degrees_f32_set_water_temp,
		enum_f32_heating_mode           = p.enum_f32_heating_mode,
		percent_f32_cop                 = p.percent_f32_cop,
		hz_f32_compressor_frequency     = p.hz_f32_compressor_frequency,
		hz_f32_fan_frequency            = p.hz_f32_fan_frequency,
		lmin_f32_water_flow             = p.lmin_f32_water_flow,
		onoff_f32_power_on              = p.onoff_f32_power_on,
		kwh_f32_electric_energy_total   = p.kwh_f32_electric_energy_total,
		kwh_f32_thermal_energy_total    = p.kwh_f32_thermal_energy_total,
		kwh_f32_thermal_energy_24h      = p.kwh_f32_thermal_energy_24h,
		kwh_f32_electric_energy_24h     = p.kwh_f32_electric_energy_24h,
		kwh_f32_thermal_energy          = p.kwh_f32_thermal_energy,
		kwh_f32_electric_energy         = p.kwh_f32_electric_energy,
	}
end
