local DB = AkiS.DB

SLASH_AKIS1 = '/akis'
SLASH_AKIS2 = '/AKIS'
SlashCmdList['AKIS'] = function(msg)

    local command, rest = msg:lower():match('^(%S*)%s*(.-)$')

	if command=="setpet" then
		DB.petID = C_PetJournal.GetSummonedPetGUID()
		print('设置宠物：'..C_PetJournal.GetBattlePetLink(DB.petID))
		
	elseif command=="summonp" then
		local p = C_PetJournal.GetSummonedPetGUID()
		if p ~= DB.petID then
			C_PetJournal.SummonPetByGUID(DB.petID)
		end

	elseif command=="summonrp" then
		C_PetJournal.SummonRandomPet(true)

	elseif command=='ss' then
		AkiS:SendStats(rest)
	
	elseif command == 'adg' then
		AkiS:AnnounceDungeons(rest)
		
	elseif command == 'adgt' then
		AkiS:AnnounceTargetDungeons(rest)

	elseif command == 'showit' then
		print('私聊自动邀请密码：')
		for k, v in pairs(DB.inviteText) do
			print(k..'：'..v)
		end

	elseif command == 'addit' then
		table.insert(DB.inviteText, rest)
		print('新增私聊自动邀请密码：'..rest)

	elseif command == 'cfg' then
		InterfaceOptionsFrame_OpenToCategory('AkiTools_S')
		InterfaceOptionsFrame_OpenToCategory('AkiTools_S')

	else
		print('\124cFFFF0000------AkiTools------\n\124cFF00FF00cfg 打开设置菜单\nss 属性通报\nadg 史诗地下城经验通报\nadgt 目标史诗地下城经验通报')

	end
end