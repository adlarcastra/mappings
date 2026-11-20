-- Device:            Aurora 2 pro
-- Module provider:   Insmart
-- raw insmart data -> intermediate representation

return function(p)
	local hz_f32_compressor_frequency = p.p_325:unwrap_or(0.0)
	local degrees_f32_supply_temp = p.p_290:unwrap_or(0.0)
	local degrees_f32_return_temp = p.p_328:unwrap_or(0.0)

	local heatpump_actively_heating = hz_f32_compressor_frequency > 0 and
			(degrees_f32_supply_temp - degrees_f32_return_temp) > 0.5
	------------------------------------------------------------
	-- Heating / cooling mode selection
	------------------------------------------------------------
	local degrees_f32_set_water_temp = nil

	local custom_heating_curve = p.p_418
	-- Off
	-- On

	local heating_curve_cooling = p.p_369
	-- 0  Off
	-- 1  CH1
	-- 2  CH2
	-- 3  CH3
	-- 4  CH4
	-- 5  CH5
	-- 6  CH6
	-- 7  CH7
	-- 9  UNKNOWN
	-- 10 UNKNOWN
	-- 11 CL1
	-- 12 CL2
	-- 13 CL3
	-- 14 CL4
	-- 15 CL5
	-- 16 CL6
	-- 17 CL7
	-- 18 CL9

	local heating_curve_heating = p.p_370
	-- 0  Uit
	-- 1  HH1
	-- 2  HH2
	-- 3  HH3
	-- 4  HH4
	-- 5  HH5
	-- 6  HH6
	-- 7  HH7
	-- 8  HH8
	-- 9  UNKNOWN
	-- 10 UNKNOWN
	-- 11 LH1
	-- 12 LH2
	-- 13 LH3
	-- 14 LH4
	-- 15 LH5
	-- 16 LH6
	-- 17 LH7
	-- 18 LH8


	local mode = p.p_363 -- Already zero indexed
	-- 0 cooling
	-- 1 heating
	-- 2 warm water
	-- 3 UNKNOWN
	-- 4 UNKNOWN
	-- 5 heating and warm water

	if mode == 0 then
		-- Aurora 2 updates these automatically if there is a heating curve active
		degrees_f32_set_water_temp = p.p_367 -- cooling
	elseif mode == 1 then
		-- Aurora 2 updates these automatically if there is a heating curve active
		degrees_f32_set_water_temp = p.p_593 -- heating
	end

	------------------------------------------------------------
	-- Raw sensors
	------------------------------------------------------------
	local flow_lmin    = p.p_373:unwrap_or(0.0)
	local supply_temp  = p.p_290:unwrap_or(0.0)
	local return_temp  = p.p_328:unwrap_or(0.0)

	local voltage      = p.p_331:unwrap_or(0.0)
	local current      = (p.p_332:unwrap_or(0.0)) / 100

	-- sample period (5 minutes)
	local sample_hours = 5.0 / 60.0

	------------------------------------------------------------
	-- Instant power (kW)
	------------------------------------------------------------
	local thermal_kw   =
			(flow_lmin / 60) * 4.186 * (supply_temp - return_temp)

	-- \/ matches the result of p.p_333.unwrap_or(0.0) / 100.0
	local electric_kw  =
			(voltage * current) / 1000

	------------------------------------------------------------
	-- Energy per sample (kWh)
	------------------------------------------------------------
	local thermal_kwh  = thermal_kw * sample_hours
	local electric_kwh = electric_kw * sample_hours

	------------------------------------------------------------
	-- Instant COP (safe)
	------------------------------------------------------------
	local cop          = 0.0
	if electric_kw > 0 and heatpump_actively_heating then
		cop = math.max(0.0, thermal_kw / electric_kw)
	end

	------------------------------------------------------------
	-- 24h energy (ASSUMES p already stores rolling kWh totals)
	-- IMPORTANT: these MUST be kWh, not kW
	------------------------------------------------------------
	local thermal_24h =
			p.prev_kwh_f32_thermal_energy_24h:unwrap_or(0.0)
			- (p.day_ago_kwh_f32_thermal_energy:unwrap_or(0.0))
			+ thermal_kwh

	local electric_24h =
			p.prev_kwh_f32_electric_energy_24h:unwrap_or(0.0)
			- p.day_ago_kwh_f32_electric_energy:unwrap_or(0.0)
			+ electric_kwh

	local cop_24h = 0.0
	if electric_24h > 0 and heatpump_actively_heating then
		cop_24h = thermal_24h / electric_24h
	end

	------------------------------------------------------------
	-- Totals (energy-based accumulation)
	------------------------------------------------------------
	---
	local thermal_total =
			p.prev_kwh_f32_thermal_energy_total:unwrap_or(0.0) + thermal_kwh

	local electric_total =
			p.prev_kwh_f32_electric_energy_total:unwrap_or(0.0) + electric_kwh

	------------------------------------------------------------
	-- Return structured output
	------------------------------------------------------------
	return {

		--------------------------------------------------------
		-- Control
		--------------------------------------------------------
		degrees_f32_set_water_temp = degrees_f32_set_water_temp,
		enum_f32_heating_mode = mode,

		--------------------------------------------------------
		-- Temperatures
		--------------------------------------------------------
		degrees_f32_desired_temp = p.p_8,
		degrees_f32_outside_temp = p.p_22,
		degrees_f32_return_temp = degrees_f32_return_temp,
		degrees_f32_room_temp = p.p_9,
		degrees_f32_supply_temp = degrees_f32_supply_temp,

		--------------------------------------------------------
		-- Heating curve
		--------------------------------------------------------
		degrees_f32_heating_curve_high = p.p_370,
		degrees_f32_heating_curve_low = p.p_370,
		degrees_f32_heating_start_ambient_temp = p.p_341,
		degrees_f32_set_temp_heating_curve = p.p_3,
		enum_f32_heating_curve_preset = p.p_370,
		onoff_f32_custom_heating_curve = p.p_418,

		--------------------------------------------------------
		-- Power (instant)
		--------------------------------------------------------
		kw_f32_thermal_power = thermal_kw,
		kw_f32_electric_power = electric_kw,
		percent_f32_cop = cop,

		--------------------------------------------------------
		-- Energy (sample-based)
		--------------------------------------------------------
		kwh_f32_thermal_energy = thermal_kwh,
		kwh_f32_electric_energy = electric_kwh,

		--------------------------------------------------------
		-- 24h energy + COP
		--------------------------------------------------------
		kwh_f32_thermal_energy_24h = thermal_24h,
		kwh_f32_electric_energy_24h = electric_24h,
		percent_f32_cop_24h = cop_24h,

		--------------------------------------------------------
		-- Totals
		--------------------------------------------------------
		kwh_f32_thermal_energy_total = thermal_total,
		kwh_f32_electric_energy_total = electric_total,

		--------------------------------------------------------
		-- Frequencies / flow
		--------------------------------------------------------
		hz_f32_compressor_frequency = hz_f32_compressor_frequency,
		hz_f32_fan_frequency = p.p_372,
		lmin_f32_water_flow = flow_lmin,

		--------------------------------------------------------
		-- Status
		--------------------------------------------------------
		onoff_f32_power_on = p.p_357,

		--------------------------------------------------------
		-- JAN controller
		--------------------------------------------------------
		degrees_f32_jan_control_max_temp = p.p_439,
		degrees_f32_jan_control_min_temp = p.p_440,
		sec_f32_jan_control_interval = p.p_441,
		x_f32_jan_control_Kp = p.p_821,
		x_f32_jan_control_Ki = p.p_820,
		x_f32_jan_control_Kd = p.p_822,
		x_f32_jan_control_output_to_device = p.p_442,
		x_f32_jan_control_output_to_sdk = p.p_437,
	}
end
