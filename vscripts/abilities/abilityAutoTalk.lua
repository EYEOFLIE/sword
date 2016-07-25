function abilityAutoTalk(event)
	local caster = event.caster

  if GameRules:GetGameTime()>60 then
    caster:RemoveModifierByName("modifiers_autotalk")
    WorldPanels:CreateWorldPanelForAll(
    {layout = "file://{resources}/layout/custom_game/worldpanels/talkbox.xml",
      entity = caster,
      entityHeight = 290,
    })
  end
  	

end