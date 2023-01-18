local LSNORD = {}

function LSNORD.CanBuy(cost)
    print(cost)
    local can = nil
    TriggerServerCallback(
        "getBankingAccountsPly3",
        function(result)
            amount = result[1].amount
            if amount - cost >= 0 then
                can = true
            else
                ShowNotification("~r~Pas assez d'argent dans le compte du FlyWheels !")
                can = false
            end
        end,
        "mecano2"
    )
    while can == nil do
        Wait(1)
    end
    return can
end

LSNORD.BUY = function(cost)
    TriggerServerEvent("bankingRemoveFromAccount2", "mecano2", cost)
end

local customs = {
    {
        title = "Aileron",
        mod = 0,
        startingcost = 3,
        data = {}
    },
    {
        title = "Pare-chocs avant",
        mod = 1,
        startingcost = 1,
        data = {}
    },
    {
        title = "Pare-chocs arrière",
        mod = 2,
        startingcost = 2,
        data = {}
    },
    {
        title = "Bas de caisse",
        mod = 3,
        startingcost = 2,
        data = {}
    },
    {
        title = "Échappement",
        mod = 4,
        startingcost = 1,
        data = {}
    },
    {
        title = "Cage",
        mod = 5,
        startingcost = 4,
        data = {}
    },
    {
        title = "Grille",
        mod = 6,
        startingcost = 3,
        data = {}
    },
    {
        title = "Capot",
        mod = 7,
        startingcost = 5,
        data = {}
    },
    {
        title = "Aile gauche",
        mod = 8,
        startingcost = 3,
        data = {}
    },
    {
        title = "Aile droite",
        mod = 9,
        startingcost = 3,
        data = {}
    },
    {
        title = "Toit",
        mod = 10,
        startingcost = 5,
        data = {}
    },
    {
        title = "Stickers",
        mod = 48,
        startingcost = 8,
        data = {}
    },
    {
        title = "Bloc moteur",
        mod = 39,
        startingcost = 5,
        data = {}
    },
    {
        title = "Filtre à air",
        mod = 40,
        startingcost = 1,
        data = {}
    },
    {
        title = "Siège",
        mod = 32,
        startingcost = 3,
        data = {}
    },
    {
        title = "Compteur",
        mod = 30,
        startingcost = 2,
        data = {}
    },
    {
        title = "Volant",
        mod = 33,
        startingcost = 1,
        data = {}
    },
    {
        title = "Tableau de bord",
        mod = 29,
        startingcost = 2,
        data = {}
    },
    {
        title = "Phares",
        mod = 42,
        startingcost = 2,
        data = {}
    },
    {
        title = "Calandre",
        mod = 43,
        startingcost = 5,
        data = {}
    },
    {
        title = "Réservoir",
        mod = 45,
        startingcost = 1,
        data = {}
    },
    {
        title = "Prise d'air",
        mod = 44,
        startingcost = 5,
        data = {}
    },
    {
        title = "Coffre",
        mod = 37,
        startingcost = 2,
        data = {}
    },
    {
        title = "Levier de vitesse",
        mod = 34,
        startingcost = 1,
        data = {}
    },
    {
        title = "Ornement",
        mod = 28,
        startingcost = 5,
        data = {}
    },
    {
        title = "Contour de plaque",
        mod = 25,
        startingcost = 2,
        data = {}
    },
    {
        title = "Plaque vitre arrière",
        mod = 26,
        startingcost = 2,
        data = {}
    },
    {
        title = "Portière",
        mod = 31,
        startingcost = 2,
        data = {}
    },
    {
        title = "Haut parleurs",
        mod = 36,
        startingcost = 2,
        data = {}
    },
    {
        title = "Plaques",
        mod = 35,
        startingcost = 2,
        data = {}
    },
    {
        title = "Pompe hydrolique",
        mod = 38,
        startingcost = 15,
        data = {}
    },
    {
        title = "Moteur",
        data = {
            {name = "Amélioration moteur niveau 1", mt = 11, mod = -1, cost = 20},
            {name = "Amélioration moteur niveau 2", mt = 11, mod = 0, cost = 30},
            {name = "Amélioration moteur niveau 3", mt = 11, mod = 1, cost = 40},
            {name = "Amélioration moteur niveau 4", mt = 11, mod = 2, cost = 50}
        }
    },
    {
        title = "Freins",
        data = {
            {name = "Freins de série", mt = 12, mod = -1, cost = 10},
            {name = "Freins milieu de gamme", mt = 12, mod = 0, cost = 12.5},
            {name = "Freins sportifs", mt = 12, mod = 1, cost = 15},
            {name = "Freins de course", mt = 12, mod = 2, cost = 20}
        }
    },
    {
        title = "Transmission",
        data = {
            {name = "Transmission de série", mod = -1, mt = 13, cost = 15},
            {name = "Transmission milieu de gamme", mod = 0, mt = 13, cost = 17.5},
            {name = "Transmission sportive", mod = 1, mt = 13, cost = 20},
            {name = "Transmission de course", mod = 2, mt = 13, cost = 25}
        }
    },
    {
        title = "Klaxon",
        data = {
            {name = "Klaxon par défaut", mt = 14, mod = -1, cost = 0},
            {name = "Klaxon de camion", mt = 14, mod = 0, cost = 2},
            {name = "Klaxon camion de glace", mt = 14, mod = 1, cost = 2},
            {name = "Klaxon clown", mt = 14, mod = 2, cost = 2},
            {name = "Klaxon musical 1", mt = 14, mod = 3, cost = 2},
            {name = "Klaxon musical 2", mt = 14, mod = 4, cost = 2},
            {name = "Klaxon musical 3", mt = 14, mod = 5, cost = 2},
            {name = "Klaxon musical 4", mt = 14, mod = 6, cost = 2},
            {name = "Klaxon musical 5", mt = 14, mod = 7, cost = 2},
            {name = "Klaxon trombone triste", mt = 14, mod = 8, cost = 2},
            {name = "Klaxon classique 1", mt = 14, mod = 9, cost = 2},
            {name = "Klaxon classique 2", mt = 14, mod = 10, cost = 2},
            {name = "Klaxon classique 3", mt = 14, mod = 11, cost = 2},
            {name = "Klaxon classique 4", mt = 14, mod = 12, cost = 2},
            {name = "Klaxon classique 5", mt = 14, mod = 13, cost = 2},
            {name = "Klaxon classique 6", mt = 14, mod = 14, cost = 2},
            {name = "Klaxon classique 7", mt = 14, mod = 15, cost = 2},
            {name = "Klaxon note Do", mt = 14, mod = 16, cost = 2},
            {name = "Klaxon note Ré", mt = 14, mod = 17, cost = 2},
            {name = "Klaxon note Mi", mt = 14, mod = 18, cost = 2},
            {name = "Klaxon note Fa", mt = 14, mod = 19, cost = 2},
            {name = "Klaxon note Sol", mt = 14, mod = 20, cost = 2},
            {name = "Klaxon note La", mt = 14, mod = 21, cost = 2},
            {name = "Klaxon note Si", mt = 14, mod = 22, cost = 2},
            {name = "Klaxon note Do Diez", mt = 14, mod = 23, cost = 2},
            {name = "Klaxon Jazz 1", mt = 14, mod = 25, cost = 2},
            {name = "Klaxon Jazz 2", mt = 14, mod = 26, cost = 2},
            {name = "Klaxon Jazz 3", mt = 14, mod = 27, cost = 2},
            {name = "Klaxon Jazz en boucle", mt = 14, mod = 32, cost = 2},
            {name = "Klaxon musical aigüe 1", mt = 14, mod = 28, cost = 2},
            {name = "Klaxon musical aigüe 2", mt = 14, mod = 29, cost = 2},
            {name = "Klaxon musical aigüe 3", mt = 14, mod = 30, cost = 2},
            {name = "Klaxon musical aigüe 4", mt = 14, mod = 31, cost = 2},
            {name = "Klaxon classique boucle 1", mt = 14, mod = 33, cost = 2},
            {name = "Klaxon classique 8", mt = 14, mod = 34, cost = 2},
            {name = "Klaxon classique boucle 2", mt = 14, mod = 35, cost = 2}
        }
    },
    {
        title = "Suspension",
        data = {
            {name = "Suspension de série", mod = -1, mt = 15, cost = 10},
            {name = "Suspension améliorée", mod = 0, mt = 15, cost = 15},
            {name = "Suspension de rue", mod = 1, mt = 15, cost = 20},
            {name = "Suspension sportive", mod = 2, mt = 15, cost = 25},
            {name = "Suspension de compétition", mod = 3, mt = 15, cost = 30}
        }
    },
    {
        title = "Xénon",
        data = {
            {name = "Phares d'usine", bool = false, mt = 22, cost = 0},
            {name = "Phares Xénon", bool = true, mt = 22, cost = 5}
        }
    },
         ["Layout"] = {
             {name = "Aucun",cost = 0, b1 = true, b2 = false, b3 = false, b4 = false, colour = {255,255,255}},
             {name = "Devant,Arrière et côtés",cost = 8.5, b1 = true, b2 = true, b3 = true, b4 = true, colour = {255,255,255}},
         --},
         ["NeonColours"] = {
             {name = "Blanc", colour = {255,255,255}, cost = 1.5},
             {name = "Bleu", colour = {0,0,255}, cost = 1.5},
             {name = "Bleu électrique", colour = {0,150,255}, cost = 1.5},
             {name = "Vert menthe", colour = {50,255,155}, cost = 1.5},
             {name = "Vert lime", colour = {0,255,0}, cost = 1.5},
             {name = "Jaune", colour = {255,255,0}, cost = 1.5},
             {name = "Or", colour = {204,204,0}, cost = 1.5},
             {name = "Orange", colour = {255,128,0}, cost = 1.5},
             {name = "Rouge", colour = {255,0,0}, cost = 1.5},
             {name = "Rose", colour = {255,102,255}, cost = 1.5},
             {name = "Rose chaud", colour = {255,0,255}, cost = 1.5},
             {name = "Violet", colour = {153,0,153}, cost = 1.5},
         }
     },
    {
        title = "Plaques",
        data = {
            {name = "Bleu sur blanc 1", plateindex = 0, cost = 2},
            {name = "Bleu sur blanc 2", plateindex = 3, cost = 2},
            {name = "Bleu sur blanc 3", plateindex = 4, cost = 2},
            {name = "Jaune sur bleu", plateindex = 2, cost = 2},
            {name = "Jaune sur noir", plateindex = 1, cost = 2}
        }
    },
    {
        title = "Peintures",
        data = {
            ["Couleurs primaires"] = {
                ["Chrome"] = {
                    {name = "Chrome", cost = 2, colour = 120}
                },
                ["Classique"] = {
                    {name = "Noir", cost = 1.5, colour = 0},
                    {name = "Carbon noir", cost = 1.5, colour = 147},
                    {name = "Graphite", cost = 1.5, colour = 1},
                    {name = "Anhracite noir", cost = 1.5, colour = 11},
                    {name = "Noir acier", cost = 1.5, colour = 2},
                    {name = "Acier foncé", cost = 1.5, colour = 3},
                    {name = "Argent", cost = 1.5, colour = 4},
                    {name = "Argent bleué", cost = 1.5, colour = 5},
                    {name = "Acié laminé", cost = 1.5, colour = 6},
                    {name = "Argent ombré", cost = 1.5, colour = 7},
                    {name = "Argent pierre", cost = 1.5, colour = 8},
                    {name = "Argent sombre", cost = 1.5, colour = 9},
                    {name = "Argent solide", cost = 1.5, colour = 10},
                    {name = "Rouge", cost = 1.5, colour = 27},
                    {name = "Rouge torino", cost = 1.5, colour = 28},
                    {name = "Rouge formula", cost = 1.5, colour = 29},
                    {name = "Rouge lave", cost = 1.5, colour = 150},
                    {name = "Rouge blaze", cost = 1.5, colour = 30},
                    {name = "Rouge grâcieux", cost = 1.5, colour = 31},
                    {name = "Rouge grenat", cost = 1.5, colour = 32},
                    {name = "Rouge coucher de soleil", cost = 1.5, colour = 33},
                    {name = "Rouge cabernet", cost = 1.5, colour = 34},
                    {name = "Rouge vin", cost = 1.5, colour = 143},
                    {name = "Rouge bonbon", cost = 1.5, colour = 35},
                    {name = "Rose chaud", cost = 1.5, colour = 135},
                    {name = "Rose clair", cost = 1.5, colour = 137},
                    {name = "Rose saumon", cost = 1.5, colour = 136},
                    {name = "Orange lever de soleil", cost = 1.5, colour = 36},
                    {name = "Orange", cost = 1.5, colour = 38},
                    {name = "Orange clair", cost = 1.5, colour = 138},
                    {name = "Or", cost = 1.5, colour = 99},
                    {name = "Bronze", cost = 1.5, colour = 90},
                    {name = "Jaune", cost = 1.5, colour = 88},
                    {name = "Jaune de course", cost = 1.5, colour = 89},
                    {name = "Jaune rosé", cost = 1.5, colour = 91},
                    {name = "Vert foncé", cost = 1.5, colour = 49},
                    {name = "Vert de course", cost = 1.5, colour = 50},
                    {name = "Vert océan", cost = 1.5, colour = 51},
                    {name = "Vert olive", cost = 1.5, colour = 52},
                    {name = "Vert clair", cost = 1.5, colour = 53},
                    {name = "Vert petrol", cost = 1.5, colour = 54},
                    {name = "Vert lime", cost = 1.5, colour = 92},
                    {name = "Bleu de minuit", cost = 1.5, colour = 141},
                    {name = "Bleu galaxy", cost = 1.5, colour = 61},
                    {name = "Bleu foncé", cost = 1.5, colour = 62},
                    {name = "Bleu saxon", cost = 1.5, colour = 63},
                    {name = "Bleu", cost = 1.5, colour = 64},
                    {name = "Bleu marine", cost = 1.5, colour = 65},
                    {name = "Bleu harbor", cost = 1.5, colour = 66},
                    {name = "Bleu diamand", cost = 1.5, colour = 67},
                    {name = "Bleu surf", cost = 1.5, colour = 68},
                    {name = "Bleu nautique", cost = 1.5, colour = 69},
                    {name = "Bleu de course", cost = 1.5, colour = 73},
                    {name = "Bleu ultra", cost = 1.5, colour = 70},
                    {name = "Bleu clair", cost = 1.5, colour = 74},
                    {name = "Marron chocolat", cost = 1.5, colour = 96},
                    {name = "Marron buffle", cost = 1.5, colour = 101},
                    {name = "Marron classique", cost = 1.5, colour = 95},
                    {name = "Marron feltzer", cost = 1.5, colour = 94},
                    {name = "Marron érable", cost = 1.5, colour = 97},
                    {name = "Marron être", cost = 1.5, colour = 103},
                    {name = "Marron terre", cost = 1.5, colour = 104},
                    {name = "Marron selle", cost = 1.5, colour = 98},
                    {name = "Marron élan", cost = 1.5, colour = 100},
                    {name = "Marron hêtre", cost = 1.5, colour = 102},
                    {name = "Marron paille", cost = 1.5, colour = 99},
                    {name = "Marron sablé", cost = 1.5, colour = 105},
                    {name = "Marron blanchi", cost = 1.5, colour = 106},
                    {name = "Violet schafter", cost = 1.5, colour = 71},
                    {name = "Violet spinnaker", cost = 1.5, colour = 72},
                    {name = "Violet de minuit", cost = 1.5, colour = 142},
                    {name = "Violet clair", cost = 1.5, colour = 145},
                    {name = "Crème", cost = 1.5, colour = 107},
                    {name = "Blanc glacial", cost = 1.5, colour = 111},
                    {name = "Blanc gelé", cost = 1.5, colour = 112}
                },
                ["Métalique"] = {
                    {name = "noir", cost = 3, colour = 0},
                    {name = "Carbon noir", cost = 3, colour = 147},
                    {name = "Hraphite", cost = 3, colour = 1},
                    {name = "Anhracite noir", cost = 3, colour = 11},
                    {name = "noir acier", cost = 3, colour = 2},
                    {name = "foncé acier", cost = 3, colour = 3},
                    {name = "argent", cost = 3, colour = 4},
                    {name = "Bleuâtre argent", cost = 3, colour = 5},
                    {name = "Roulé acier", cost = 3, colour = 6},
                    {name = "Ombré argent", cost = 3, colour = 7},
                    {name = "Pierre argent", cost = 3, colour = 8},
                    {name = "Nuit argent", cost = 3, colour = 9},
                    {name = "Fonte argent", cost = 3, colour = 10},
                    {name = "rouge", cost = 3, colour = 27},
                    {name = "Torino rouge", cost = 3, colour = 28},
                    {name = "Formula rouge", cost = 3, colour = 29},
                    {name = "Lave rouge", cost = 3, colour = 150},
                    {name = "Flamber rouge", cost = 3, colour = 30},
                    {name = "Grace rouge", cost = 3, colour = 31},
                    {name = "Garnet rouge", cost = 3, colour = 32},
                    {name = "levé du jour rouge", cost = 3, colour = 33},
                    {name = "Cabernet rouge", cost = 3, colour = 34},
                    {name = "Vin rouge", cost = 3, colour = 143},
                    {name = "bonbon rouge", cost = 3, colour = 35},
                    {name = "Chaud rose", cost = 3, colour = 135},
                    {name = "Pfsiter rose", cost = 3, colour = 137},
                    {name = "Saumon rose", cost = 3, colour = 136},
                    {name = "levé du jour Orange", cost = 3, colour = 36},
                    {name = "Orange", cost = 3, colour = 38},
                    {name = "Clair Orange", cost = 3, colour = 138},
                    {name = "or", cost = 3, colour = 99},
                    {name = "Bronze", cost = 3, colour = 90},
                    {name = "jaune", cost = 3, colour = 88},
                    {name = "Course jaune", cost = 3, colour = 89},
                    {name = "Rosée jaune", cost = 3, colour = 91},
                    {name = "foncé vert", cost = 3, colour = 49},
                    {name = "Course vert", cost = 3, colour = 50},
                    {name = "Mer vert", cost = 3, colour = 51},
                    {name = "Olive vert", cost = 3, colour = 52},
                    {name = "Clair vert", cost = 3, colour = 53},
                    {name = "Gasoline vert", cost = 3, colour = 54},
                    {name = "Citron vert", cost = 3, colour = 92},
                    {name = "Nuit bleu", cost = 3, colour = 141},
                    {name = "Galaxy bleu", cost = 3, colour = 61},
                    {name = "foncé bleu", cost = 3, colour = 62},
                    {name = "Saxon bleu", cost = 3, colour = 63},
                    {name = "bleu", cost = 3, colour = 64},
                    {name = "Marine bleu", cost = 3, colour = 65},
                    {name = "Port bleu", cost = 3, colour = 66},
                    {name = "Diamand bleu", cost = 3, colour = 67},
                    {name = "Surf bleu", cost = 3, colour = 68},
                    {name = "Nautical bleu", cost = 3, colour = 69},
                    {name = "Course bleu", cost = 3, colour = 73},
                    {name = "Ultra bleu", cost = 3, colour = 70},
                    {name = "clair bleu", cost = 3, colour = 74},
                    {name = "Chocolat marron", cost = 3, colour = 96},
                    {name = "Bison marron", cost = 3, colour = 101},
                    {name = "Creeen marron", cost = 3, colour = 95},
                    {name = "Feltzer marron", cost = 3, colour = 94},
                    {name = "Maple marron", cost = 3, colour = 97},
                    {name = "Bois marron", cost = 3, colour = 103},
                    {name = "Sienna marron", cost = 3, colour = 104},
                    {name = "Selle marron", cost = 3, colour = 98},
                    {name = "Mousse marron", cost = 3, colour = 100},
                    {name = "hêtre marron", cost = 3, colour = 102},
                    {name = "paille marron", cost = 3, colour = 99},
                    {name = "sablé marron", cost = 3, colour = 105},
                    {name = "Blanchie marron", cost = 3, colour = 106},
                    {name = "Schafter violet", cost = 3, colour = 71},
                    {name = "Spinnaker violet", cost = 3, colour = 72},
                    {name = "Nuit violet", cost = 3, colour = 142},
                    {name = "Clair violet", cost = 3, colour = 145},
                    {name = "crème", cost = 3, colour = 107},
                    {name = "glace blanc", cost = 3, colour = 111},
                    {name = "gel blanc", cost = 3, colour = 112}
                },
                ["Mat"] = {
                    {name = "noir", colour = 12, cost = 5},
                    {name = "Gris", colour = 13, cost = 5},
                    {name = "clair Gris", colour = 14, cost = 5},
                    {name = "glace blanc", colour = 131, cost = 5},
                    {name = "bleu", colour = 83, cost = 5},
                    {name = "foncé bleu", colour = 82, cost = 5},
                    {name = "Nuit bleu", colour = 84, cost = 5},
                    {name = "Nuit violet", colour = 149, cost = 5},
                    {name = "Schafter violet", colour = 148, cost = 5},
                    {name = "rouge", colour = 39, cost = 5},
                    {name = "foncé rouge", colour = 40, cost = 5},
                    {name = "Orange", colour = 41, cost = 5},
                    {name = "jaune", colour = 42, cost = 5},
                    {name = "Citron vert", colour = 55, cost = 5},
                    {name = "vert", colour = 128, cost = 5},
                    {name = "gel vert", colour = 151, cost = 5},
                    {name = "feuillage vert", colour = 155, cost = 5},
                    {name = "Olive Darb", colour = 152, cost = 5},
                    {name = "foncé terre", colour = 153, cost = 5},
                    {name = "Desert Bronze", colour = 154, cost = 5}
                },
                ["Métal"] = {
                    {name = "Brossé acier", colour = 117, cost = 6.5},
                    {name = "Brossé noir acier", colour = 118, cost = 6.5},
                    {name = "Brossé Aluminum", colour = 119, cost = 6.5},
                    {name = "Pure or", colour = 158, cost = 6.5},
                    {name = "Brossé or", colour = 159, cost = 6.5}
                }
            },
            ["Couleur secondaires"] = {
                ["Chrome"] = {
                    {name = "Chrome", cost = 2, colour = 120}
                },
                ["Classique"] = {
                    {name = "noir", cost = 1.5, colour = 0},
                    {name = "Carbon noir", cost = 1.5, colour = 147},
                    {name = "Hraphite", cost = 1.5, colour = 1},
                    {name = "Anhracite noir", cost = 1.5, colour = 11},
                    {name = "noir acier", cost = 1.5, colour = 2},
                    {name = "foncé acier", cost = 1.5, colour = 3},
                    {name = "argent", cost = 1.5, colour = 4},
                    {name = "Bleuâtre argent", cost = 1.5, colour = 5},
                    {name = "Roulée acier", cost = 1.5, colour = 6},
                    {name = "Ombré argent", cost = 1.5, colour = 7},
                    {name = "Pierre argent", cost = 1.5, colour = 8},
                    {name = "Nuit argent", cost = 1.5, colour = 9},
                    {name = "Fonte argent", cost = 1.5, colour = 10},
                    {name = "rouge", cost = 1.5, colour = 27},
                    {name = "Torino rouge", cost = 1.5, colour = 28},
                    {name = "Formula rouge", cost = 1.5, colour = 29},
                    {name = "Lave rouge", cost = 1.5, colour = 150},
                    {name = "Flamber rouge", cost = 1.5, colour = 30},
                    {name = "Grace rouge", cost = 1.5, colour = 31},
                    {name = "Garnet rouge", cost = 1.5, colour = 32},
                    {name = "levé du jour rouge", cost = 1.5, colour = 33},
                    {name = "Cabernet rouge", cost = 1.5, colour = 34},
                    {name = "Vin rouge", cost = 1.5, colour = 143},
                    {name = "bonbon rouge", cost = 1.5, colour = 35},
                    {name = "chaud rose", cost = 1.5, colour = 135},
                    {name = "Pfsiter rose", cost = 1.5, colour = 137},
                    {name = "saumon rose", cost = 1.5, colour = 136},
                    {name = "levé du jour Orange", cost = 1.5, colour = 36},
                    {name = "Orange", cost = 1.5, colour = 38},
                    {name = "Clair Orange", cost = 1.5, colour = 138},
                    {name = "or", cost = 1.5, colour = 99},
                    {name = "Bronze", cost = 1.5, colour = 90},
                    {name = "jaune", cost = 1.5, colour = 88},
                    {name = "Course jaune", cost = 1.5, colour = 89},
                    {name = "Rosée jaune", cost = 1.5, colour = 91},
                    {name = "foncé vert", cost = 1.5, colour = 49},
                    {name = "Course vert", cost = 1.5, colour = 50},
                    {name = "Mer vert", cost = 1.5, colour = 51},
                    {name = "Olive vert", cost = 1.5, colour = 52},
                    {name = "Clair vert", cost = 1.5, colour = 53},
                    {name = "Gasoline vert", cost = 1.5, colour = 54},
                    {name = "Citron vert", cost = 1.5, colour = 92},
                    {name = "Nuit bleu", cost = 1.5, colour = 141},
                    {name = "Galaxy bleu", cost = 1.5, colour = 61},
                    {name = "foncé bleu", cost = 1.5, colour = 62},
                    {name = "Saxon bleu", cost = 1.5, colour = 63},
                    {name = "bleu", cost = 1.5, colour = 64},
                    {name = "Marine bleu", cost = 1.5, colour = 65},
                    {name = "Port bleu", cost = 1.5, colour = 66},
                    {name = "Diamand bleu", cost = 1.5, colour = 67},
                    {name = "Surf bleu", cost = 1.5, colour = 68},
                    {name = "Nautical bleu", cost = 1.5, colour = 69},
                    {name = "Course bleu", cost = 1.5, colour = 73},
                    {name = "Ultra bleu", cost = 1.5, colour = 70},
                    {name = "clair bleu", cost = 1.5, colour = 74},
                    {name = "Chocolat marron", cost = 1.5, colour = 96},
                    {name = "Bison marron", cost = 1.5, colour = 101},
                    {name = "Creeen marron", cost = 1.5, colour = 95},
                    {name = "Feltzer marron", cost = 1.5, colour = 94},
                    {name = "Maple marron", cost = 1.5, colour = 97},
                    {name = "Bois marron", cost = 1.5, colour = 103},
                    {name = "Sienna marron", cost = 1.5, colour = 104},
                    {name = "Selle marron", cost = 1.5, colour = 98},
                    {name = "Mousse marron", cost = 1.5, colour = 100},
                    {name = "hêtre marron", cost = 1.5, colour = 102},
                    {name = "Paille marron", cost = 1.5, colour = 99},
                    {name = "sablé marron", cost = 1.5, colour = 105},
                    {name = "Blanchie marron", cost = 1.5, colour = 106},
                    {name = "Schafter violet", cost = 1.5, colour = 71},
                    {name = "Spinnaker violet", cost = 1.5, colour = 72},
                    {name = "Nuit violet", cost = 1.5, colour = 142},
                    {name = "Clair violet", cost = 1.5, colour = 145},
                    {name = "crème", cost = 1.5, colour = 107},
                    {name = "glace blanc", cost = 1.5, colour = 111},
                    {name = "gel blanc", cost = 1.5, colour = 112}
                },
                ["Metallique"] = {
                    {name = "noir", cost = 3, colour = 0},
                    {name = "Carbon noir", cost = 3, colour = 147},
                    {name = "Hraphite", cost = 3, colour = 1},
                    {name = "Anhracite noir", cost = 3, colour = 11},
                    {name = "noir acier", cost = 3, colour = 2},
                    {name = "foncé acier", cost = 3, colour = 3},
                    {name = "argent", cost = 3, colour = 4},
                    {name = "Bleuâtre argent", cost = 3, colour = 5},
                    {name = "Laminé acier", cost = 3, colour = 6},
                    {name = "Ombré argent", cost = 3, colour = 7},
                    {name = "Pierre argent", cost = 3, colour = 8},
                    {name = "nuit argent", cost = 3, colour = 9},
                    {name = "Fonte argent", cost = 3, colour = 10},
                    {name = "rouge", cost = 3, colour = 27},
                    {name = "Torino rouge", cost = 3, colour = 28},
                    {name = "Formula rouge", cost = 3, colour = 29},
                    {name = "Lave rouge", cost = 3, colour = 150},
                    {name = "Flamber rouge", cost = 3, colour = 30},
                    {name = "Grenat rouge", cost = 3, colour = 31},
                    {name = "Grenat rouge", cost = 3, colour = 32},
                    {name = "Levé du jour rouge", cost = 3, colour = 33},
                    {name = "Cabernet rouge", cost = 3, colour = 34},
                    {name = "Vin rouge", cost = 3, colour = 143},
                    {name = "bonbon rouge", cost = 3, colour = 35},
                    {name = "chaud rose", cost = 3, colour = 135},
                    {name = "Pfsiter rose", cost = 3, colour = 137},
                    {name = "Saumon rose", cost = 3, colour = 136},
                    {name = "Levé du jour Orange", cost = 3, colour = 36},
                    {name = "Orange", cost = 3, colour = 38},
                    {name = "clair Orange", cost = 3, colour = 138},
                    {name = "or", cost = 3, colour = 99},
                    {name = "Bronze", cost = 3, colour = 90},
                    {name = "jaune", cost = 3, colour = 88},
                    {name = "Course jaune", cost = 3, colour = 89},
                    {name = "Rosée jaune", cost = 3, colour = 91},
                    {name = "foncé vert", cost = 3, colour = 49},
                    {name = "Course vert", cost = 3, colour = 50},
                    {name = "Mer vert", cost = 3, colour = 51},
                    {name = "Olive vert", cost = 3, colour = 52},
                    {name = "Clair vert", cost = 3, colour = 53},
                    {name = "Gasoline vert", cost = 3, colour = 54},
                    {name = "Citron vert", cost = 3, colour = 92},
                    {name = "Nuit bleu", cost = 3, colour = 141},
                    {name = "Galaxy bleu", cost = 3, colour = 61},
                    {name = "foncé bleu", cost = 3, colour = 62},
                    {name = "Saxon bleu", cost = 3, colour = 63},
                    {name = "bleu", cost = 3, colour = 64},
                    {name = "Marine bleu", cost = 3, colour = 65},
                    {name = "port bleu", cost = 3, colour = 66},
                    {name = "Diamand bleu", cost = 3, colour = 67},
                    {name = "Surf bleu", cost = 3, colour = 68},
                    {name = "Nautical bleu", cost = 3, colour = 69},
                    {name = "Course bleu", cost = 3, colour = 73},
                    {name = "Ultra bleu", cost = 3, colour = 70},
                    {name = "clair bleu", cost = 3, colour = 74},
                    {name = "Chocolat marron", cost = 3, colour = 96},
                    {name = "Bison marron", cost = 3, colour = 101},
                    {name = "Creeen marron", cost = 3, colour = 95},
                    {name = "Feltzer marron", cost = 3, colour = 94},
                    {name = "Maple marron", cost = 3, colour = 97},
                    {name = "Bois marron", cost = 3, colour = 103},
                    {name = "Selle marron", cost = 3, colour = 104},
                    {name = "Selle marron", cost = 3, colour = 98},
                    {name = "mousse marron", cost = 3, colour = 100},
                    {name = "Hêtre marron", cost = 3, colour = 102},
                    {name = "paille marron", cost = 3, colour = 99},
                    {name = "sablé marron", cost = 3, colour = 105},
                    {name = "Blanchie marron", cost = 3, colour = 106},
                    {name = "Schafter violet", cost = 3, colour = 71},
                    {name = "Spinnaker violet", cost = 3, colour = 72},
                    {name = "Nuit violet", cost = 3, colour = 142},
                    {name = "Clair violet", cost = 3, colour = 145},
                    {name = "Crème", cost = 3, colour = 107},
                    {name = "Glace blanc", cost = 3, colour = 111},
                    {name = "Gel blanc", cost = 3, colour = 112}
                },
                ["Mat"] = {
                    {name = "Noir", colour = 12, cost = 5},
                    {name = "Gris", colour = 13, cost = 5},
                    {name = "clair gris", colour = 14, cost = 5},
                    {name = "glace blanc", colour = 131, cost = 5},
                    {name = "bleu", colour = 83, cost = 5},
                    {name = "foncé bleu", colour = 82, cost = 5},
                    {name = "nuit bleu", colour = 84, cost = 5},
                    {name = "nuit violet", colour = 149, cost = 5},
                    {name = "Schafter violet", colour = 148, cost = 5},
                    {name = "rouge", colour = 39, cost = 5},
                    {name = "foncé rouge", colour = 40, cost = 5},
                    {name = "Orange", colour = 41, cost = 5},
                    {name = "jaune", colour = 42, cost = 5},
                    {name = "citron vert", colour = 55, cost = 5},
                    {name = "vert", colour = 128, cost = 5},
                    {name = "gel vert", colour = 151, cost = 5},
                    {name = "feuillage vert", colour = 155, cost = 5},
                    {name = "Olive Darb", colour = 152, cost = 5},
                    {name = "foncé terre", colour = 153, cost = 5},
                    {name = "Desert Bronze", colour = 154, cost = 5}
                },
                ["Métal"] = {
                    {name = "Brossé acier", colour = 117, cost = 6.5},
                    {name = "Brossé noir acier", colour = 118, cost = 6.5},
                    {name = "Brossé Aluminum", colour = 119, cost = 6.5},
                    {name = "Pure or", colour = 158, cost = 6.5},
                    {name = "Brossé or", colour = 159, cost = 6.5}
                }
            },
            ["Nacrage"] = {
                ["Chrome"] = {
                    {name = "Chrome", cost = 2, colour = 120}
                },
                ["Classique"] = {
                    {name = "noir", cost = 1.5, colour = 0},
                    {name = "Carbon noir", cost = 1.5, colour = 147},
                    {name = "Hraphite", cost = 1.5, colour = 1},
                    {name = "Anhracite noir", cost = 1.5, colour = 11},
                    {name = "noir acier", cost = 1.5, colour = 2},
                    {name = "foncé acier", cost = 1.5, colour = 3},
                    {name = "argent", cost = 1.5, colour = 4},
                    {name = "Bleuâtre argent", cost = 1.5, colour = 5},
                    {name = "Roulé acier", cost = 1.5, colour = 6},
                    {name = "sombre argent", cost = 1.5, colour = 7},
                    {name = "Pierre argent", cost = 1.5, colour = 8},
                    {name = "nuit argent", cost = 1.5, colour = 9},
                    {name = "Fonte argent", cost = 1.5, colour = 10},
                    {name = "rouge", cost = 1.5, colour = 27},
                    {name = "Torino rouge", cost = 1.5, colour = 28},
                    {name = "Formula rouge", cost = 1.5, colour = 29},
                    {name = "Lave rouge", cost = 1.5, colour = 150},
                    {name = "Flamber rouge", cost = 1.5, colour = 30},
                    {name = "Grace rouge", cost = 1.5, colour = 31},
                    {name = "Garnet rouge", cost = 1.5, colour = 32},
                    {name = "levé du jour rouge", cost = 1.5, colour = 33},
                    {name = "Cabernet rouge", cost = 1.5, colour = 34},
                    {name = "vin rouge", cost = 1.5, colour = 143},
                    {name = "bonbon rouge", cost = 1.5, colour = 35},
                    {name = "chaud rose", cost = 1.5, colour = 135},
                    {name = "Pfsiter rose", cost = 1.5, colour = 137},
                    {name = "Saumon rose", cost = 1.5, colour = 136},
                    {name = "Levé du jour Orange", cost = 1.5, colour = 36},
                    {name = "Orange", cost = 1.5, colour = 38},
                    {name = "Clair Orange", cost = 1.5, colour = 138},
                    {name = "or", cost = 1.5, colour = 99},
                    {name = "Bronze", cost = 1.5, colour = 90},
                    {name = "jaune", cost = 1.5, colour = 88},
                    {name = "course jaune", cost = 1.5, colour = 89},
                    {name = "rosé jaune", cost = 1.5, colour = 91},
                    {name = "foncé vert", cost = 1.5, colour = 49},
                    {name = "course vert", cost = 1.5, colour = 50},
                    {name = "Mer vert", cost = 1.5, colour = 51},
                    {name = "Olive vert", cost = 1.5, colour = 52},
                    {name = "Clair vert", cost = 1.5, colour = 53},
                    {name = "Gasoline vert", cost = 1.5, colour = 54},
                    {name = "Citron vert", cost = 1.5, colour = 92},
                    {name = "nuit bleu", cost = 1.5, colour = 141},
                    {name = "Galaxy bleu", cost = 1.5, colour = 61},
                    {name = "foncé bleu", cost = 1.5, colour = 62},
                    {name = "Saxon bleu", cost = 1.5, colour = 63},
                    {name = "bleu", cost = 1.5, colour = 64},
                    {name = "Marine bleu", cost = 1.5, colour = 65},
                    {name = "Portière bleu", cost = 1.5, colour = 66},
                    {name = "Diamand bleu", cost = 1.5, colour = 67},
                    {name = "Surf bleu", cost = 1.5, colour = 68},
                    {name = "Nautical bleu", cost = 1.5, colour = 69},
                    {name = "Course bleu", cost = 1.5, colour = 73},
                    {name = "Ultra bleu", cost = 1.5, colour = 70},
                    {name = "clair bleu", cost = 1.5, colour = 74},
                    {name = "Chocolat marron", cost = 1.5, colour = 96},
                    {name = "Bison marron", cost = 1.5, colour = 101},
                    {name = "Creeen marron", cost = 1.5, colour = 95},
                    {name = "Feltzer marron", cost = 1.5, colour = 94},
                    {name = "Maple marron", cost = 1.5, colour = 97},
                    {name = "Bois marron", cost = 1.5, colour = 103},
                    {name = "Sienna marron", cost = 1.5, colour = 104},
                    {name = "Selle marron", cost = 1.5, colour = 98},
                    {name = "mousse marron", cost = 1.5, colour = 100},
                    {name = "Hêtre marron", cost = 1.5, colour = 102},
                    {name = "paille marron", cost = 1.5, colour = 99},
                    {name = "sablé marron", cost = 1.5, colour = 105},
                    {name = "blanchi marron", cost = 1.5, colour = 106},
                    {name = "Schafter violet", cost = 1.5, colour = 71},
                    {name = "Spinnaker violet", cost = 1.5, colour = 72},
                    {name = "nuit violet", cost = 1.5, colour = 142},
                    {name = "clair violet", cost = 1.5, colour = 145},
                    {name = "crème", cost = 1.5, colour = 107},
                    {name = "glace blanc", cost = 1.5, colour = 111},
                    {name = "gel blanc", cost = 1.5, colour = 112}
                },
                ["Metallique"] = {
                    {name = "noir", cost = 3, colour = 0},
                    {name = "Carbon noir", cost = 3, colour = 147},
                    {name = "Hraphite", cost = 3, colour = 1},
                    {name = "Anhracite noir", cost = 3, colour = 11},
                    {name = "noir acier", cost = 3, colour = 2},
                    {name = "foncé acier", cost = 3, colour = 3},
                    {name = "argent", cost = 3, colour = 4},
                    {name = "Bleuâtre argent", cost = 3, colour = 5},
                    {name = "Roulé acier", cost = 3, colour = 6},
                    {name = "sombre argent", cost = 3, colour = 7},
                    {name = "Pierre argent", cost = 3, colour = 8},
                    {name = "Nuit argent", cost = 3, colour = 9},
                    {name = "Fonte argent", cost = 3, colour = 10},
                    {name = "rouge", cost = 3, colour = 27},
                    {name = "Torino rouge", cost = 3, colour = 28},
                    {name = "Formula rouge", cost = 3, colour = 29},
                    {name = "Lave rouge", cost = 3, colour = 150},
                    {name = "Flamber rouge", cost = 3, colour = 30},
                    {name = "Grace rouge", cost = 3, colour = 31},
                    {name = "Garnet rouge", cost = 3, colour = 32},
                    {name = "lévé du jour rouge", cost = 3, colour = 33},
                    {name = "Cabernet rouge", cost = 3, colour = 34},
                    {name = "Vin rouge", cost = 3, colour = 143},
                    {name = "bonbon rouge", cost = 3, colour = 35},
                    {name = "chaud rose", cost = 3, colour = 135},
                    {name = "Pfsiter rose", cost = 3, colour = 137},
                    {name = "Saumon rose", cost = 3, colour = 136},
                    {name = "levé du jour Orange", cost = 3, colour = 36},
                    {name = "Orange", cost = 3, colour = 38},
                    {name = "Clair Orange", cost = 3, colour = 138},
                    {name = "or", cost = 8, colour = 99},
                    {name = "Bronze", cost = 3, colour = 90},
                    {name = "jaune", cost = 3, colour = 88},
                    {name = "Course jaune", cost = 3, colour = 89},
                    {name = "rosé jaune", cost = 3, colour = 91},
                    {name = "foncé vert", cost = 3, colour = 49},
                    {name = "Course vert", cost = 3, colour = 50},
                    {name = "Mer vert", cost = 3, colour = 51},
                    {name = "Olive vert", cost = 3, colour = 52},
                    {name = "Clair vert", cost = 3, colour = 53},
                    {name = "Gasoline vert", cost = 3, colour = 54},
                    {name = "Citron vert", cost = 3, colour = 92},
                    {name = "Nuit bleu", cost = 3, colour = 141},
                    {name = "Galaxy bleu", cost = 3, colour = 61},
                    {name = "foncé bleu", cost = 3, colour = 62},
                    {name = "Saxon bleu", cost = 3, colour = 63},
                    {name = "bleu", cost = 3, colour = 64},
                    {name = "Marine bleu", cost = 3, colour = 65},
                    {name = "Port bleu", cost = 3, colour = 66},
                    {name = "Diamand bleu", cost = 3, colour = 67},
                    {name = "Surf bleu", cost = 3, colour = 68},
                    {name = "Nautical bleu", cost = 3, colour = 69},
                    {name = "Course bleu", cost = 3, colour = 73},
                    {name = "Ultra bleu", cost = 3, colour = 70},
                    {name = "clair bleu", cost = 3, colour = 74},
                    {name = "Chocolat marron", cost = 3, colour = 96},
                    {name = "Bison marron", cost = 3, colour = 101},
                    {name = "Creeen marron", cost = 3, colour = 95},
                    {name = "Feltzer marron", cost = 3, colour = 94},
                    {name = "Maple marron", cost = 3, colour = 97},
                    {name = "Bois marron", cost = 3, colour = 103},
                    {name = "Sienna marron", cost = 3, colour = 104},
                    {name = "Selle marron", cost = 3, colour = 98},
                    {name = "mousse marron", cost = 3, colour = 100},
                    {name = "hêtre marron", cost = 3, colour = 102},
                    {name = "paille marron", cost = 3, colour = 99},
                    {name = "sablé marron", cost = 3, colour = 105},
                    {name = "blanchi marron", cost = 3, colour = 106},
                    {name = "Schafter violet", cost = 3, colour = 71},
                    {name = "Spinnaker violet", cost = 3, colour = 72},
                    {name = "nuit violet", cost = 3, colour = 142},
                    {name = "clair violet", cost = 3, colour = 145},
                    {name = "Crème", cost = 3, colour = 107},
                    {name = "Glace blanc", cost = 3, colour = 111},
                    {name = "Gel blanc", cost = 3, colour = 112}
                },
                ["Mat"] = {
                    {name = "Noir", colour = 12, cost = 5},
                    {name = "Gris", colour = 13, cost = 5},
                    {name = "clair gris", colour = 14, cost = 5},
                    {name = "glace blanc", colour = 131, cost = 5},
                    {name = "bleu", colour = 83, cost = 5},
                    {name = "foncé bleu", colour = 82, cost = 5},
                    {name = "Nuit bleu", colour = 84, cost = 5},
                    {name = "Nuit violet", colour = 149, cost = 5},
                    {name = "Schafter violet", colour = 148, cost = 7},
                    {name = "rouge", colour = 39, cost = 5},
                    {name = "foncé rouge", colour = 40, cost = 5},
                    {name = "Orange", colour = 41, cost = 5},
                    {name = "jaune", colour = 42, cost = 5},
                    {name = "Citron vert", colour = 55, cost = 5},
                    {name = "vert", colour = 128, cost = 5},
                    {name = "gel vert", colour = 151, cost = 5},
                    {name = "feuillage vert", colour = 155, cost = 5},
                    {name = "Olive Darb", colour = 152, cost = 5},
                    {name = "foncé terre", colour = 153, cost = 5},
                    {name = "Desert Bronze", colour = 154, cost = 5}
                },
                ["Métal"] = {
                    {name = "Brossé acier", colour = 117, cost = 6.5},
                    {name = "Brossé noir acier", colour = 118, cost = 6.5},
                    {name = "Brossé Aluminum", colour = 119, cost = 6.5},
                    {name = "Pure or", colour = 158, cost = 6.5},
                    {name = "Brossé or", colour = 159, cost = 6.5}
                }
            }
        }
    },
    {
        title = "Turbo",
        data = {
            {name = "None", bool = "false", mt = 18, cost = 0},
            {name = "Turbo Tuning", bool = "true", mt = 18, cost = 18}
        }
    },
    {
        title = "Jantes",
        data = {
            ["Type de jantes"] = {
                ["Sport"] = {
                    {name = "Stock", wtype = false, mt = 23, mod = -1, cost = 7},
                    {name = "Inferno", wtype = false, mt = 23, mod = 0, cost = 7},
                    {name = "Deepfive", wtype = false, mt = 23, mod = 1, cost = 7.5},
                    {name = "Lozspeed", wtype = false, mt = 23, mod = 2, cost = 7.5},
                    {name = "Diamondcut", wtype = false, mt = 23, mod = 3, cost = 8},
                    {name = "Chrono", wtype = false, mt = 23, mod = 4, cost = 8},
                    {name = "Feroccirr", wtype = false, mt = 23, mod = 5, cost = 6.5},
                    {name = "Fiftynine", wtype = false, mt = 23, mod = 6, cost = 6.5},
                    {name = "Mercie", wtype = false, mt = 23, mod = 7, cost = 7},
                    {name = "Syntheticz", wtype = false, mt = 23, mod = 8, cost = 5.5},
                    {name = "Organictyped", wtype = false, mt = 23, mod = 9, cost = 8.5},
                    {name = "Endov1", wtype = false, mt = 23, mod = 10, cost = 6},
                    {name = "Duper7", wtype = false, mt = 23, mod = 11, cost = 7},
                    {name = "Uzer", wtype = false, mt = 23, mod = 12, cost = 8},
                    {name = "Groundride", wtype = false, mt = 23, mod = 13, cost = 6},
                    {name = "Spacer", wtype = false, mt = 23, mod = 14, cost = 8.5},
                    {name = "Venum", wtype = false, mt = 23, mod = 15, cost = 5},
                    {name = "Cosmo", wtype = false, mt = 23, mod = 16, cost = 4},
                    {name = "Dashvip", wtype = false, mt = 23, mod = 17, cost = 6.5},
                    {name = "Icekid", wtype = false, mt = 23, mod = 18, cost = 6.5},
                    {name = "Ruffeld", wtype = false, mt = 23, mod = 19, cost = 6.5},
                    {name = "Wangenmaster", wtype = false, mt = 23, mod = 20, cost = 6.5},
                    {name = "Superfive", wtype = false, mt = 23, mod = 21, cost = 6.5},
                    {name = "Endov2", wtype = false, mt = 23, mod = 22, cost = 6.5},
                    {name = "Slitsix", wtype = false, mt = 23, mod = 23, cost = 6.5}
                },
                ["SUV"] = {
                    {name = "Stock", wtype = 3, mt = 23, mod = -1, cost = 6.5},
                    {name = "Vip", wtype = 3, mt = 23, mod = 0, cost = 6.5},
                    {name = "Benefactor", wtype = 3, mt = 23, mod = 1, cost = 6.5},
                    {name = "Cosmo", wtype = 3, mt = 23, mod = 2, cost = 6.5},
                    {name = "Bippu", wtype = 3, mt = 23, mod = 3, cost = 6.5},
                    {name = "Royalsix", wtype = 3, mt = 23, mod = 4, cost = 6.5},
                    {name = "Fagorme", wtype = 3, mt = 23, mod = 5, cost = 6.5},
                    {name = "Deluxe", wtype = 3, mt = 23, mod = 6, cost = 6.5},
                    {name = "Icedout", wtype = 3, mt = 23, mod = 7, cost = 6.5},
                    {name = "Cognscenti", wtype = 3, mt = 23, mod = 8, cost = 6.5},
                    {name = "Lozspeedten", wtype = 3, mt = 23, mod = 9, cost = 6.5},
                    {name = "Supernova", wtype = 3, mt = 23, mod = 10, cost = 6.5},
                    {name = "Obeyrs", wtype = 3, mt = 23, mod = 11, cost = 6.5},
                    {name = "Lozspeedballer", wtype = 3, mt = 23, mod = 12, cost = 6.5},
                    {name = "Extra vaganzo", wtype = 3, mt = 23, mod = 13, cost = 6.5},
                    {name = "Splitsix", wtype = 3, mt = 23, mod = 14, cost = 6.5},
                    {name = "Empowered", wtype = 3, mt = 23, mod = 15, cost = 6.5},
                    {name = "Sunrise", wtype = 3, mt = 23, mod = 16, cost = 6.5},
                    {name = "Dashvip", wtype = 3, mt = 23, mod = 17, cost = 6.5},
                    {name = "Cutter", wtype = 3, mt = 23, mod = 18, cost = 6.5}
                },
                ["Offroad"] = {
                    {name = "Stock", wtype = 4, mt = 23, mod = -1, cost = 8.5},
                    {name = "Raider", wtype = 4, mt = 23, mod = 0, cost = 8.5},
                    {name = "Mudslinger", mt = 23, mod = 1, cost = 8.5},
                    {name = "Nevis", wtype = 4, mt = 23, mod = 2, cost = 8.5},
                    {name = "Cairngorm", wtype = 4, mt = 23, mod = 3, cost = 8.5},
                    {name = "Amazon", wtype = 4, mt = 23, mod = 4, cost = 8.5},
                    {name = "Challenger", wtype = 4, mt = 23, mod = 5, cost = 8.5},
                    {name = "Dunebasher", wtype = 4, mt = 23, mod = 6, cost = 8.5},
                    {name = "Fivestar", wtype = 4, mt = 23, mod = 7, cost = 8.5},
                    {name = "Rockcrawler", wtype = 4, mt = 23, mod = 8, cost = 8.5},
                    {name = "Milspecsteelie", wtype = 4, mt = 23, mod = 9, cost = 8.5}
                },
                ["Tuner"] = {
                    {name = "Stock", wtype = 5, mt = 23, mod = -1, cost = 6.5},
                    {name = "Cosmo", wtype = 5, mt = 23, mod = 0, cost = 6.5},
                    {name = "Supermesh", wtype = 5, mt = 23, mod = 1, cost = 6.5},
                    {name = "Outsider", wtype = 5, mt = 23, mod = 2, cost = 6.5},
                    {name = "Rollas", wtype = 5, mt = 23, mod = 3, cost = 6.5},
                    {name = "Driffmeister", wtype = 5, mt = 23, mod = 4, cost = 6.5},
                    {name = "Slicer", wtype = 5, mt = 23, mod = 5, cost = 6.5},
                    {name = "Elquatro", wtype = 5, mt = 23, mod = 6, cost = 6.5},
                    {name = "Dubbed", wtype = 5, mt = 23, mod = 7, cost = 6.5},
                    {name = "Fivestar", wtype = 5, mt = 23, mod = 8, cost = 6.5},
                    {name = "Slideways", wtype = 5, mt = 23, mod = 9, cost = 6.5},
                    {name = "Apex", wtype = 5, mt = 23, mod = 10, cost = 6.5},
                    {name = "Stancedeg", wtype = 5, mt = 23, mod = 11, cost = 6.5},
                    {name = "Countersteer", wtype = 5, mt = 23, mod = 12, cost = 6.5},
                    {name = "Endov1", wtype = 5, mt = 23, mod = 13, cost = 6.5},
                    {name = "Endov2dish", wtype = 5, mt = 23, mod = 14, cost = 6.5},
                    {name = "Guppez", wtype = 5, mt = 23, mod = 15, cost = 6.5},
                    {name = "Chokadori", wtype = 5, mt = 23, mod = 16, cost = 6.5},
                    {name = "Chicane", wtype = 5, mt = 23, mod = 17, cost = 6.5},
                    {name = "Saisoku", wtype = 5, mt = 23, mod = 18, cost = 6.5},
                    {name = "Dishedeight", wtype = 5, mt = 23, mod = 19, cost = 6.5},
                    {name = "Fujiwara", wtype = 5, mt = 23, mod = 20, cost = 6.5},
                    {name = "Zokusha", wtype = 5, mt = 23, mod = 21, cost = 6.5},
                    {name = "Battlevill", wtype = 5, mt = 23, mod = 22, cost = 6.5},
                    {name = "Rallymaster", wtype = 5, mt = 23, mod = 23, cost = 6.5}
                },
                ["Haut de gamme"] = {
                    {name = "Stock", wtype = 7, mt = 23, mod = -1, cost = 9.5},
                    {name = "Shadow", wtype = 7, mt = 23, mod = 0, cost = 9.5},
                    {name = "Hyper", wtype = 7, mt = 23, mod = 1, cost = 10},
                    {name = "Blade", wtype = 7, mt = 23, mod = 2, cost = 5},
                    {name = "Diamond", wtype = 7, mt = 23, mod = 3, cost = 3},
                    {name = "Supagee", wtype = 7, mt = 23, mod = 4, cost = 7},
                    {name = "Chromaticz", wtype = 7, mt = 23, mod = 5, cost = 8},
                    {name = "Merciechlip", wtype = 7, mt = 23, mod = 6, cost = 9},
                    {name = "Obeyrs", wtype = 7, mt = 23, mod = 7, cost = 10},
                    {name = "Gtchrome", wtype = 7, mt = 23, mod = 8, cost = 10},
                    {name = "Cheetahr", wtype = 7, mt = 23, mod = 9, cost = 5},
                    {name = "Solar", wtype = 7, mt = 23, mod = 10, cost = 7},
                    {name = "Splitten", wtype = 7, mt = 23, mod = 11, cost = 8},
                    {name = "Dashvip", wtype = 7, mt = 23, mod = 12, cost = 9},
                    {name = "Lozspeedten", wtype = 7, mt = 23, mod = 13, cost = 5},
                    {name = "Carboninferno", wtype = 7, mt = 23, mod = 14, cost = 10},
                    {name = "Carbonshadow", wtype = 7, mt = 23, mod = 15, cost = 14},
                    {name = "Carbonz", wtype = 7, mt = 23, mod = 16, cost = 14},
                    {name = "Carbonsolar", wtype = 7, mt = 23, mod = 17, cost = 14},
                    {name = "Carboncheetahr", wtype = 7, mt = 23, mod = 18, cost = 14},
                    {name = "Carbonsracer", wtype = 7, mt = 23, mod = 19, cost = 14}
                },
                ["Lowrider"] = {
                    {name = "Stock", wtype = 2, mt = 23, mod = -1, cost = 6.5},
                    {name = "Flare", wtype = 2, mt = 23, mod = 0, cost = 6.5},
                    {name = "Wired", wtype = 2, mt = 23, mod = 1, cost = 6.5},
                    {name = "Triplegolds", wtype = 2, mt = 23, mod = 2, cost = 6.5},
                    {name = "Bigworm", wtype = 2, mt = 23, mod = 3, cost = 6.5},
                    {name = "Sevenfives", wtype = 2, mt = 23, mod = 4, cost = 6.5},
                    {name = "Splitsix", wtype = 2, mt = 23, mod = 5, cost = 6.5},
                    {name = "Freshmesh", wtype = 2, mt = 23, mod = 6, cost = 6.5},
                    {name = "Leadsled", wtype = 2, mt = 23, mod = 7, cost = 6.5},
                    {name = "Turbine", wtype = 2, mt = 23, mod = 8, cost = 6.5},
                    {name = "Superfin", wtype = 2, mt = 23, mod = 9, cost = 6.5},
                    {name = "Classicrod", wtype = 2, mt = 23, mod = 10, cost = 6.5},
                    {name = "Dollar", wtype = 2, mt = 23, mod = 11, cost = 6.5},
                    {name = "Dukes", wtype = 2, mt = 23, mod = 12, cost = 6.5},
                    {name = "Lowfive", wtype = 2, mt = 23, mod = 13, cost = 6.5},
                    {name = "Gooch", wtype = 2, mt = 23, mod = 14, cost = 6.5}
                },
                ["Muscle"] = {
                    {name = "Stock", wtype = 1, mt = 23, mod = -1, cost = 6.5},
                    {name = "Classicfive", wtype = 1, mt = 23, mod = 0, cost = 6.5},
                    {name = "Dukes", wtype = 1, mt = 23, mod = 1, cost = 6.5},
                    {name = "Musclefreak", wtype = 1, mt = 23, mod = 2, cost = 6.5},
                    {name = "Kracka", wtype = 1, mt = 23, mod = 3, cost = 6.5},
                    {name = "Azrea", wtype = 1, mt = 23, mod = 4, cost = 6.5},
                    {name = "Mecha", wtype = 1, mt = 23, mod = 5, cost = 6.5},
                    {name = "Blacktop", wtype = 1, mt = 23, mod = 6, cost = 6.5},
                    {name = "Dragspl", wtype = 1, mt = 23, mod = 7, cost = 6.5},
                    {name = "Revolver", wtype = 1, mt = 23, mod = 8, cost = 6.5},
                    {name = "Classicrod", wtype = 1, mt = 23, mod = 9, cost = 6.5},
                    {name = "Spooner", wtype = 1, mt = 23, mod = 10, cost = 6.5},
                    {name = "Fivestar", wtype = 1, mt = 23, mod = 11, cost = 6.5},
                    {name = "Oldschool", wtype = 1, mt = 23, mod = 12, cost = 6.5},
                    {name = "Eljefe", wtype = 1, mt = 23, mod = 13, cost = 6.5},
                    {name = "Dodman", wtype = 1, mt = 23, mod = 14, cost = 6.5},
                    {name = "Sixgun", wtype = 1, mt = 23, mod = 15, cost = 6.5},
                    {name = "Mercenary", wtype = 1, mt = 23, mod = 16, cost = 6.5}
                }
            },
            ["Motos"] = {
                ["Roue avant"] = {
                    {name = "Stock", wtype = 6, mt = 23, mod = -1, cost = 3},
                    {name = "Speedway", wtype = 6, mt = 23, mod = 0, cost = 3},
                    {name = "Streetspecial", wtype = 6, mt = 23, mod = 1, cost = 3},
                    {name = "Racer", wtype = 6, mt = 23, mod = 2, cost = 3},
                    {name = "Trackstar", wtype = 6, mt = 23, mod = 3, cost = 3},
                    {name = "Overlord", wtype = 6, mt = 23, mod = 4, cost = 3},
                    {name = "Trident", wtype = 6, mt = 23, mod = 5, cost = 3},
                    {name = "Triplethreat", wtype = 6, mt = 23, mod = 6, cost = 3},
                    {name = "Stilleto", wtype = 6, mt = 23, mod = 7, cost = 3},
                    {name = "Wires", wtype = 6, mt = 23, mod = 8, cost = 3},
                    {name = "Bobber", wtype = 6, mt = 23, mod = 9, cost = 3},
                    {name = "Solidus", wtype = 6, mt = 23, mod = 10, cost = 3},
                    {name = "Iceshield", wtype = 6, mt = 23, mod = 11, cost = 3},
                    {name = "Loops", wtype = 6, mt = 23, mod = 12, cost = 3}
                },
                ["Roue arrière"] = {
                    {name = "Stock", wtype = 6, mt = 24, mod = -1, cost = 3},
                    {name = "Speedway", wtype = 6, mt = 24, mod = 0, cost = 3},
                    {name = "Streetspecial", wtype = 6, mt = 24, mod = 1, cost = 3},
                    {name = "Racer", wtype = 6, mt = 24, mod = 2, cost = 3},
                    {name = "Trackstar", wtype = 6, mt = 24, mod = 3, cost = 3},
                    {name = "Overlord", wtype = 6, mt = 24, mod = 4, cost = 3},
                    {name = "Trident", wtype = 6, mt = 24, mod = 5, cost = 3},
                    {name = "Triplethreat", wtype = 6, mt = 24, mod = 6, cost = 3},
                    {name = "Stilleto", wtype = 6, mt = 24, mod = 7, cost = 3},
                    {name = "Wires", wtype = 6, mt = 24, mod = 8, cost = 3},
                    {name = "Bobber", wtype = 6, mt = 24, mod = 9, cost = 3},
                    {name = "Solidus", wtype = 6, mt = 24, mod = 10, cost = 3},
                    {name = "Iceshield", wtype = 6, mt = 24, mod = 11, cost = 3},
                    {name = "Loops", wtype = 6, mt = 24, mod = 12, cost = 3}
                }
            },
            ["Couleur des jantes"] = {
                {name = "Noir", cost = 1.5, colour = 0},
                {name = "Carbon Noir", cost = 1.5, colour = 147},
                {name = "Graphite", cost = 1.5, colour = 1},
                {name = "Anhracite Noir", cost = 1.5, colour = 11},
                {name = "Noir Acier", cost = 1.5, colour = 2},
                {name = "Sombre Acier", cost = 1.5, colour = 3},
                {name = "Argent", cost = 1.5, colour = 4},
                {name = "Bleuâtre Silver", cost = 1.5, colour = 5},
                {name = "Roulé Acier", cost = 1.5, colour = 6},
                {name = "Ombré Silver", cost = 1.5, colour = 7},
                {name = "Pierre Silver", cost = 1.5, colour = 8},
                {name = "Nuit Silver", cost = 1.5, colour = 9},
                {name = "Fonte Silver", cost = 1.5, colour = 10},
                {name = "Rouge", cost = 1.5, colour = 27},
                {name = "Torino Rouge", cost = 1.5, colour = 28},
                {name = "Formula Rouge", cost = 1.5, colour = 29},
                {name = "Lave Rouge", cost = 1.5, colour = 150},
                {name = "Flamber Rouge", cost = 1.5, colour = 30},
                {name = "Grace Rouge", cost = 1.5, colour = 31},
                {name = "Garnet Rouge", cost = 1.5, colour = 32},
                {name = "Levé du jour Rouge", cost = 1.5, colour = 33},
                {name = "Cabernet Rouge", cost = 1.5, colour = 34},
                {name = "Vin Rouge", cost = 1.5, colour = 143},
                {name = "bonbon Rouge", cost = 1.5, colour = 35},
                {name = "Chaud Rose", cost = 1.5, colour = 135},
                {name = "Pfsiter Rose", cost = 1.5, colour = 137},
                {name = "Saumon Rose", cost = 1.5, colour = 136},
                {name = "levé du jour Orange", cost = 1.5, colour = 36},
                {name = "Orange", cost = 1.5, colour = 38},
                {name = "Clair Orange", cost = 1.5, colour = 138},
                {name = "Or", cost = 1.5, colour = 99},
                {name = "Bronze", cost = 1.5, colour = 90},
                {name = "Jaune", cost = 1.5, colour = 88},
                {name = "Course Jaune", cost = 1.5, colour = 89},
                {name = "Rosée Jaune", cost = 1.5, colour = 91},
                {name = "Sombre Vert", cost = 1.5, colour = 49},
                {name = "Course Vert", cost = 1.5, colour = 50},
                {name = "Mer Vert", cost = 1.5, colour = 51},
                {name = "Olive Vert", cost = 1.5, colour = 52},
                {name = "Clair Vert", cost = 1.5, colour = 53},
                {name = "Gasoline Vert", cost = 1.5, colour = 54},
                {name = "Citron Vert", cost = 1.5, colour = 92},
                {name = "Nuit Bleu", cost = 1.5, colour = 141},
                {name = "Galaxy Bleu", cost = 1.5, colour = 61},
                {name = "Sombre Bleu", cost = 1.5, colour = 62},
                {name = "Saxon Bleu", cost = 1.5, colour = 63},
                {name = "Bleu", cost = 1.5, colour = 64},
                {name = "Marine Bleu", cost = 1.5, colour = 65},
                {name = "Port Bleu", cost = 1.5, colour = 66},
                {name = "Diamand Bleu", cost = 1.5, colour = 67},
                {name = "Surf Bleu", cost = 1.5, colour = 68},
                {name = "Nautical Bleu", cost = 1.5, colour = 69},
                {name = "Course Bleu", cost = 1.5, colour = 73},
                {name = "Ultra Bleu", cost = 1.5, colour = 70},
                {name = "Léger Bleu", cost = 1.5, colour = 74},
                {name = "Chocolat Brun", cost = 1.5, colour = 96},
                {name = "Bison Brun", cost = 1.5, colour = 101},
                {name = "Creeen Brun", cost = 1.5, colour = 95},
                {name = "Feltzer Brun", cost = 1.5, colour = 94},
                {name = "Maple Brun", cost = 1.5, colour = 97},
                {name = "Bois Brun", cost = 1.5, colour = 103},
                {name = "Sienna Brun", cost = 1.5, colour = 104},
                {name = "Selle Brun", cost = 1.5, colour = 98},
                {name = "mousse Brun", cost = 1.5, colour = 100},
                {name = "hêtre Brun", cost = 1.5, colour = 102},
                {name = "paille Brun", cost = 1.5, colour = 99},
                {name = "sablé Brun", cost = 1.5, colour = 105},
                {name = "Blanchie Brun", cost = 1.5, colour = 106},
                {name = "Schafter Violet", cost = 1.5, colour = 71},
                {name = "Spinnaker Violet", cost = 1.5, colour = 72},
                {name = "Nuit Violet", cost = 1.5, colour = 142},
                {name = "Clair Violet", cost = 1.5, colour = 145},
                {name = "Crème", cost = 1.5, colour = 107},
                {name = "Glace White", cost = 1.5, colour = 111},
                {name = "Gel White", cost = 1.5, colour = 112}
            },
            ["Accessoires Pneus"] = {
                {name = "Stock Pneu", bool = false, cost = 1.5},
                {name = "Custom Pneu", bool = true, cost = 1.5},
                {name = "Blanc Pneu Fumée", colour = {255, 255, 255}, cost = 1.5},
                {name = "Noir Pneu Fumée", colour = {1, 1, 1}, cost = 1.5},
                {name = "Bleu Pneu Fumée", colour = {0, 150, 255}, cost = 1.5},
                {name = "Jaune Pneu Fumée", colour = {255, 255, 50}, cost = 1.5},
                {name = "Orange Pneu Fumée", colour = {255, 153, 51}, cost = 1.5},
                {name = "Rouge Pneu Fumée", colour = {255, 10, 10}, cost = 1.5},
                {name = "Vert Pneu Fumée", colour = {10, 255, 10}, cost = 1.5},
                {name = "Violet Pneu Fumée", colour = {153, 10, 153}, cost = 1.5},
                {name = "Rose Pneu Fumée", colour = {255, 102, 178}, cost = 1.5},
                {name = "Gris Pneu Fumée", colour = {128, 128, 128}, cost = 1.5}
            }
        }
    },
    {
        title = "Fenêtres",
        data = {
            {name = "Aucun", tint = 0, cost = 1},
            {name = "Noir foncé", tint = 1, cost = 5},
            {name = "Fumé", tint = 2, cost = 4},
            {name = "Fumé leger", tint = 3, cost = 3},
            {name = "Limousine", tint = 4, cost = 3},
            {name = "Vert", tint = 5, cost = 2}
        }
    }
}

