show_your_name = false
enable_blips = false
enable_names = false
color_blip = 3 -- blue
sprite_blip = 270

-- name head
scaleY = 0.55
distance_from_head = 1.0
text_font = 0

enable_rank = false
-- Change letters according to your preference
-- d = days
-- m = month
-- y = year
date_format = "%d/%m/%y"

use_script_in_coordinates = false
range_use = 50.0
coordinates = {
    vector3(0.0,0.0,0.0)
}

commands = {
    crewmenu = "crew",
    joincrew = "joincrew",
    createcrew = 'createcrew',
    invitecrew = 'invitecrew',
    leftcrew = 'leftcrew',
    prove = 'provecrew',
    demote = 'demotecrew',
    list = 'listcrew',
    kick = 'kickcrew',
    deletecrew = 'deletecrew',
    ranking = 'rank'
}

translate = {
    TR_CREATE_CREW = "Vous avez créé un crew !",
    TR_CANOT_NAME = "Il y a déjà un crew avec ce nom",
    TR_CANOT_CREATE = "Vous faites déjà partie d'un Crew",
    TR_CANOT_CREATE2 = "Utilisez /exitcrew comme commande pour quitter votre Crew, ou /deletecrew pour supprimer votre Crew.",
    TR_NOT_PERMISSION = "Vous n'avez pas d'autorisation ou ne faites pas partie d'un crew",
    TR_NOT_FOUND = "Joueur non trouvé",
    TR_HAS_CREW = "Ce joueur a déjà un Crew",
    TR_RECEIVE_INVITE = "Vous avez reçu une invitation pour rejoindre un Crew",
    TR_RECEIVE_INVITE2 = "Utilisez la commande /joincrew pour rejoindre le Crew",
    TR_SEND_INVITE = "Invitation envoyée",
    TR_HAS_CREW2 = "Vous avez déjà un Crew",
    TR_NOT_HAS = "Tu n'es dans aucun Crew",
    TR_EXIT = 'Vous avez quitté votre Crew',
    TR_DONT_EXIT = "Vous ne pouvez pas quitter un Crew dont vous êtes le chef.",
    TR_DONT_EXIT2 = "Utilisez la commande /deletecrew si vous souhaitez supprimer le crew",
    TR_NOTIFY_DELETE = "Le Crew dont vous étiez membre a été supprimé.",
    TR_NOT_PART = "Le joueur ne fait pas partie de votre Crew", 
    TR_RECEIVE_PROVE = "Le joueur a été promu",
    TR_RECEIVE_PROVE2 = "Vous avez reçu une promotion",
    TR_RECEIVE_DEMOTE = "Le joueur a été rétrogradé",
    TR_RECEIVE_DEMOTE2 = "Vous avez reçu une rétrogradation",
    TR_KICK = "Joueur expulsé du Crew.",
    TR_KICK2 = "Vous avez été expulsé de votre Crew",

    TR_CREWNAME = "Nom du Crew",
    TR_KILLS = "Kills",
    TR_CREATEDAT = "Créé à",
    TR_RANKMEMBERS = "Nombres de membres",

    TR_NOT_COORDINATE = "You are not in the right place to use this.",

    TR_CREATE = "Créer",
    TR_CREATE2 = "Créer un nouveau crew",
    TR_JOIN = "Rejoindre",
    TR_JOIN2 = "Rejoindre un crew",
    TR_INVITE = "Inviter",
    TR_INVITE2 = "Inviter un membre dans votre crew",
    TR_LEAVE = "Quitter",
    TR_LEAVE2 = "Quitter votre crew",
    TR_PROMOTE = "Promotion",
    TR_PROMOTE2 = "Promouvoir un membre",
    TR_DEMOTE = "Rétrogradez",
    TR_DEMOTE2 = "Rétrogradez un membre",
    TR_LIST = "Liste",
    TR_LIST2 = "Liste des membres du crew",
    TR_KICK_MENU = "Virer",
    TR_KICK_MENU2 = "Virer un membre",
    TR_RANK = "Fonction désactivé",
    TR_RANK2 = "Fonction désactivé"
}