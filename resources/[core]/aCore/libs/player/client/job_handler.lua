Job =
    setmetatable(
    {
        isWorking = false
    },
    Job
)
JobBLIP = {}
CurrentZone = nil
inServiceS = false
function Job:Set(_job, grade)
    local m = _job
    _job = Jobs[_job]
    if _job == nil then
        error("Job incorrect ! " .. m)
    end
    self.Job = _job
    self.Job.gradenum = tonumber(grade)
    self.Job.name = m
    self.grade = grade
    self.garage = _job.garage
    for i = 1, #JobBLIP, 1 do
        RemoveBlip(JobBLIP[i])
    end

    JobBLIP = {}
    TriggerEvent("myJobIs", self.Job.name)
    if _job ~= nil then
        if _job.grade[tonumber(grade)] == nil then
            error("Grade incorrect !")
        end
        self.Job.gradelabel = _job.grade[tonumber(grade)].label

        if _job.grade[tonumber(grade)].show == false then
            TriggerEvent("es:activateJob", _job.label)
        else
            TriggerEvent("es:activateJob", _job.label .. " " .. _job.grade[tonumber(grade)].label)
        end

        InitJob(Jobs[m], "Jobs")
    else
        TriggerEvent("es:activateJob", nil)
    end
end

function InitJob(Jobs, Type)
    v = Jobs
    v = v
    local t = v.Menu
    local works = v.work
    local Extrapos = v.Extrapos
    local extraBlips = v.Extrablips
    local Storages = v.Storage
    if k == "coiffeur" then
        createCoiffeurJob()
    end
    if v.garage ~= nil then
        local garage = Garage.New(v.garage.Name, v.garage.Pos, v.garage.Properties, v.garage.Blipdata)
        garage:Setup()
    end

    if v.garage2 ~= nil then
        local garage = Garage.New(v.garage2.Name, v.garage2.Pos, v.garage2.Properties, v.garage2.Blipdata)
        garage:Setup()
    end

    if v.garage3 ~= nil then
        local garage = Garage.New(v.garage3.Name, v.garage3.Pos, v.garage3.Properties, v.garage3.Blipdata)
        garage:Setup()
    end

    if Storages then
        for c, t in pairs(Storages) do
            local Storage = Storage.New(t.Name .. "_storage", t.Limit)
            Storage:LinkToPos(t.Pos)
        end
    end

    if Type ~= "Orga" then
        if t then
            LoadJobMenu(t)
        end
        if v.CustomMenu then
            LoadCustomMenu(k)
        end
    else
        if t then
            LoadOrgaMenu(t)
        end
    end
    if Extrapos ~= nil then
        for k, v in pairs(Extrapos) do
            --print("loading extrapos", k)
            local f = false
            if v.restricted ~= nil then
                for i = 1, #v.restricted, 1 do
                    if v.restricted[i] == Job:Get().gradenum then
                        f = true
                        break
                    end
                end
            else
                f = true
            end
            if f then
                for i = 1, #v.Pos, 1 do
                    Zone:Add(v.Pos[i], v.Enter, v.Exit, k, v.zonesize)
                    local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
                    SetBlipSprite(blip, v.Blips.sprite)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, 0.6)
                    SetBlipColour(blip, v.Blips.color)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.Blips.name)
                    EndTextCommandSetBlipName(blip)
                    v.Pos[i].z = v.Pos[i].z - 1.0
                    Marker:Add(v.Pos[i], v.Marker)
                end
            end
        end
    end
    if extraBlips ~= nil then
        for k, v in pairs(extraBlips) do
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, v.Blips.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, v.Blips.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blips.name)
            EndTextCommandSetBlipName(blip)
        end
    end
    if works ~= nil then
        for k, v in pairs(works) do
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, 1)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, v.blipcolor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipname)
            EndTextCommandSetBlipName(blip)
            table.insert(JobBLIP, blip)
            Zone:Add(
                v.Pos,
                function()
                    --(k)
                    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                    KeySettings:Add("keyboard", "E", JobStartAct, k)
                    KeySettings:Add("controller", 46, JobStartAct, k)
                    CurrentZone = Type
                end,
                function()
                    Hint:RemoveAll()
                    KeySettings:Clear("keyboard", "E", k)
                    KeySettings:Clear("controller", 46, k)
                    RageUI.Visible(RMenu:Get("jobs", k), false)
                    StopCurrentWork(true)
                    CurrentZone = nil
                end,
                k,
                v.workSize or 1.5
            )
            RMenu.Add("jobs", k, RageUI.CreateMenu(nil, "Tenues disponibles", 10, 100))
        end
    end