RMenu.Add(
    "jobs",
    "LSC_NORD",
    RageUI.CreateMenu(nil, "Catégories disponibles", 10, 100, "shopui_title_carmod", "shopui_title_carmod")
)
RMenu.Add(
    "jobs",
    "LSC_NORD_CAT",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "extras",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_NORD_CAT_COLOR",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_NORD_CAT_WHEELS_2",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_NORD_CAT_WHEELS_1",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_NORD_CAT_WHEELS_3",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD_CAT"), nil, "Modifications disponibles", 10, 100)
)
RMenu.Add(
    "jobs",
    "LSC_NORD_CAT_COLOR_1",
    RageUI.CreateSubMenu(RMenu:Get("jobs", "LSC_NORD_CAT_COLOR"), nil, "Modifications disponibles", 10, 100)
)
RMenu:Get("jobs", "LSC_NORD_CAT").Closed = function()
    UpdateCar()
end

RMenu:Get("jobs", "LSC_NORD_CAT_COLOR").Closed = function()
    UpdateCar()
end
RMenu:Get("jobs", "LSC_NORD_CAT_COLOR_1").Closed = function()
    UpdateCar()
end
RMenu:Get("jobs", "LSC_NORD").Closed = function()
    currentvehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleOnGroundProperly(currentvehicle)
    FreezeEntityPosition(currentvehicle, false)
    SetPlayerInvincible(GetPlayerIndex(), false)
    SetEntityInvincible(currentvehicle, false)
