Citizen.CreateThread(function()
    local toolkit = {
        -573669520
    }

    local engine = {
        "engine"
    }
    
    local wheel = {
        "wheel_rr"
    }

    local wheel2 = {
        "wheel_rf"
    }

    local wheel3 = {
        "wheel_lr"
    }

    local wheel4 = {
        "wheel_lf"
    }

    local exhaust = {
        "platelight"
    }

    local wtint = {
        "window_rr"
    }

    local wtint2 = {
        "window_rf"
    }

    local wtint3 = {
        "window_lr"
    }

    local wtint4 = {
        "window_lf"
    }    
    
    exports["bt-target"]:AddTargetModel(toolkit, {
        options = {
            {
                event = "pd-mechanic:engine",
                icon = "fas fa-cogs",
                label = "Pick up Engine",
            },
            {
                event = "pd-mechanic:brakes",
                icon = "fas fa-cogs",
                label = "Pick up Brakes",
            },
            {
                event = "pd-mechanic:transmission",
                icon = "fas fa-cogs",
                label = "Pick up Tms",
            },
            {
                event = "pd-mechanic:suspension",
                icon = "fas fa-cogs",
                label = "Pick up Spn",
            },
            {
                event = "pd-mechanic:armor",
                icon = "fas fa-cogs",
                label = "Pick up Armor",
            },
            {
                event = "pd-mechanic:turbo",
                icon = "fas fa-cogs",
                label = "Pick up Turbo",
            },
            {
                event = "pd-mechanic:wheel",
                icon = "fas fa-cogs",
                label = "Pick up Wheel",
            },
            {
                event = "pd-mechanic:sideskirt",
                icon = "fas fa-cogs",
                label = "Pick up Sideskirt",
            },
            {
                event = "pd-mechanic:roof",
                icon = "fas fa-cogs",
                label = "Pick up Roof",
            },
            {
                event = "pd-mechanic:neon",
                icon = "fas fa-cogs",
                label = "Pick up Neons",
            },
            {
                event = "pd-mechanic:horn",
                icon = "fas fa-cogs",
                label = "Pick up Horn",
            }
        },
        job = {"mechanic"},
        distance = 3.5
    })

    exports["bt-target"]:AddCircleZone("mechanicmenu2", vector3(-33.97, -1040.62, 28.55), 0.6, {
        name="mechanicmenu2",
        debugPoly=false,
        useZ=true,
        }, {
            options = {  
                {
                    event = "pd-mechanic:spoilers",
                    icon = "fas fa-cogs",
                    label = "Pick up Spoiler",
                },
                {
                    event = "pd-mechanic:plate",
                    icon = "fas fa-cogs",
                    label = "Pick up Plate",
                },
                {
                    event = "pd-mechanic:exhaust",
                    icon = "fas fa-cogs",
                    label = "Pick up Exhaust",
                },
                {
                    event = "pd-mechanic:wtint",
                    icon = "fas fa-cogs",
                    label = "Pick up WTint",
                },
                {
                    event = "pd-mechanic:fbumper",
                    icon = "fas fa-cogs",
                    label = "Pick up FBumper",
                },
                {
                    event = "pd-mechanic:rbumper",
                    icon = "fas fa-cogs",
                    label = "Pick up RBumper",
                },
                {
                    event = "pd-mechanic:hood",
                    icon = "fas fa-cogs",
                    label = "Pick up Hood",
                },
                {
                    event = "pd-mechanic:grille",
                    icon = "fas fa-cogs",
                    label = "Pick up Grille",
                },
                {
                    event = "pd-mechanic:cage",
                    icon = "fas fa-cogs",
                    label = "Pick up Cage",
                },
                {
                    event = "pd-mechanic:xenon",
                    icon = "fas fa-cogs",
                    label = "Pick up Xenons",
                }
            },
            job = {"mechanic"},
            distance = 3.5
        })

    exports["bt-target"]:AddTargetBone(engine, {
        options = {
            {
                event = "pd-mechanic:enginemenu",
                icon = "fas fa-tools",
                label = "Change Engine",
            },
            {
                event = "pd-mechanic:turbomenu",
                icon = "fas fa-tools",
                label = "Change Turbo",
            },
            {
                event = "pd-mechanic:transmissionmenu",
                icon = "fas fa-tools",
                label = "Change Tms",
            },
            {
                event = "pd-mechanic:fbumpermenu",
                icon = "fas fa-tools",
                label = "Change Bumper",
            },
            {
                event = "pd-mechanic:hoodmenu",
                icon = "fas fa-tools",
                label = "Change Hood",
            },
            {
                event = "pd-mechanic:hornmenu",
                icon = "fas fa-tools",
                label = "Change Horn",
            },
            {
                event = "pd-mechanic:grillemenu",
                icon = "fas fa-tools",
                label = "Change Grille",
            },
            {
                event = "pd-mechanic:xenonmenu",
                icon = "fas fa-tools",
                label = "Change Xenons",
            },
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wheel, {
        options = {
            {
                event = "pd-mechanic:wheelmenu",
                icon = "fas fa-tools",
                label = "Change Wheel",
            },
            {
                event = "pd-mechanic:brakesmenu",
                icon = "fas fa-tools",
                label = "Change Brakes",
            },
            {
                event = "pd-mechanic:suspensionmenu",
                icon = "fas fa-tools",
                label = "Change Spn",
            },
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wheel2, {
        options = {
            {
                event = "pd-mechanic:wheelmenu",
                icon = "fas fa-tools",
                label = "Change Wheel",
            },
            {
                event = "pd-mechanic:brakesmenu",
                icon = "fas fa-tools",
                label = "Change Brakes",
            },
            {
                event = "pd-mechanic:suspensionmenu",
                icon = "fas fa-tools",
                label = "Change Spn",
            },
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wheel3, {
        options = {
            {
                event = "pd-mechanic:wheelmenu",
                icon = "fas fa-tools",
                label = "Change Wheel",
            },
            {
                event = "pd-mechanic:brakesmenu",
                icon = "fas fa-tools",
                label = "Change Brakes",
            },
            {
                event = "pd-mechanic:suspensionmenu",
                icon = "fas fa-tools",
                label = "Change Spn",
            },
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wheel4, {
        options = {
            {
                event = "pd-mechanic:wheelmenu",
                icon = "fas fa-tools",
                label = "Change Wheel",
            },
            {
                event = "pd-mechanic:brakesmenu",
                icon = "fas fa-tools",
                label = "Change Brakes",
            },
            {
                event = "pd-mechanic:suspensionmenu",
                icon = "fas fa-tools",
                label = "Change Spn",
            },
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(exhaust, {
        options = {
            {
                event = "pd-mechanic:spoilersmenu",
                icon = "fas fa-tools",
                label = "Change Spoiler",
            },
            {
                event = "pd-mechanic:exhaustmenu",
                icon = "fas fa-tools",
                label = "Change Exhaust",
            },
            {
                event = "pd-mechanic:platesmenu",
                icon = "fas fa-tools",
                label = "Change Plate",
            },
            {
                event = "pd-mechanic:rbumpermenu",
                icon = "fas fa-tools",
                label = "Change Bumper",
            }
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wtint, {
        options = {
            {
                event = "pd-mechanic:roofmenu",
                icon = "fas fa-tools",
                label = "Change Roof",
            },
            {
                event = "pd-mechanic:wtintmenu",
                icon = "fas fa-tools",
                label = "Change WTint",
            },
            {
                event = "pd-mechanic:cagemenu",
                icon = "fas fa-tools",
                label = "Change Cage",
            },
            {
                event = "pd-mechanic:armormenu",
                icon = "fas fa-tools",
                label = "Change Armor",
            },
            {
                event = "pd-mechanic:sideskirtmenu",
                icon = "fas fa-tools",
                label = "Change Sideskirt",
            },
            {
                event = "pd-mechanic:neonmenu",
                icon = "fas fa-tools",
                label = "Change Neons",
            }
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wtint2, {
        options = {
            {
                event = "pd-mechanic:roofmenu",
                icon = "fas fa-tools",
                label = "Change Roof",
            },
            {
                event = "pd-mechanic:wtintmenu",
                icon = "fas fa-tools",
                label = "Change WTint",
            },
            {
                event = "pd-mechanic:cagemenu",
                icon = "fas fa-tools",
                label = "Change Cage",
            },
            {
                event = "pd-mechanic:armormenu",
                icon = "fas fa-tools",
                label = "Change Armor",
            },
            {
                event = "pd-mechanic:sideskirtmenu",
                icon = "fas fa-tools",
                label = "Change Sideskirt",
            },
            {
                event = "pd-mechanic:neonmenu",
                icon = "fas fa-tools",
                label = "Change Neons",
            }
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wtint3, {
        options = {
            {
                event = "pd-mechanic:roofmenu",
                icon = "fas fa-tools",
                label = "Change Roof",
            },
            {
                event = "pd-mechanic:wtintmenu",
                icon = "fas fa-tools",
                label = "Change WTint",
            },
            {
                event = "pd-mechanic:cagemenu",
                icon = "fas fa-tools",
                label = "Change Cage",
            },
            {
                event = "pd-mechanic:armormenu",
                icon = "fas fa-tools",
                label = "Change Armor",
            },
            {
                event = "pd-mechanic:sideskirtmenu",
                icon = "fas fa-tools",
                label = "Change Sideskirt",
            },
            {
                event = "pd-mechanic:neonmenu",
                icon = "fas fa-tools",
                label = "Change Neons",
            }
        },
        job = {"mechanic"},
        distance = 1.0
    })

    exports["bt-target"]:AddTargetBone(wtint4, {
        options = {
            {
                event = "pd-mechanic:roofmenu",
                icon = "fas fa-tools",
                label = "Change Roof",
            },
            {
                event = "pd-mechanic:wtintmenu",
                icon = "fas fa-tools",
                label = "Change WTint",
            },
            {
                event = "pd-mechanic:cagemenu",
                icon = "fas fa-tools",
                label = "Change Cage",
            },
            {
                event = "pd-mechanic:armormenu",
                icon = "fas fa-tools",
                label = "Change Armor",
            },
            {
                event = "pd-mechanic:sideskirtmenu",
                icon = "fas fa-tools",
                label = "Change Sideskirt",
            },
            {
                event = "pd-mechanic:neonmenu",
                icon = "fas fa-tools",
                label = "Change Neons",
            }
        },
        job = {"mechanic"},
        distance = 1.0
    })
end)