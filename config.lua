Config = {
    -- Filling configuration
    fillDuration = 100000, -- 10 seconds in milliseconds
    -- Max speed in miles per hour (converted to meters per second)
    maxSpeedMph = 40.0,
    -- Allowed vehicle models
    allowedVehicles = {
        "firetruk",
        "firetruk"
    },
	accelerationSlowdownFactor = 1.0,
    -- Refill locations
    refillLocations = {
        { x = 1240.08, y = -1479.96, z = 34.76 }, -- Example location 1
        { x = 1556.88, y = 3901.96, z = 31.16 }, -- Example location 2
        { x = -665.48, y = 6167.13, z = 1.07 }, -- Example location 3
    }
}
