data:extend({
    --resolution, lerpSteps, radius, variance, windowSize
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
