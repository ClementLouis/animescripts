--Action Field - Brain Research Lab
function c95000063.initial_effect(c)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetOperation(c95000063.op)
	c:RegisterEffect(e1)
	--unaffectable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetValue(c95000063.ctcon2)
	c:RegisterEffect(e3)
	--cannot set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SSET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(1,1)
	e4:SetTarget(c95000063.aclimit2)
	c:RegisterEffect(e4)
	--~ Add Action Card
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(95000063,0))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetCondition(c95000063.condition)
	e5:SetTarget(c95000063.Acttarget)
	e5:SetOperation(c95000063.operation)
	c:RegisterEffect(e5)
	--extra summon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(LOCATION_HAND+LOCATION_MZONE,LOCATION_HAND+LOCATION_MZONE)
	e6:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e6:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PSYCHO))
	e6:SetValue(c95000063.esop)
	c:RegisterEffect(e6)
	--lpcost replace
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(85668449,0))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EFFECT_LPCOST_REPLACE)
	e7:SetCondition(c95000063.lrcon)
	e7:SetOperation(c95000063.lrop)
	c:RegisterEffect(e7)
	--damage
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_LEAVE_FIELD_P)
	e8:SetOperation(c95000063.damp)
	c:RegisterEffect(e8)
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_LEAVE_FIELD)
	e9:SetOperation(c95000063.damop)
	e9:SetLabelObject(e8)
	c:RegisterEffect(e9)
	--cannot change zone
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_SINGLE)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	eb:SetRange(LOCATION_SZONE)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)	
	
	
end
function c95000063.ctcon2(e,re)
	return re:GetHandler()~=e:GetHandler()
end
function c95000063.aclimit2(e,c)
	return c:IsType(TYPE_FIELD)
end
function c95000063.tgn(e,c)
	return c==e:GetHandler()
end
function c95000063.op(e,tp,eg,ep,ev,re,r,rp,chk)
local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)	
	if tc==nil then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if tc2==nil then
			local token=Duel.CreateToken(tp,95000063,nil,nil,nil,nil,nil,nil)		
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_FIELD)
			token:RegisterEffect(e1)
			Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SpecialSummonComplete()
		end
	else
		local WIN_REASON_ACTION_FIELD=0x55
		Duel.Win(1-tp,WIN_REASON_ACTION_FIELD)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
-- Add Action Card
function c95000063.Acttarget(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.Hint(HINT_SELECTMSG,tp,564)
if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then
local g=Duel.GetDecktopGroup(tp,1)
local tc=g:GetFirst()
math.randomseed( tc:getcode() )
end
i = math.random(20)
ac=math.random(1,tableAction_size)
e:SetLabel(tableAction[ac])
end
function c95000063.operation(e,tp,eg,ep,ev,re,r,rp)
if Duel.SelectYesNo(1-tp,aux.Stringid(95000063,0)) then
local dc=Duel.TossDice(tp,1)
if dc==2 or dc==3 or dc==4 or dc==6 then
e:GetHandler():RegisterFlagEffect(95000063,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
if dc==1 or dc==2 then
if not Duel.IsExistingMatchingCard(c95000063.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		local token=Duel.CreateToken(tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_QUICKPLAY)
		token:RegisterEffect(e1)
		Duel.SendtoHand(token,nil,REASON_EFFECT)
		Duel.SpecialSummonComplete()	
end
end

if dc==5 or dc==6 then
 if not Duel.IsExistingMatchingCard(c95000063.cfilter,1-tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		local token=Duel.CreateToken(1-tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
		Duel.SpecialSummonStep(token,0,1-tp,1-tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_QUICKPLAY)
		token:RegisterEffect(e1)
		Duel.SendtoHand(token,1-tp,REASON_EFFECT)
		Duel.SpecialSummonComplete()
		end

end

else 
if not Duel.IsExistingMatchingCard(c95000063.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		local token=Duel.CreateToken(tp,e:GetLabel(),nil,nil,nil,nil,nil,nil)		
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(TYPE_SPELL+TYPE_QUICKPLAY)
		token:RegisterEffect(e1)
		Duel.SendtoHand(token,nil,REASON_EFFECT)
		Duel.SpecialSummonComplete()	
end
end
end

function c95000063.aclimit2(e,c)
	return c:IsType(TYPE_FIELD)
end
function c95000063.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c95000063.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) and e:GetHandler():GetFlagEffect(95000063)==0
	and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c95000063.cfilter(c)
	return c:IsSetCard(0xac1)
end
tableAction = {
95000044,
95000045,
95000046,
} 
tableAction_size=3


function c95000063.esop(e,c)
	e:GetHandler():AddCounter(0x3004,1)
end
function c95000063.lrcon(e,tp,eg,ep,ev,re,r,rp)
	if tp~=ep then return false end
	local lp=Duel.GetLP(ep)
	if lp<=ev then return false end
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsLocation(LOCATION_MZONE) and rc:IsRace(RACE_PSYCHO)
end
function c95000063.lrop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x3004,1)
end
function c95000063.damp(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetCounter(0x3004)
	e:SetLabel(ct)
end
function c95000063.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	if ct>0 then
		Duel.Damage(tp,ct*1000,REASON_EFFECT)
	end
end