--Scripted by Eerie Code
--Performage Cup Tricker
function c700000025.initial_effect(c)
	--Pendulum Summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74605254,1))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12744567,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c700000025.xyztg)
	e2:SetOperation(c700000025.xyzop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(102380,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetTarget(c700000025.sptg)
	e3:SetOperation(c700000025.spop)
	c:RegisterEffect(e3)
	--attach
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCondition(c700000025.thcon)
	e4:SetTarget(c700000025.thtg)
	e4:SetOperation(c700000025.thop)
	c:RegisterEffect(e4)
end

function c700000025.xyzfil(c)
	return c:IsType(TYPE_XYZ)
end
function c700000025.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c700000025.xyzfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000025.xyzfil,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c700000025.xyzfil,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000025.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end

function c700000025.spfil(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0
end
function c700000025.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c700000025.spfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000025.spfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local tg=Duel.SelectTarget(tp,c700000025.spfil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local g=tg:GetFirst():GetOverlayGroup()
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c700000025.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		tc:RegisterEffect(e1)
	end
end


function c700000025.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_COST) and re:IsHasType(0x7e0) and re:IsActiveType(TYPE_MONSTER) and bit.band(c:GetPreviousLocation(),LOCATION_OVERLAY)~=0 then
		return true
	else return false end
end
function c700000025.thfil1(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c700000025.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetOverlayCount(tp,1,0)>0 and Duel.IsExistingMatchingCard(c700000025.thfil1,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
end
function c700000025.thop(e,tp,eg,ep,ev,re,r,rp)
	
	--if not tc:IsRelateToEffect(e) or not tc:GetOverlayTarget():IsRelateToEffect(e) or not Duel.IsExistingMatchingCard(c700000025.thfil1,tp,LOCATION_MZONE,0,2,nil) then return end
	local mg=Duel.GetOverlayGroup(tp,1,0):Select(tp,1,1,nil)
	if mg:GetCount()==0 then return end
	local tc=mg:GetFirst()
	local g=Duel.SelectMatchingCard(tp,c700000025.thfil1,tp,LOCATION_MZONE,0,1,1,tc:GetOverlayTarget())
	if g:GetCount()>0 then
		Duel.Overlay(g:GetFirst(),tc)
		Duel.RaiseSingleEvent(tc:GetOverlayTarget(),EVENT_DETACH_MATERIAL,e,0,0,0,0)
	end
end