data:extend(
{
    {
        type = "int-setting",
        name = "stat-display-rate",
        setting_type = "runtime-global",
        default_value = 15,
        minimum_value = 1,
		order = "stat-a"
    },
	{
        type = "int-setting",
        name = "stat-polling-rate",
        setting_type = "runtime-global",
        default_value = 180,
        minimum_value = 1,
		order = "stat-b"
    },
	{
        type = "int-setting",
        name = "stat-scale-constant",
        setting_type = "runtime-global",
        default_value = 400,
		order = "stat-c"
    }
})