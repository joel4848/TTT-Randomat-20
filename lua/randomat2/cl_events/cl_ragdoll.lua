local EVENT = {}
EVENT.id = "ragdoll"

local function BlockTargetID(ent, client, text, color)
    if not IsValid(ent) then return end

    if ent:GetNWBool("RdmtRagdollRagdoll", false) then
        return false
    end
end

local function BlockHUDPickup(a, b)
    return true
end

function EVENT:Begin()
    self:AddHook("TTTTargetIDRagdollName", BlockTargetID)
    self:AddHook("TTTTargetIDEntityHintLabel", BlockTargetID)
    self:AddHook("TTTTargetIDPlayerHintText", BlockTargetID)

    net.Receive("RdmtRagdollRagdolled", function()
        self:AddHook("TTTBlockHUDWeaponPickedUp", BlockHUDPickup)
        self:AddHook("TTTBlockHUDItemPickedUp", BlockHUDPickup)
        self:AddHook("TTTBlockHUDAmmoPickedUp", BlockHUDPickup)
        self:AddHook("TTTBlockHUDDrawPickupHistory", BlockHUDPickup)
    end)

    net.Receive("RdmtRagdollUnragdolled", function()
        self:RemoveHook("TTTBlockHUDWeaponPickedUp")
        self:RemoveHook("TTTBlockHUDItemPickedUp")
        self:RemoveHook("TTTBlockHUDAmmoPickedUp")
        self:RemoveHook("TTTBlockHUDDrawPickupHistory")
    end)
end

Randomat:register(EVENT)