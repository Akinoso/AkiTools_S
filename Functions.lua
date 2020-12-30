local DB = AkiS.DB

-- 更新数据库
function AkiS:UpdateDB(dst, src)
	for k, v in pairs(src) do
		if type(v) == 'table' then
			if type(dst[k]) == 'table' then
				self:UpdateDB(dst[k], v)
			else
				dst[k] = self:UpdateDB({}, v)
			end
		elseif type(dst[k]) ~= 'table' then
			dst[k] = v
		end
	end
	return dst
end

-- 取整
function AkiS:Round(number, decimals)
    return (('%%.%df'):format(decimals)):format(number)
end

-- 通报
function AkiS:Announce(mode, msg, sound)
	if sound ~= '' then
		PlaySoundFile(sound, 'MASTER')
	end
	if mode == 'off' then
		return
	elseif mode == 'self' or mode == '' then
		print(msg)
		return
	elseif mode == 'instance' or mod == 'i' then
		mode = 'INSTANCE_CHAT'
	elseif mode == 's'then
		mode = 'say'
	elseif mode == 'g' then
		mode = 'guild'
	elseif mode == 'p' then
		mode = 'party'
	elseif mode == 'r' then
		mode = 'raid'
	elseif mode == 'y' then
		mode = 'yell'
	end
	SendChatMessage(msg, mode:upper())
end

-- 通报属性
function AkiS:SendStats(mode)
	local N = '['..UnitName('player')..']的属性通报：'
	local IL_C = {GetAverageItemLevel()}
	local IL = '物品等级'..string.format('%.1f', IL_C[2])
		
	local S_C = UnitStat('player',1)
	local AG_C = UnitStat('player',2)
	local IN_C = UnitStat('player',4)
	if S_C > AG_C and S_C > IN_C then
		S = ' 力量'..S_C
	elseif AG_C > S_C and AG_C > IN_C then
		S = ' 敏捷'..AG_C
	elseif IN_C > S_C and IN_C > AG_C then
		S = ' 智力'..IN_C
	end
		
	local A_C = {UnitArmor('player')}
	local A = ' 护甲'..A_C[2]
	local CC = ' 暴击'..AkiS:Round(GetCritChance(), 1)..'%'
	local H = ' 急速'..AkiS:Round(GetHaste(), 1)..'%'
	local M = ' 精通'..AkiS:Round(GetMasteryEffect(), 1)..'%'
	local V  = ' 全能'..AkiS:Round(GetCombatRatingBonus(29), 1)..'%'
	local LS  = ' 吸血'..AkiS:Round(GetCombatRatingBonus(17), 1)..'%'
	local DC = ' 躲闪'..AkiS:Round(GetDodgeChance(), 1)..'%'
	local PC = ' 招架'..AkiS:Round(GetParryChance(), 1)..'%'
	local BC = ' 格挡'..AkiS:Round(GetBlockChance(), 1)..'%'
	local AP = ' 成就'..GetTotalAchievementPoints()
	local END = ' 那可太强了！'
	local msg = N..IL..S..A..CC..H..M..V..LS..DC..PC..BC..AP..END
	AkiS:Announce(mode, msg, '')
end

-- 通报史诗地下城经验
function AkiS:AnnounceDungeons(mode)
	local a = GetStatistic(14389)	-- 彼界
	local b = GetStatistic(14392)	-- 大厅
	local c = GetStatistic(14395)	-- 仙林
	local d = GetStatistic(14398)	-- 凋魂
	local e = GetStatistic(14205)	-- 赤红
	local f = GetStatistic(14401)	-- 高塔
	local g = GetStatistic(14404)	-- 通灵
	local h = GetStatistic(14407)	-- 剧场
	local msg = '['..UnitName('player')..']的史诗地下城经验：彼界'..a..'次，赎罪大厅'..b..'次，塞兹仙林的迷雾'..c..'次，凋魂之殇'..d..'次，赤红深渊'..e..'次，晋升高塔'..f..'次，通灵战潮'..g..'次，伤逝剧场'..h..'次'
	AkiS:Announce(mode, msg, '')
end

-- 通报目标史诗地下城经验
function AkiS:AnnounceTargetDungeons(mode)
	if SetAchievementComparisonUnit('target') then
		local a = GetComparisonStatistic(14389)	-- 彼界
		local b = GetComparisonStatistic(14392)	-- 大厅
		local c = GetComparisonStatistic(14395)	-- 仙林
		local d = GetComparisonStatistic(14398)	-- 凋魂
		local e = GetComparisonStatistic(14205)	-- 赤红
		local f = GetComparisonStatistic(14401)	-- 高塔
		local g = GetComparisonStatistic(14404)	-- 通灵
		local h = GetComparisonStatistic(14407)	-- 剧场
		local msg = '['..UnitName('target')..']的史诗地下城经验：彼界'..a..'次，赎罪大厅'..b..'次，塞兹仙林的迷雾'..c..'次，凋魂之殇'..d..'次，赤红深渊'..e..'次，晋升高塔'..f..'次，通灵战潮'..g..'次，伤逝剧场'..h..'次'
		AkiS:Announce(mode, msg, '')
	end
	ClearAchievementComparisonUnit()
end