
function IndependentHeroItem( hero,item )
	PrintTestLog("IndependentHeroItem!!")
	
	local item_kind=GetItemKind(item)
	local item_kind_group=GetItemKindGroup(item)
	if item_kind then
		PrintTestLog("item_kind:"..item_kind)
	end
	if item_kind_group then
		PrintTestLog("item_kind_group:"..item_kind_group)
	end
	PrintTestLog(item:GetName())
	PrintTestLog(hero:GetName())
	if item_kind then
		local item_kind_count=0
		for i=0,5 do
			local curr_item=hero:GetItemInSlot(i)
			if GetItemKindGroup(curr_item)==item_kind_group then
				item_kind_count=item_kind_count+1
			end
		end
		local remove_item=false
		if item_kind_group==1 and item_kind_count>1 then remove_item=true		--武器
		elseif item_kind_group==2 and item_kind_count>1 then remove_item=true	--鞋子
		elseif item_kind_group==3 and item_kind_count>1 then remove_item=true	--衣服
		elseif item_kind_group==4 and item_kind_count>1 then remove_item=true	--帽子
		elseif item_kind_group==5 and item_kind_count>2 then remove_item=true	--饰品/法宝
		end
		if remove_item then
			PrintTestLog("DropItemAtPosition!")
			PrintTestLog(item:GetName())
			hero:SetContextThink(DoUniqueString("OnItemGiftedThink"), 
				function ()
					hero:DropItemAtPositionImmediate(item,hero:GetOrigin())
					return nil
				end, 
			0.03)
			return true
		else
			return false
		end
	end
	------------------------------------------------------------------------
	item.Owner = hero
	
	return false
end

require('utils/common')
require('utils/CheckItemModifies')