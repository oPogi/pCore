return {
    Locale_Garage = {
        ["Target_label"] = "Garage",
        ["Target_icon"] = "fa fa-car",
        ["Target_iconColor"] = "white",
        ["Target_label_veh"] = "Ranger le véhicule",
        ["Target_icon_veh"] = "fa fa-car",
        ["Target_iconColor_veh"] = "white",
        ["Menu_title"] = "Garage",
        ["Menu_description"] = "Sortir le véhicule: ",
        ["Menu_icon"] = "fa fa-car",
        ["Notif_ranger"] = "Vous avez ranger votre vehicule de service",
        ["Notif_ranger_error"] = "Ce n'est pas votre vehicule de service",
        ["Zone_label"] = "Appuie sur [E] pour ouvrir le garage",
        ["Zone_label_ranger"] = "Appuie sur [E] pour ranger le véhicule"
    },

    Garage = {
        {
            Plate = 'POLICE',
            Title = 'Garage Police',
            Job = 'police',
            VehiclesList = {
                { name = 'sultan', label = 'Sultan', grade = 3 },
            },
            Coords = vector3(328.44, -1373.52, 31.90),
            SpawnCoords = vector4(322.654938, -1374.131836, 31.908447, 48.18),
            CoordsRanger = vector3(220.786819, -884.505493, 30.678345), -- only if use marker
            DistanceDelete = 4
        },
       -- {
       --     Plate = 'POLICE',
       --     Title = 'Garage Police',
       --     Job = 'police',
       --     VehiclesList = {
       --         { name = 'sultan', label = 'Sultan', grade = 3 },
       --     },
       --     Coords = vector3(328.44, -1373.52, 31.90),
       --     SpawnCoords = vector4(322.654938, -1374.131836, 31.908447, 48.18),
       --     DistanceDelete = 4
       -- },
    }
}