end
function EnterZoneLSC_NORD()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le FlyWheels Customs")
    KeySettings:Add("keyboard", "E", OpenLSC_NORD, "LSC_NORD")
    KeySettings:Add("controller", 46, OpenLSC_NORD, "LSC_NORD")
end

function ExitZoneLSC_NORD()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "LSC_NORD")
    KeySettings:Clear("controller", 46, "LSC_NORD")
    RageUI.Visible(RMenu:Get("jobs", "LSC_NORD"), false)
end
local currentData = {}
local currMod = nil
local currentvehicle
local Vehicledata = {}
local modName = nil
local colorTab = {}
local indexColor = nil
local colorrrssTab = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in ipairs(customs) do
                            RageUI.Button(
                                v.title,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        currentData = v
                                        currMod = k
                                        modName = v.title
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_NORD_CAT")
                            )
                        end

                        RageUI.Button(
                            "Extras",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                end
                            end,
                            RMenu:Get("jobs", "extras")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "extras")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, 30, 1 do
                            if DoesExtraExist(currentvehicle, i - 1) then
                                RageUI.Checkbox(
                                    "Extras n°" .. i - 1,
                                    nil,
                                    IsVehicleExtraTurnedOn(currentvehicle, i - 1),
                                    {},
                                    function(Hovered, Ative, Selected, Checked)
                                        if Selected then
                                            SetVehicleExtra(
                                                currentvehicle,
                                                i - 1,
                                                IsVehicleExtraTurnedOn(currentvehicle, i - 1)
                                            )
                                        end
                                    end
                                )
                            end
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD_CAT")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        -- print(currentData.title)
                        if currentData.title == "Peintures" then
                            for k, v in pairs(currentData["data"]) do
                                RageUI.Button(
                                    k,
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        v.Index = Index

                                        if Selected then
                                            colorTab = v
                                            indexColor = k
                                        end
                                    end,
                                    RMenu:Get("jobs", "LSC_NORD_CAT_COLOR")
                                )
                            end
                        elseif currentData.title == "Jantes" then
                            if IsThisModelABike(currentvehicle) then
                                for k, v in pairs(currentData.data["Motos"]) do
                                    RageUI.Button(
                                        k,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                colorTab = v
                                                indexColor = k
                                            end
                                        end,
                                        RMenu:Get("jobs", "LSC_NORD_CAT_WHEELS_2")
                                    )
                                end
                            else
                                for k, v in pairs(currentData.data["Type de jantes"]) do
                                    RageUI.Button(
                                        k,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                colorTab = v
                                                indexColor = k
                                            end
                                        end,
                                        RMenu:Get("jobs", "LSC_NORD_CAT_WHEELS_1")
                                    )
                                end
                            end

                            RageUI.Button(
                                "Couleur des jantes",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        colorTab = currentData.data["Couleur des jantes"]
                                        indexColor = k
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_NORD_CAT_WHEELS_3")
                            )
                        elseif currentData.title == "Xénon" then
                            for k, v in ipairs(currentData.data) do
                                if v.bool or v.bool == "true" then
                                else
                                end
                                if Vehicledata["Xenon"] == tostring(v.bool) then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end

                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            ToggleVehicleMod(currentvehicle, 22, v.bool)
                                        end
                                        if Selected then
                                            if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                Vehicledata["Xenon"] = tostring(v.bool)
                                                LSNORD.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        elseif currentData.title == "Plaques" then
                            for k, v in ipairs(currentData.data) do
                                if Vehicledata["Plate"] == v.plateindex then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            SetVehicleNumberPlateTextIndex(currentvehicle, v.plateindex)
                                        end

                                        if Selected then
                                            if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                Vehicledata["Plate"] = v.plateindex
                                                LSNORD.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        elseif currentData.title == "Fenêtres" then
                            for k, v in ipairs(currentData.data) do
                                if Vehicledata[modName] == v.tint then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            SetVehicleWindowTint(currentvehicle, v.tint)
                                        end
                                        if Selected then
                                            if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                Vehicledata[modName] = v.tint
                                                LSNORD.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        else
                            for k, v in ipairs(currentData.data) do
                                if Vehicledata[modName] == v.mod or (v.mt == 18 and Vehicledata[modName] == v.bool) then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    if (math.floor((v.cost / 100) * vehiclePrice) > vehiclePrice) then
                                        v.price = v.cost
                                    else
                                        v.price = math.floor((v.cost / 100) * vehiclePrice)
                                    end
                                    t = {RightLabel = v.price .. "$"}
                                end
                                RageUI.Button(
                                    v.name,
                                    nil,
                                    t,
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            SetVehicleMod(_v, v.mt, v.mod)
                                        end
                                        if Selected then
                                            if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                                if (v.mt == 18) then
                                                    Vehicledata[modName] = v.bool
                                                    if (v.bool == true) then
                                                        ToggleVehicleMod(_v, 18, true)
                                                    else
                                                        ToggleVehicleMod(_v, 18, false)
                                                    end
                                                else
                                                    Vehicledata[modName] = v.mod
                                                end
                                                --print(v.mod)
                                                LSNORD.BUY(math.floor(v.price))
                                            else
                                            end
                                        end
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD_CAT_WHEELS_1")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                v.name,
                                nil,
                                {RightLabel = math.floor((v.cost / 100) * vehiclePrice)},
                                true,
                                function(_, A, Selected)
                                    if Selected then
                                        if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                            Vehicledata["Wheel Type"] = v.wtype
                                            Vehicledata["Wheels"] = v.mod
                                            LSNORD.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                        else
                                        end
                                    end
                                    if A then
                                        SetVehicleMod(currentvehicle, v.mt, v.mod)
                                        SetVehicleWheelType(currentvehicle, v.wtype)
                                    end
                                end
                            )
                        end
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD_CAT_WHEELS_2")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                v.name,
                                nil,
                                {RightLabel = math.floor((v.cost / 100) * vehiclePrice)},
                                true,
                                function(_, A, Selected)
                                    if Selected then
                                        if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                            Vehicledata["Wheel Type"] = v.wtype
                                            if v.mt == 23 then
                                                Vehicledata["Wheels"] = v.mod
                                            else
                                                Vehicledata["Wheels2"] = v.mod
                                            end
                                            LSNORD.BUY(math.floor((v.cost / 100) * vehiclePrice))
                                        else
                                        end
                                    end
                                    if A then
                                        SetVehicleMod(currentvehicle, v.mt, v.mod)
                                        SetVehicleWheelType(currentvehicle, v.wtype)
                                    end
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD_CAT_WHEELS_3")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                v.name,
                                nil,
                                {RightLabel = math.floor((v.cost / 100) * vehiclePrice)},
                                true,
                                function(_, A, Selected)
                                    if A then
                                        SetVehicleExtraColours(
                                            currentvehicle,
                                            tonumber(Vehicledata["ExtraColours"][1]),
                                            v.colour
                                        )
                                    end
                                    if Selected then
                                        if LSNORD.CanBuy(math.floor((v.cost / 100) * vehiclePrice)) then
                                            Vehicledata["ExtraColours"][2] = v.colour
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD_CAT_COLOR")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        --(dump(currentData))
                        for k, v in pairs(colorTab) do
                            RageUI.Button(
                                k,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        colorrrssTab = v
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_NORD_CAT_COLOR_1")
                            )
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("jobs", "LSC_NORD_CAT_COLOR_1")) then
                local _v = currentvehicle

                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        --(dump(currentData))
                        for k, v in pairs(colorrrssTab) do
                            local t = {}
                            if indexColor == "Couleurs primaires" then
                                if Vehicledata["Colours"][1] == v.colour then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                            elseif indexColor ~= "Nacrage" then
                                if Vehicledata["Colours"][2] == v.colour then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                            else
                                if Vehicledata["ExtraColours"][1] == v.colour then
                                    t = {
                                        RightBadge = RageUI.BadgeStyle.Car
                                    }
                                else
                                    t = {RightLabel = math.floor((v.cost / 100) * vehiclePrice) .. "$"}
                                end
                            end
                            RageUI.Button(
                                v.name,
                                nil,
                                t,
                                true,
                                function(_, A, Selected)
                                    if A then
                                        local mod = nil
                                        if indexColor == "Couleurs primaires" then
                                            mod = v.colour
                                            SetVehicleColours(currentvehicle, mod, Vehicledata["Colours"][2])
                                        elseif indexColor ~= "Nacrage" then
                                            mod = v.colour
                                            SetVehicleColours(currentvehicle, Vehicledata["Colours"][1], mod)
                                        else
                                            mod = v.colour
                                            SetVehicleExtraColours(currentvehicle, mod, Vehicledata["ExtraColours"][2])
                                        end
                                    end

                                    if Selected and LSNORD.CanBuy((v.cost / 100) * vehiclePrice) then
                                        LSNORD.BUY((v.cost / 100) * vehiclePrice)
                                        if indexColor == "Couleurs primaires" then
                                            Vehicledata["Colours"][1] = v.colour
                                        elseif indexColor ~= "Nacrage" then
                                            Vehicledata["Colours"][2] = v.colour
                                        else
                                            Vehicledata["ExtraColours"][1] = v.colour
                                        end
                                        RageUI.GoBack()
                                    end
                                end,
                                RMenu:Get("jobs", "LSC_NORD_CAT_COLOR_1")
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

function OpenLSC_NORD()
    RageUI.Visible(RMenu:Get("jobs", "LSC_NORD"), true)
    currentvehicle = GetVehiclePedIsIn(PlayerPedId())
    vehicleModel = GetEntityModel(currentvehicle)
    vehiclePrice = GetVehiclePriceByCategory(currentvehicle)

    SetVehicleOnGroundProperly(currentvehicle)
    FreezeEntityPosition(currentvehicle, true)
    SetPlayerInvincible(GetPlayerIndex(), true)
    SetEntityInvincible(currentvehicle, true)
    for i = 1, 31 do
        customs[i].data = {}
    end
    for i = 1, 31 do
        SetVehicleModKit(currentvehicle, 0)
        if
            GetNumVehicleMods(currentvehicle, customs[i].mod) ~= nil and
                GetNumVehicleMods(currentvehicle, customs[i].mod) ~= false
         then
            local mt = customs[i].mod
            local startingcost = math.floor((customs[i].startingcost / 100) * vehiclePrice)

            if mt ~= nil then
                table.insert(customs[i].data, {name = "Aucun", cost = 0, mt = mt, mod = -1})
                for a = 0, GetNumVehicleMods(currentvehicle, mt) - 1 do
                    local prevmodname = nil
                    local label = GetModTextLabel(currentvehicle, mt, a)
                    if label ~= nil then
                        local modname = tostring(GetLabelText(label))
                        if prevmodname == nil and prevmodname ~= modname then
                            if modname ~= "NULL" then
                                local finalCost = (startingcost / vehiclePrice) * 100
                                table.insert(customs[i].data, {name = modname, cost = finalCost, mt = mt, mod = a})
                                prevmodname = modname
                            end
                        end
                    end
                end
            end
        end
    end

    local turbo
    local tiresmoke
    local xenon
    local neon0
    local neon1
    local neon2
    local neon3
    local neon4
    local bulletproof
    local variation
    local plate = GetVehicleNumberPlateText(currentvehicle)
    if IsToggleModOn(currentvehicle, 18) then
        turbo = "true"
    else
        turbo = "false"
    end
    if IsToggleModOn(currentvehicle, 20) then
        tiresmoke = "true"
    else
        tiresmoke = "false"
    end
    if IsToggleModOn(currentvehicle, 22) then
        xenon = "true"
    else
        xenon = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle, 0) then
        neon0 = "true"
    else
        neon0 = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle, 1) then
        neon1 = "true"
    else
        neon1 = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle, 2) then
        neon2 = "true"
    else
        neon2 = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle, 3) then
        neon3 = "true"
    else
        neon3 = "false"
    end
    if GetVehicleTyresCanBurst(currentvehicle) then
        bulletproof = "Non"
    else
        bulletproof = "Oui"
    end
    if GetVehicleModVariation(currentvehicle, 23) then
        variation = "true"
    else
        variation = "false"
    end
    if neon0 == "true" and neon1 == "true" and neon2 == "true" and neon3 == "true" then
        neon4 = 1
    else
        neon4 = 0
    end
    Vehicledata = {
        ["Colours"] = table.pack(GetVehicleColours(currentvehicle)),
        ["ExtraColours"] = table.pack(GetVehicleExtraColours(currentvehicle)),
        ["NeonColours"] = table.pack(GetVehicleNeonLightsColour(currentvehicle)),
        ["SmokeColours"] = table.pack(GetVehicleTyreSmokeColor(currentvehicle)),
        ["Aileron"] = GetVehicleMod(currentvehicle, 0), -- Vehicle Mod 0
        ["Pare-chocs avant"] = GetVehicleMod(currentvehicle, 1), -- Vehicle Mod 1
        ["Pare-chocs arrière"] = GetVehicleMod(currentvehicle, 2), -- Vehicle Mod 2
        ["Bas de caisse"] = GetVehicleMod(currentvehicle, 3), -- Vehicle Mod 3
        ["Échappement"] = GetVehicleMod(currentvehicle, 4), -- Vehicle Mod 4
        ["Cage"] = GetVehicleMod(currentvehicle, 5), -- Vehicle Mod 5
        ["Grille"] = GetVehicleMod(currentvehicle, 6), -- Vehicle Mod 6
        ["Capot"] = GetVehicleMod(currentvehicle, 7), -- Vehicle Mod 7
        ["Aile gauche"] = GetVehicleMod(currentvehicle, 8), -- Vehicle Mod 8
        ["Aile droite"] = GetVehicleMod(currentvehicle, 9), -- Vehicle Mod 9
        ["Toit"] = GetVehicleMod(currentvehicle, 10), -- Vehicle Mod 10
        ["Moteur"] = GetVehicleMod(currentvehicle, 11), -- Vehicle Mod 11
        ["Freins"] = GetVehicleMod(currentvehicle, 12), -- Vehicle Mod 12
        ["Transmission"] = GetVehicleMod(currentvehicle, 13), -- Vehicle Mod 13
        ["Klaxon"] = GetVehicleMod(currentvehicle, 14), -- Vehicle Mod 14
        ["Suspension"] = GetVehicleMod(currentvehicle, 15), -- Vehicle Mod 15
        ["Armour"] = GetVehicleMod(currentvehicle, 16), -- Vehicle Mod 16
        ["Plate"] = GetVehicleNumberPlateTextIndex(currentvehicle), -- Colour of license plate
        ["Fenêtres"] = GetVehicleWindowTint(currentvehicle), -- Window Tint
        ["Wheel Type"] = GetVehicleWheelType(currentvehicle), -- Wheel type
        ["Turbo"] = turbo, -- Turbo
        ["Xenon"] = xenon, -- Xenon Lights
        ["Tyre Smoke"] = tiresmoke, -- Tyre Smoke
        ["Wheels"] = GetVehicleMod(currentvehicle, 23), -- Vehicle Mod 23
        ["Wheels2"] = GetVehicleMod(currentvehicle, 24), -- Vehicle Mod 24
        n0 = neon0, -- Neon 0
        n1 = neon1, -- Neon 1
        n2 = neon2, -- Neon 2
        n3 = neon3, -- Neon 3
        ["Layout"] = neon4,
        ["Variation"] = variation -- Custom Wheels
    }
