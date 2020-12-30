function AkiS:QueryAttacking()
	local h = (time()-1545170400)/3600
	local n = math.modf(h/19)%6+1
	local l = h%19
	local a ={'祖达萨','提拉加德海峡','纳兹米尔','斯托颂谷底','沃顿','德鲁斯瓦' ,'祖达萨'}
	print(l<7 and string.format('正在入侵：%s(剩余%.1f小时)',a[n],7-l) or string.format('下次入侵：%s(%.1f小时后)',a[n+1],19-l))
end