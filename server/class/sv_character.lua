---@class Character


---comment
---@param source number
---@param identifier string
---@param charIdentifier number
---@param group string
---@param job string
---@param jobgrade number
---@param firstname string
---@param lastname string
---@param inventory string
---@param status string
---@param coords vector
---@param money number
---@param gold number
---@param rol number
---@param healthOuter number
---@param healthInner number
---@param staminaOuter number
---@param staminaInner number
---@param xp number
---@param hours number
---@param isdead boolean
---@param skin table
---@param comps table
---@return Character
function Character(source, identifier, charIdentifier, group, job, jobgrade, firstname, lastname, inventory, status,
                   coords, money, gold, rol, healthOuter, healthInner, staminaOuter, staminaInner, xp, hours, isdead,
                   skin,
                   comps)
    local self = {}

    self.identifier = identifier
    self.charIdentifier = charIdentifier
    self.group = group
    self.job = job
    self.jobgrade = jobgrade
    self.firstname = firstname
    self.lastname = lastname
    self.inventory = inventory
    self.status = status
    self.coords = coords
    self.skin = skin
    self.comps = comps
    self.money = money
    self.gold = gold
    self.rol = rol
    self.healthOuter = healthOuter
    self.healthInner = healthInner
    self.staminaOuter = staminaOuter
    self.staminaInner = staminaInner
    self.xp = xp
    self.hours = hours
    self.isdead = isdead
    --self.userPlayer --Isto serve para que mesmo???
    self.source = source

    self.Identifier = function()
        return self.identifier
    end

    self.CharIdentifier = function(value)
        if value ~= nil then
            self.charIdentifier = value
        end
        return self.charIdentifier
    end
    self.Group = function(value)
        if value ~= nil then
            self.group = value
        end
        TriggerEvent("vorp:playerGroupChange", self.source, self.group) -- listener for group change
        return self.group
    end
    self.Job = function(value)
        if value ~= nil then self.job = value end
        TriggerEvent("vorp:playerJobChange", self.source, self.job) -- listener for job change
        return self.job
    end
    self.Jobgrade = function(value)
        if value ~= nil then self.jobgrade = value end
        TriggerEvent("vorp:playerJobGradeChange", self.source, self.jobgrade) -- listener for job grade change
        return self.jobgrade
    end
    self.Firstname = function(value)
        if value ~= nil then self.firstname = value end
        return self.firstname
    end
    self.Lastname = function(value)
        if value ~= nil then self.lastname = value end
        return self.lastname
    end
    self.Inventory = function(value)
        if value ~= nil then self.inventory = value end
        return self.inventory
    end
    self.Status = function(value)
        if value ~= nil then self.status = value end
        return self.status
    end
    self.Coords = function(value)
        if value ~= nil then self.coords = value end
        return self.coords
    end
    self.Money = function(value)
        if value ~= nil then self.money = value end
        return self.money
    end
    self.Gold = function(value)
        if value ~= nil then self.gold = value end
        return self.gold
    end
    self.Rol = function(value)
        if value ~= nil then self.rol = value end
        return self.rol
    end
    self.HealthOuter = function(value)
        if value ~= nil then self.healthOuter = value end
        return self.healthOuter
    end
    self.HealthInner = function(value)
        if value ~= nil then self.healthInner = value end
        return self.healthInner
    end
    self.StaminaOuter = function(value)
        if value ~= nil then self.staminaOuter = value end
        return self.staminaOuter
    end
    self.StaminaInner = function(value)
        if value ~= nil then self.staminaInner = value end
        return self.staminaInner
    end
    self.Xp = function(value)
        if value ~= nil then self.xp = value end
        return self.xp
    end
    self.Hours = function(value)
        if value ~= nil then self.hours = value end
        return self.hours
    end
    self.IsDead = function(value)
        if value ~= nil then self.isdead = value end
        return self.isdead
    end

    self.Skin = function(value)
        if value ~= nil then
            self.skin = value
            MySQL.update("UPDATE characters SET `skinPlayer` = ? WHERE `identifier` = ? AND `charidentifier` = ?"
            , { value, self.Identifier(), self.CharIdentifier() })
        end

        return self.skin
    end

    self.Comps = function(value)
        if value ~= nil then
            self.comps = value
            MySQL.update("UPDATE characters SET `compPlayer` = ? WHERE `identifier` = ? AND `charidentifier` = ?"
            , { value, self.Identifier(), self.CharIdentifier() })
        end

        return self.comps
    end

    self.getCharacter = function()
        local userData = {}

        userData.identifier = self.identifier
        userData.charIdentifier = self.charIdentifier
        userData.group = self.group
        userData.job = self.job
        userData.jobGrade = self.jobgrade
        userData.money = self.money
        userData.gold = self.gold
        userData.rol = self.rol
        userData.xp = self.xp
        userData.healthOuter = self.healthOuter
        userData.healthInner = self.healthInner
        userData.staminaOuter = self.staminaOuter
        userData.staminaInner = self.staminaInner
        userData.hours = self.hours
        userData.firstname = self.firstname
        userData.lastname = self.lastname
        userData.inventory = self.inventory
        userData.status = self.status
        userData.coords = self.coords
        userData.isdead = self.isdead
        userData.skin = self.skin
        userData.comps = self.comps

        userData.setStatus = function(status) --Prevent bugs here
            self.Status(status)
        end

        userData.setJobGrade = function(jobgrade)
            self.Jobgrade(jobgrade)
        end

        userData.setGroup = function(group)
            self.Group(group)
        end

        userData.setJob = function(job)
            self.Job(job)
        end

        self.setJobGrade = function(jobgrade)
            self.Jobgrade(jobgrade)
        end

        userData.setMoney = function(money)
            self.Money(money)
            self.updateCharUi()
        end

        userData.setGold = function(gold)
            self.Gold(gold)
            self.updateCharUi()
        end

        userData.setRol = function(rol)
            self.Rol(rol)
            self.updateCharUi()
        end

        userData.setXp = function(xp)
            self.Xp(xp)
            self.updateCharUi()
        end

        userData.setFirstname = function(firstname)
            self.Firstname(firstname)
        end

        userData.setLastname = function(lastname)
            self.Lastname(lastname)
        end

        userData.updateSkin = function(skin)
            self.Skin(skin)
        end

        userData.updateComps = function(comps)
            self.Comps(comps)
        end

        userData.addCurrency = function(currency, quantity)
            self.addCurrency(currency, quantity)
        end

        userData.removeCurrency = function(currency, quantity)
            self.removeCurrency(currency, quantity)
        end

        userData.addXp = function(xp)
            self.addXp(xp)
        end

        userData.removeXp = function(xp)
            self.removeXp(xp)
        end

        userData.updateCharUi = function()
            local nuipost = {}

            nuipost["type"] = "ui"
            nuipost["action"] = "update"
            nuipost["moneyquanty"] = self.Money()
            nuipost["goldquanty"] = self.Gold()
            nuipost["rolquanty"] = self.Rol()
            nuipost["serverId"] = self.source
            nuipost["xp"] = self.Xp()

            TriggerClientEvent("vorp:updateUi", self.source, json.encode(nuipost))
        end

        return userData
    end

    self.updateCharUi = function()
        local nuipost = {}

        nuipost["type"] = "ui"
        nuipost["action"] = "update"
        nuipost["moneyquanty"] = self.Money()
        nuipost["goldquanty"] = self.Gold()
        nuipost["rolquanty"] = self.Rol()
        nuipost["serverId"] = self.source
        nuipost["xp"] = self.Xp()

        TriggerClientEvent("vorp:updateUi", self.source, json.encode(nuipost))
    end

    self.addCurrency = function(currency, quantity) --add check for security
        if currency == 0 then
            self.money = self.money + quantity
        elseif currency == 1 then
            self.gold = self.gold + quantity
        elseif currency == 2 then
            self.rol = self.rol + quantity
        end
        self.updateCharUi()
    end

    self.removeCurrency = function(currency, quantity) --add check for security
        if currency == 0 then
            self.money = self.money - quantity
        elseif currency == 1 then
            self.gold = self.gold - quantity
        elseif currency == 2 then
            self.rol = self.rol - quantity
        end
        self.updateCharUi()
    end

    self.addXp = function(quantity) --add check for security
        self.xp = self.xp + quantity
        self.updateCharUi()
    end

    self.removeXp = function(quantity) --add check for security
        self.Xp = self.xp - quantity
        self.updateCharUi()
    end

    self.saveHealthAndStamina = function(healthOuter, healthInner, staminaOuter, staminaInner)
        self.healthOuter = healthOuter
        self.healthInner = healthInner
        self.staminaOuter = staminaOuter
        self.staminaInner = staminaInner
    end

    self.setJob = function(newjob)
        self.Job(newjob)
    end

    self.setGroup = function(newgroup)
        self.Group(newgroup)
    end

    self.setDead = function(dead)
        self.IsDead(dead)
    end

    self.UpdateHours = function(hours)
        self.hours = self.hours + hours
    end

    self.SaveNewCharacterInDb = function(cb)
        MySQL.query(
            "INSERT INTO characters(`identifier`,`group`,`money`,`gold`,`rol`,`xp`,`healthouter`,`healthinner`,`staminaouter`,`staminainner`,`hours`,`inventory`,`job`,`status`,`firstname`,`lastname`,`skinPlayer`,`compPlayer`,`jobgrade`,`coords`,`isdead`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
            ,
            { self.Identifier(), self.Group(), self.Money(), self.Gold(), self.Rol(), self.Xp(), self.HealthOuter(),
                self.HealthInner(), self.StaminaOuter(), self.StaminaInner(), self.Hours(), self.Inventory(), self.Job(),
                self.Status(), self.Firstname(), self.Lastname(), self.Skin(), self.Comps(), self.Jobgrade(),
                self.Coords(), self.IsDead()
            },
            function(character)
                cb(character.insertId)
            end)
    end

    self.DeleteCharacter = function()
        MySQL.query("DELETE FROM characters WHERE `identifier` = ? AND `charidentifier` = ? ",
            { self.Identifier(), self.CharIdentifier() })
    end

    self.SaveCharacterCoords = function(coords)
        self.Coords(coords)
        MySQL.update("UPDATE characters SET `coords` = ? WHERE `identifier` = ? AND `charidentifier` = ?"
        , { self.Coords(), self.Identifier(), self.CharIdentifier() })
    end

    self.SaveCharacterInDb = function()
        MySQL.update(
            "UPDATE characters SET `group` = ?,`money` = ?,`gold` = ?,`rol` = ?,`xp` = ?,`healthouter` = ?,`healthinner` = ?,`staminaouter` = ?,`staminainner` = ?,`hours` = ?,`job` = ?, `status` = ?,`firstname` = ?, `lastname` = ?, `jobgrade` = ?,`coords` = ?,`isdead` = ? WHERE `identifier` = ? AND `charidentifier` = ?"
            ,
            { self.Group(), self.Money(), self.Gold(), self.Rol(), self.Xp(), self.HealthOuter(), self.HealthInner(),
                self.StaminaOuter(), self.StaminaInner(), self.Hours(), self.Job(), self.Status(), self.Firstname(),
                self.Lastname(), self.Jobgrade(), self.Coords(), self.IsDead(), tostring(self.Identifier()),
                self.CharIdentifier()
            }
        )
    end

    return self
end
