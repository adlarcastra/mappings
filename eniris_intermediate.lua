-- Device:            Eniris Module
-- Module provider:   Eniris
-- eniris monitoring web hook -> intermediate representation

return function(p)
	------------------------------------------------------------
	-- Helpers
	------------------------------------------------------------

	local function f32(value)
		return value:unwrap_or(0.0)
	end

	local function kwh_from_wh(value)
		return value:unwrap_or(0.0) / 1000
	end

	------------------------------------------------------------
	-- Power
	------------------------------------------------------------

	local solar_power = f32(p.solar_active_power_W)
	local battery_power = f32(p.storage_active_power_W)
	local grid_power = f32(p.grid_active_power_W)

	local devices_power = f32(p.switched_load_active_power_W)
	local ev_power = f32(p.variable_power_load_active_power_W)

	------------------------------------------------------------
	-- Total house consumption
	--
	-- Power balance:
	--
	--   solar + battery + grid + residual + devices + EV = 0
	--
	-- Therefore:
	--
	--   residual = -(solar + battery + grid + devices + EV)
	--
	-- Total household consumption:
	--
	--   house = residual + devices + EV
	------------------------------------------------------------

	local residual_power = -1 * (solar_power + battery_power + grid_power + devices_power + ev_power)

	local total_house_power =
			residual_power
			+ devices_power
			+ ev_power

	------------------------------------------------------------
	-- Return structured output
	--
	-- Naming convention:
	--   <unit>_<datatype>_<snake_case_name>
	------------------------------------------------------------

	return {

		--------------------------------------------------------
		-- Solar
		--------------------------------------------------------

		w_f32_solar_power =
				solar_power,

		--------------------------------------------------------
		-- Battery
		--------------------------------------------------------

		w_f32_battery_power =
				battery_power,

		kwh_f32_battery_energy_stored =
				kwh_from_wh(p.storage_energy_stored_Wh),

		kwh_f32_battery_energy_capacity =
				kwh_from_wh(p.storage_energy_capacity_Wh),

		--------------------------------------------------------
		-- Grid
		--------------------------------------------------------

		w_f32_grid_power =
				grid_power,

		--------------------------------------------------------
		-- Household consumption
		--------------------------------------------------------

		w_f32_residual_power =
				residual_power,

		w_f32_devices_power =
				devices_power,

		w_f32_ev_power =
				ev_power,

		w_f32_total_house_power =
				total_house_power
	}
end
