-- Device:           Aurora 3 pro
-- Module provider:  Alflex
-- raw modbus -> intermediate representation

return function(p)
	return {
		degrees_f32_set_water_temp_raw = p.input_57,
		degrees_f32_set_water_temp = p.input_57:unwrap_or(0.0) / 10,
		degrees_f32_room_temp = nil,
		degrees_f32_desired_temp = nil,
		degrees_f32_outside_temp_raw = p.input_51,
		degrees_f32_outside_temp = p.input_51:unwrap_or(0.0) / 10,
		degrees_f32_supply_temp_raw = p.input_44,
		degrees_f32_supply_temp = p.input_44:unwrap_or(0.0) / 10,
		degrees_f32_return_temp_raw = p.input_43,
		degrees_f32_return_temp = p.input_43:unwrap_or(0.0) / 10,
		lmin_f32_water_flow_raw = p.input_65,
		lmin_f32_water_flow = p.input_65:unwrap_or(0.0) / 10,
		degrees_f32_heating_start_ambient_temp = p.holding_6041,
		onoff_f32_power_on = p.holding_2102:unwrap_or(0.0) > 0 and 0 or 1,
		enum_f32_heating_mode = p.holding_2101,
		enum_f32_heating_curve_cooling_low_temp = p.holding_6188,
		enum_f32_heating_curve_cooling_high_temp = p.holding_6189,
		enum_f32_cooling_type = p.holding_6184,
		enum_f32_heating_curve_heating_low_temp = p.holding_6190,
		enum_f32_heating_type = p.holding_6185,
		enum_f32_heating_curve_heating_high_temp = p.holding_6191,
		hz_f32_compressor_frequency = p.input_80,
		hz_f32_fan_frequency_raw = p.input_73,
		hz_f32_fan_frequency = p.input_73:unwrap_or(0.0) / 60,
		kwh_f32_power_used = math.floor(p.input_1231:unwrap_or(0.0)) << 16 & math.floor(p.input_1232:unwrap_or(0.0)),
		kwh_f32_power_delivered = (math.floor(p.input_1233:unwrap_or(0.0)) << 16) &
				math.floor(p.input_1234:unwrap_or(0.0)) + (math.floor(p.input_1235:unwrap_or(0.0)) << 16) &
				math.floor(p.input_1236:unwrap_or(0.0)),
		enum_f32_sound_mode = p.holding_2104,
		degrees_f32_manual_set_temp_heating = p.holding_2108,
		degrees_f32_manual_set_temp_cooling = p.holding_2107,
		enum_f32_set_temp_type = p.holding_6124,
		minutes_f32_heating_curve_heating_refresh_time = p.holding_6197,
		minutes_f32_heating_curve_cooling_refresh_time = p.holding_6196,
		degrees_f32_custom_heating_heating_curve_water_temp_1 = p.holding_6204,
		degrees_f32_custom_heating_heating_curve_outside_temp_1 = p.holding_6202,
		degrees_f32_custom_heating_heating_curve_water_temp_2 = p.holding_6205,
		degrees_f32_custom_heating_heating_curve_outside_temp_2 = p.holding_6203,
		degrees_f32_custom_heating_cooling_curve_water_temp_1 = p.holding_6200,
		degrees_f32_custom_heating_cooling_curve_outside_temp_1 = p.holding_6198,
		degrees_f32_custom_heating_cooling_curve_water_temp_2 = p.holding_6201,
		degrees_f32_custom_heating_cooling_curve_outside_temp_2 = p.holding_6199,
		degrees_f32_hysteresis_ta = p.holding_6001,
		degrees_f32_hysteresis_a = p.holding_6089,
		enum_f32_circulation_pump_mode = p.holding_6273,
		percentage_f32_circulation_pump_max_speed = p.holding_6272,
		percentage_f32_circulation_pump_min_speed = p.holding_6062,
		percentage_f32_circulation_pump_speed_at_set_temp = p.holding_6051,
		m3hour_f32_nominal_water_flow = p.holding_6212,
		onoff_f32_boiler_assistance = p.holding_6036,
		enum_f32_external_heating_type = p.holding_6121,
		degrees_f32_coil_temp_raw = p.input_50,
		degrees_f32_coil_temp = p.input_50:unwrap_or(0.0) / 10,
		bar_f32_outlet_water_pressure_raw = p.input_62,
		bar_f32_outlet_water_pressure = p.input_62:unwrap_or(0.0) / 10,
		percentage_f32_dc_pump_feedback_pwm = p.input_64,
		degrees_f32_zone_1_weather_temp_curve_cooling_set_temp = p.input_67,
		degrees_f32_zone_1_weather_temp_curve_heating_set_temp = p.input_68,
		rpm_f32_no_1_dc_fan_speed = p.input_73,
		rpm_f32_no_2_dc_fan_speed = p.input_74,
		volt_f32_ac_input_voltage = p.input_75,
		amp_f32_ac_input_current = p.input_76,
		onoff_f32_main_water_pump_switch_status = p.input_81,
		onoff_f32_four_way_valve_switch_status = p.input_81,
		volt_f32_single_phase_power_supply_voltage = p.input_1225,
		amp_f32_single_phase_power_supply_current = p.input_1226:unwrap_or(0.0) / 10,
		amp_f32_single_phase_power_supply_current_raw = p.input_1226,
		volt_f32_three_phase_power_supply_voltage_b = p.input_1227,
		amp_f32_three_phase_power_supply_current_b = p.input_1228:unwrap_or(0.0) / 10,
		amp_f32_three_phase_power_supply_current_b_raw = p.input_1228,
		volt_f32_three_phase_power_supply_voltage_c = p.input_1229,
		amp_f32_three_phase_power_supply_current_c = p.input_1230:unwrap_or(0.0) / 10,
		amp_f32_three_phase_power_supply_current_c_raw = p.input_1230,
		s_f32_energy_efficiency = p.input_1239,

		-- "error_hydraulic_module_communication","bitand(input_91, 1)",Bit
		-- "error_discharge_temperature_sensor","bitand(input_91, 2)",Bit
		-- "error_coil_temperature_sensor","bitand(input_91, 4)",Bit
		-- "error_ambient_temperature_sensor","bitand(input_91, 8)",Bit
		-- "error_refrigerant_liquid_temperature_sensor_error","bitand(input_91, 16)",Bit
		-- "error_suction_temperature_sensor","bitand(input_91, 32)",Bit
		-- "error_domestic_water_temperature_sensor","bitand(input_91, 64)",Bit
		-- "error_inlet_water_temperature_sensor","bitand(input_91, 128)",Bit
		-- "error_outlet_water_temperature_sensor","bitand(input_91, 256)",Bit
		-- "error_refrigerant_system_communication","bitand(input_91, 512)",Bit
		-- "error_discharge_pressure_sensor","bitand(input_91, 4096)",Bit
		-- "error_low_pressure_sensor","bitand(input_91, 8192)",Bit
		-- "error_dc_bus_voltage_too_low","bitand(input_91, 16384)",Bit
		-- "error_dc_bus_voltage_too_high","bitand(input_91, 32768)",Bit
		-- "error_peak_ac_input_current_too_high","bitand(input_92, 1)",Bit
		-- "error_abnormal_ipm_module","bitand(input_92, 2)",Bit
		-- "error_abnormal_pfc_module","bitand(input_92, 4)",Bit
		-- "error_compressor_startup_failure","bitand(input_92, 8)",Bit
		-- "error_compressor_phase_loss","bitand(input_92, 16)",Bit
		-- "error_inverter_module_reset","bitand(input_92, 32)",Bit
		-- "error_compressor_current_too_high","bitand(input_92, 64)",Bit
		-- "error_pcf_module_temperature_too_high","bitand(input_92, 128)",Bit
		-- "error_current_detection_circuit_failure","bitand(input_92, 256)",Bit
		-- "error_out_of_step_protection","bitand(input_92, 512)",Bit
		-- "error_pfc_module_temperature_sensor","bitand(input_92, 1024)",Bit
		-- "error_refirgerant_system_inverter_pcb_data_communication","bitand(input_92, 2048)",Bit
		-- "error_ipm_module_temperature_too_high","bitand(input_92, 4096)",Bit
		-- "error_ipm_module_temperature_sensor","bitand(input_92, 8192)",Bit
		-- "error_abnormal_ac_input_power_supply","bitand(input_93, 2)",Bit
		-- "error_inverter_module_debugging_data","bitand(input_93, 4)",Bit
		-- "error_power_off_reset","bitand(input_93, 8)",Bit
		-- "error_final_water_temperature_sensor","bitand(input_94, 1)",Bit
		-- "error_solar_temperature_sensor_tso","bitand(input_94, 2)",Bit
		-- "error_wire_controller_built-in_temperature_sensor_tro_faulty","bitand(input_94, 4)",Bit
		-- "error_zone_2_temperature_sensor_tz2_error","bitand(input_94, 8)",Bit
		-- "error_up_temperature_sensor_te1_of_buffer_tank","bitand(input_94, 16)",Bit
		-- "error_down_temperature_sensor_te2_of_buffer_tank","bitand(input_94, 32)",Bit
		-- "error_outlet_water_pressure_sensor_ps1","bitand(input_94, 128)",Bit
		-- "error_gas_sensor_offline","bitand(input_94, 256)",Bit
		-- "error_gas_sensor_fault","bitand(input_94, 512)",Bit
		-- "error_unit_module_offline","bitand(input_94, 1024)",Bit
		-- "error_water_flow_failure","bitand(input_97, 1)",Bit
		-- "error_refrigerant_pressure_too_high","bitand(input_97, 2)",Bit
		-- "error_refrigerant_pressure_too_low","bitand(input_97, 4)",Bit
		-- "error_coil_too_hot","bitand(input_97, 8)",Bit
		-- "error_discharge_temperature_too_high","bitand(input_97, 16)",Bit
		-- "error_water_temperature_too_low","bitand(input_97, 32)",Bit
		-- "error_refrigerant_liquid_temperature_too_low","bitand(input_97, 64)",Bit
		-- "error_system_pressure_too_high","bitand(input_97, 128)",Bit
		-- "error_low_refrigerant_liquid","bitand(input_97, 512)",Bit
		-- "error_dc_fan_1_failure","bitand(input_97, 1024)",Bit
		-- "error_4-way valve_shifting_failure","bitand(input_97, 4096)",Bit
		-- "error_refrigerant_leakage","bitand(input_97, 8192)",Bit
		-- "error_built-in_dc_water_pump_abnormal","bitand(input_98, 16)",Bit
		-- "error_outlet_water_pressure_sensor","bitand(input_98, 256)",Bit
	}
end
