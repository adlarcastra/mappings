-- Device:            Eniris Module
-- Module provider:   Eniris
-- eniris monitoring web hook -> intermediate representation

return function(p)
	local storage_capacity = p.storage_energy_capacity_Wh:unwrap_or(0.0) / 1000
	local storage_stored = p.storage_energy_stored_Wh:unwrap_or(0.0) / 1000

	------------------------------------------------------------
	-- Return structured output
	------------------------------------------------------------
	return {
		kwh_f32_storage_capacity = storage_capacity,
		kwh_f32_storage_stored = storage_stored
	}
end
