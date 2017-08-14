data:extend({
	{
		type = "double-setting",
		name = "ti-level-deepwater",
		setting_type = "runtime-global",
		default_value = 0.0,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-01"
	},
	{
		type = "double-setting",
		name = "ti-level-water",
		setting_type = "runtime-global",
		default_value = 0.35,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-02"
	},
	{
		type = "double-setting",
		name = "ti-level-grass",
		setting_type = "runtime-global",
		default_value = 0.55,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-03"
	},
	{
		type = "double-setting",
		name = "ti-level-grass-medium",
		setting_type = "runtime-global",
		default_value = 0.6,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-04"
	},
	{
		type = "double-setting",
		name = "ti-level-grass-dry",
		setting_type = "runtime-global",
		default_value = 0.65,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-05"
	},
	{
		type = "double-setting",
		name = "ti-level-sand-dark",
		setting_type = "runtime-global",
		default_value = 0.95,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-06"
	},
	{
		type = "double-setting",
		name = "ti-level-red-desert-dark",
		setting_type = "runtime-global",
		default_value = 1.0,
		minimum_value = -1.0,
		maximum_value = 1.0,
		order = "l-07"
	},
	{
        type = "int-setting",
        name = "ti-noise-period",
        setting_type = "runtime-global",
        default_value = 128,
        minimum_value = 1,
        maximum_value = 1000,
        order = "n-01",
    },
    {
        type = "int-setting",
        name = "ti-noise-octaves",
        setting_type = "runtime-global",
        default_value = 5,
        minimum_value = 1,
        maximum_value = 8,
        order = "n-02",
    },
    {
        type = "int-setting",
        name = "ti-noise-persistence",
        setting_type = "runtime-global",
        default_value = 150,
        minimum_value = 1,
        maximum_value = 1000,
        order = "n-03",
    },
    {
        type = "int-setting",
        name = "ti-starting-area-resolution",
        setting_type = "runtime-global",
        default_value = 96,
        minimum_value = 16,
        maximum_value = 512,
        order = "sa-01"
    },
    {
        type = "int-setting",
        name = "ti-starting-area-lerpsteps",
        setting_type = "runtime-global",
        default_value = 256,
        minimum_value = 32,
        maximum_value = 512,
        order = "sa-03"
    },
    {
        type = "int-setting",
        name = "ti-starting-area-radius",
        setting_type = "runtime-global",
        default_value = 100,
        minimum_value = 10,
        maximum_value = 1000,
        order = "sa-04"
    },
    {
        type = "int-setting",
        name = "ti-starting-area-variance",
        setting_type = "runtime-global",
        default_value = 100,
        minimum_value = 10,
        maximum_value = 1000,
        order = "sa-05"
    },
    {
        type = "int-setting",
        name = "ti-starting-area-windowsize",
        setting_type = "runtime-global",
        default_value = 15,
        minimum_value = 1,
        maximum_value = 1000,
        order = "sa-06"
    },
})