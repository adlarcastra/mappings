-- Device:					Aurora 3 pro 
-- Module provider:	Insmart
-- raw insmart csv -> intermediate representation
return function(p)
	local degrees_f32_set_water_temp = nil

	if p.p_363 == 1 then
		degrees_f32_set_water_temp = p.p_3		-- heating mode
	elseif p.p_363 == 2 then
		degrees_f32_set_water_temp = p.p_635 	-- cooling mode
	end

	local flow_lmin              = p.p_373
	local supply_temp            = p.p_290
	local return_temp            = p.p_328
	local voltage                = p.p_327
	local current                = p.p_326
	local sample_hours           = 5.0 / 60.0

	local thermal_kw             = (flow_lmin / 60) * 4.186 * (supply_temp - return_temp)
	local electric_kw            = (voltage * current) / 1000

	local kwh_f32_thermal_power  = thermal_kw * sample_hours
	local kwh_f32_electric_power = electric_kw * sample_hours
	local percent_f32_cop        = math.max(0.0, thermal_kw / electric_kw)

	return {
		-- Boiler control bits
		bit_f32_jan_control_boiler_on_bit      = p.p_455,
		bit_f32_jan_control_boiler_on_sdk      = p.p_454,

		-- Temperature readings
		degrees_f32_desired_temp               = p.p_8,
		degrees_f32_outside_temp               = p.p_22,
		degrees_f32_return_temp                = p.p_328,
		degrees_f32_room_temp                  = p.p_9,
		degrees_f32_supply_temp                = p.p_290,

		-- Heating curve settings
		degrees_f32_heating_curve_high         = p.p_617,
		degrees_f32_heating_curve_low          = p.p_618,
		degrees_f32_heating_start_ambient_temp = p.p_677,
		degrees_f32_set_temp_heating_curve     = p.p_633,
		enum_f32_heating_curve_preset          = p.p_370,
		onoff_f32_custom_heating_curve         = p.p_629,

		-- Set water temperatures
		degrees_f32_set_water_temp             = degrees_f32_set_water_temp,
		degrees_f32_set_water_temp_cooling     = p.p_635,
		degrees_f32_set_water_temp_heating     = p.p_3,

		-- Heating mode: 0 = heating, 1 = cooling (derived from p_363)
		enum_f32_heating_mode                  = (p.p_363 - 1),

		-- Power & efficiency  (energy per 5-minute sample, kWh)
		kwh_f32_thermal_power                  = kwh_f32_thermal_power,
		kwh_f32_electric_power                 = kwh_f32_electric_power,
		percent_f32_cop                        = percent_f32_cop,

		-- Frequencies
		hz_f32_compressor_frequency            = p.p_325,
		hz_f32_fan_frequency                   = p.p_315,

		-- Water flow
		lmin_f32_water_flow                    = p.p_373,

		-- General on/off
		onoff_f32_power_on                     = p.p_357,

		-- JAN controller parameters
		degrees_f32_jan_control_max_temp       = p.p_439,
		degrees_f32_jan_control_min_temp       = p.p_440,
		sec_f32_jan_control_interval           = p.p_441,
		x_f32_jan_control_Kp                   = p.p_821,
		x_f32_jan_control_Ki                   = p.p_820,
		x_f32_jan_control_Kd                   = p.p_822,
		x_f32_jan_control_output_to_device     = p.p_442,
		x_f32_jan_control_output_to_sdk        = p.p_437,
	}
end