end

function UpdateCar()
    local currentvehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleColours(currentvehicle, tonumber(Vehicledata["Colours"][1]), tonumber(Vehicledata["Colours"][2]))
    SetVehicleExtraColours(
        currentvehicle,
        tonumber(Vehicledata["ExtraColours"][1]),
        tonumber(Vehicledata["ExtraColours"][2])
    )
    SetVehicleNumberPlateTextIndex(currentvehicle, tonumber(Vehicledata["Plate"]))
    SetVehicleNeonLightsColour(
        currentvehicle,
        tonumber(Vehicledata["NeonColours"][1]),
        tonumber(Vehicledata["NeonColours"][2]),
        tonumber(Vehicledata["NeonColours"][3])
    )
    SetVehicleTyreSmokeColor(
        currentvehicle,
        tonumber(Vehicledata["SmokeColours"][1]),
        tonumber(Vehicledata["SmokeColours"][2]),
        tonumber(Vehicledata["SmokeColours"][3])
    )
    SetVehicleModKit(currentvehicle, 0)
    SetVehicleMod(currentvehicle, 0, tonumber(Vehicledata["Aileron"]))
    SetVehicleMod(currentvehicle, 1, tonumber(Vehicledata["Pare-chocs avant"]))
    SetVehicleMod(currentvehicle, 2, tonumber(Vehicledata["Pare-chocs arrière"]))
    SetVehicleMod(currentvehicle, 3, tonumber(Vehicledata["Bas de caisse"]))
    SetVehicleMod(currentvehicle, 4, tonumber(Vehicledata["Échappement"]))
    SetVehicleMod(currentvehicle, 5, tonumber(Vehicledata["Cage"]))
    SetVehicleMod(currentvehicle, 6, tonumber(Vehicledata["Grille"]))
    SetVehicleMod(currentvehicle, 7, tonumber(Vehicledata["Capot"]))
    SetVehicleMod(currentvehicle, 8, tonumber(Vehicledata["Aile gauche"]))
    SetVehicleMod(currentvehicle, 9, tonumber(Vehicledata["Aile droite"]))
    SetVehicleMod(currentvehicle, 10, tonumber(Vehicledata["Toit"]))
    SetVehicleMod(currentvehicle, 11, tonumber(Vehicledata["Moteur"]))
    SetVehicleMod(currentvehicle, 12, tonumber(Vehicledata["Freins"]))
    SetVehicleMod(currentvehicle, 13, tonumber(Vehicledata["Transmission"]))
    SetVehicleMod(currentvehicle, 14, tonumber(Vehicledata["Klaxon"]))
    SetVehicleMod(currentvehicle, 15, tonumber(Vehicledata["Suspension"]))
    SetVehicleMod(currentvehicle, 16, tonumber(Vehicledata["Armour"]))
    if Vehicledata["Turbo"] == "true" then
        ToggleVehicleMod(currentvehicle, 18, true)
    else
        ToggleVehicleMod(currentvehicle, 18, false)
    end
    if Vehicledata["Tyre Smoke"] == "true" then
        ToggleVehicleMod(currentvehicle, 20, true)
    else
        ToggleVehicleMod(currentvehicle, 20, false)
    end
    if Vehicledata["Xenon"] == "true" then
        ToggleVehicleMod(currentvehicle, 22, true)
    else
        ToggleVehicleMod(currentvehicle, 22, false)
    end
    SetVehicleWheelType(currentvehicle, tonumber(Vehicledata["Wheel Type"]))
    SetVehicleMod(currentvehicle, 23, tonumber(Vehicledata["Wheels"]))
    SetVehicleMod(currentvehicle, 24, tonumber(Vehicledata["Wheels2"]))
    if Vehicledata["Variation"] == "true" then
        SetVehicleMod(currentvehicle, 23, GetVehicleMod(currentvehicle, 23), true)
        -- Vehicle Mod 23
        SetVehicleMod(currentvehicle, 24, GetVehicleMod(currentvehicle, 24), true)
    -- Vehicle Mod 24
    end
    if Vehicledata.n0 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 0, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 0, false)
    end
    if Vehicledata.n1 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 1, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 1, false)
    end
    if Vehicledata.n2 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 2, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 2, false)
    end
    if Vehicledata.n3 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle, 3, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle, 3, false)
    end
    if Vehicledata.bp == "true" then
        SetVehicleTyresCanBurst(currentvehicle, false)
    else
        SetVehicleTyresCanBurst(currentvehicle, true)
    end
    SetVehicleWindowTint(currentvehicle, tonumber(Vehicledata["Fenêtres"]))

    TriggerServerCallback(
        "core:GetVehicleOwnedX",
        function(b)
            if b then
                TriggerServerEvent(
                    "vehicle:SetProperties",
                    GetVehicleNumberPlateText(currentvehicle),
                    vehicleFct.GetVehicleProperties(currentvehicle)
                )
            else
                --    ShowNotification("~r~Véhicule inexistant")
            end
        end,
        GetVehicleNumberPlateText(currentvehicle)
    )
end