end
function Job:Get()
    return self.Job
end
AddEventHandler(
    "getmyjobname",
    function(cb)
        if Job:Get() == nil then
            return "rien"
        end
        cb(Job:Get().name)
    end
)
function Job:GetGrg()
    return self.garage
end
function Job:IsBoss()
    if self.Job.grade[self.Job.gradenum].name == "boss" then
        return true
    end
end

function Job:IsCoBoss()
    if self.Job.grade[self.Job.gradenum].name == "drh" then
        return true
    end
end

function Job:GetSalary()
    return self.Job.grade[self.Job.gradenum].salary
end

Orga =
    setmetatable(
    {
        isWorking = false
    },
    Orga
)
OrgaBlip = {}
function Orga:Set(_job, grade)
    local m = _job
    _job = Jobs[_job]
    if _job ~= nil then
        if _job == nil then
            error("Job incorrect ! " .. m)
        end
        self.Job = _job
        self.Job.gradenum = tonumber(grade)
        self.Job.name = m
        self.grade = grade
        self.garage = _job.garage
        for i = 1, #OrgaBlip, 1 do
            RemoveBlip(OrgaBlip[i])
        end
        OrgaBlip = {}
        if _job ~= nil then
            if _job.grade[tonumber(grade)].show == false then
                TriggerEvent("es:activateJob2", _job.label)
            else
                TriggerEvent("es:activateJob2", _job.label .. " " .. _job.grade[tonumber(grade)].label)
            end
            InitJob(Jobs[self.Job.name], "Orga")
        else
            TriggerEvent("es:activateJob2", nil)
        end
    end
end

function Orga:Get()
    return self.Job
end

function JobStartAct(d)
    -- TODO
    --(CurrentZone)
    Job.CurrentAction = d
    if d == "vestiaire" then
        Job:OpenClotheRoom(CurrentZone)
    else
        Job:StartRecolte(CurrentZone)
    end
end

function isAnyJob(job, type)
    if type == nil then
        type = "Jobs"
    end
    if type == "Jobs" then
        if job == Job.Job.name then
            return true
        else
        end
    else
        if Orga.Job ~= nil and job == Orga.Job.name then
            return true
        else
            return false
        end
    end
end

-- TODO achever systeme de job

RegisterNetEvent("Jobs:SetRank")
AddEventHandler(
    "Jobs:SetRank",
    function(e)
        Job:Set(Job:Get().name, e)
    end
)

RegisterNetEvent("Jobs:SetJob2")
AddEventHandler(
    "Jobs:SetJob2",
    function(job, grade)
        Job:Set(job, grade)
    end
)
RegisterNetEvent("Orga:SetJob2")
AddEventHandler(
    "Orga:SetJob2",
    function(job, grade)
        Orga:Set(job, grade)
    end
)

function UpdateService()
    TriggerServerEvent("core:SetService", Job:Get().name, inServiceS)
end

function Orga:IsBoss()
    if self.Job ~= nil and self.Job.grade[self.Job.gradenum].name == "boss" then
        return true
    end
end

function Orga:IsCoBoss()
    if self.Job ~= nil and self.Job.grade[self.Job.gradenum].name == "drh" then
        return true
    end
end
