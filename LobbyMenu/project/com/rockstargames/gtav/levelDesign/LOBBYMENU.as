class com.rockstargames.gtav.levelDesign.LOBBYMENU extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var LobbyMenu;
	static var MouseEnabled = true;
	function LOBBYMENU()
	{
		super();
		_global.gfxExtensions = true;
	}

	function INITIALISE(mc)
	{
		super.INITIALISE(mc);
		this.CONTENT._alpha = 0;
	}

	function CREATE_MENU(left, center, right)
	{
		this.CONTENT._alpha = 0;
		this.LobbyMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT, left, center, right);
	}

	function SET_PANELS_ORDER(left, center, right)
	{
		this.LobbyMenu.SetPanelsOrder(left,center,right);
	}

	function FADE_OUT()
	{
		this.LobbyMenu.fadeOutLobby();
	}

	function FADE_IN()
	{
		this.LobbyMenu.fadeInLobby();
	}

	function ADD_LEFT_ITEM(id, str, sub, enabled, blink, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.LobbyMenu.AddLeftItem(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYER_ITEM(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.LobbyMenu.AddCenterItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_MISSION_PANEL_ITEM(itemType, textLeft, textRight, param3, param4, param5, param6)
	{
		this.LobbyMenu.AddMissionPanelItem(itemType,textLeft,textRight,param3,param4,param5,param6);
	}

	function REMOVE_MISSION_PANEL_ITEM(id)
	{
		this.LobbyMenu.RemoveMissionPanelItem(id);
	}

	function ADD_MISSION_PANEL_PICTURE(txd, txn)
	{
		this.LobbyMenu.SetPanelPicture(txd,txn);
	}

	function SET_MISSION_PANEL_TITLE(title)
	{
		this.LobbyMenu.SetMissionPanelTitle(title);
	}

	function SET_PLAYER_ITEM_LABEL(item, label)
	{
		this.LobbyMenu.playersColumn.ItemList[item].Label = label;
	}

	function SET_PLAYER_ITEM_COLOUR(item, colour, colorurTag)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setColour(colour,colorurTag);
	}

	function SET_PLAYER_ITEM_RANK(item, rank)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setRank(rank);
	}

	function SET_PLAYER_ITEM_CREW(item, crew)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setCrew(crew);
	}

	function SET_PLAYER_ITEM_STATUS(item, status, statusColor)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setStatus(status,statusColor);
	}

	function SET_PLAYER_ITEM_ICON_LEFT(item, icon, isCustom)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setIconLeft(icon,isCustom);
	}

	function SET_PLAYER_ITEM_ICON_RIGHT(item, icon, isCustom)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setIconRight(icon,isCustom);
	}

	//item, id, title, subtitle, titleColor, rankNum, bool1, bool2, bool3, bool4, _icon, param9, param10, param11, param12, param13
	function SET_PLAYER_ITEM_PANEL()
	{
		this.LobbyMenu.playersColumn.ItemList[arguments[0]].addPanel(arguments.slice(1));
		this.LobbyMenu.playersColumn.updateItemsDrawing();
	}

	function SET_PLAYER_ITEM_PANEL_STAT()
	{
		this.LobbyMenu.playersColumn.ItemList[arguments[0]].panel.AddStatItem(arguments.slice(1));
	}

	function SET_PLAYER_ITEM_PANEL_DESCRIPTION(item, desc, type, unused, collapse)
	{
		this.LobbyMenu.playersColumn.ItemList[item].panel.SET_DESCRIPTION(desc,type,unused,collapse);
	}

	function SET_SETTINGS_SELECTION(id)
	{
		this.LobbyMenu.settingsColumn.currentSelection = id;
	}
	function SET_PLAYERS_SELECTION(id)
	{
		this.LobbyMenu.playersColumn.currentSelection = id;
	}

	function SET_FOCUS(f)
	{
		this.LobbyMenu.Focus = f;
	}

	function SET_INPUT_EVENT(direction, time)
	{
		var retVal = -1;
		var _result = new Array();
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				this.LobbyMenu.GoUp(time);
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				this.LobbyMenu.GoDown(time);
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				retVal = this.LobbyMenu.GoLeft(time);
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				retVal = this.LobbyMenu.GoRight(time);
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.CROSS :
				var curItem = this.LobbyMenu.currentColumn.column.currentItem;
				if (this.LobbyMenu.currentColumn.type == "settings" && curItem._type == 2)
				{
					curItem.Checked = !curItem.Checked;
					com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				}
				break;
			case com.rockstargames.ui.game.GamePadConstants.CIRCLE :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"BACK","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
		}
		_result.push(this.LobbyMenu.Focus,this.LobbyMenu.currentColumn.column.currentSelection,retVal);
		return _result.toString();
	}


	/*
	
	function ADD_RIGHT_TITLE(tab, leftIndex, param1, param2, param3)
	{
	this.LobbyMenu.AddRightTitle(tab,leftIndex,param1,param2,param3);
	}
	
	function ADD_RIGHT_LIST_ITEM(tab, leftIndex, type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
	this.LobbyMenu.AddRightItem(tab,leftIndex,type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
	}
	
	function SET_RIGHT_SETTINGS_ITEM_VALUE(tab, leftIndex, itemIndex, value)
	{
	this.LobbyMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].Value = value;
	}
	
	function UPDATE_COLORED_BAR_COLOR(tab, leftIndex, itemIndex, hudColor)
	{
	this.LobbyMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].bar.updateColor(hudColor);
	}
	
	function UPDATE_RIGHT_ITEM_RIGHT_LABEL(tab, leftIndex, itemIndex, label)
	{
	com.rockstargames.ui.utils.UIText.setSizedText(this.LobbyMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].itemTextRight,label);
	}
	
	function UPDATE_RIGHT_STATS_ITEM(tab, leftIndex, itemIndex, label, rightLabel, hudColor)
	{
	this.LobbyMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].updateItem(label,rightLabel,hudColor);
	}
	
	function UPDATE_KEYMAP_ITEM(tab, leftIndex, itemIndex, value1, value2)
	{
	this.LobbyMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].UpdateValues(value1,value2);
	}
	
	function SET_INPUT_EVENT(direction)
	{
	var retVal = -1;
	var _result = new Array();
	var focus = this.LobbyMenu.Focus;
	var curTab = this.LobbyMenu.currentTab;
	switch (direction)
	{
	case com.rockstargames.ui.game.GamePadConstants.DPADUP :
	this.LobbyMenu.GoUp();
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
	this.LobbyMenu.GoDown();
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
	this.LobbyMenu.GoLeft();
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
	this.LobbyMenu.GoRight();
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	case com.rockstargames.ui.game.GamePadConstants.CROSS :
	var curItem = curTab.currentItem;
	var canIncrease = false;
	if (focus == 2)
	{
	if (curItem.currentItem._type == 4)
	{
	curItem.currentItem.Checked = !curItem.currentItem.Checked;
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	}
	}
	switch (curItem.itemType)
	{
	case 0 :
	case 1 :
	case 2 :
	canIncrease = false;
	break;
	case 3 :
	if (focus < 2)
	{
	canIncrease = true;
	}
	break;
	}
	if (focus == 0)
	{
	canIncrease = true;
	}
	if (canIncrease)
	{
	this.LobbyMenu.Focus++;
	}
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	case com.rockstargames.ui.game.GamePadConstants.CIRCLE :
	this.LobbyMenu.Focus--;
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"BACK","HUD_FRONTEND_DEFAULT_SOUNDSET");
	break;
	}
	
	focus = this.LobbyMenu.Focus;
	curTab = this.LobbyMenu.currentTab;
	
	
	switch (focus)
	{
	case 0 :
	_result.push(this.LobbyMenu.Index);
	_result.push(this.LobbyMenu.Focus);
	break;
	case 1 :
	_result.push(this.LobbyMenu.Index);
	_result.push(this.LobbyMenu.Focus);
	_result.push(curTab.currentSelection);
	break;
	case 2 :
	_result.push(this.LobbyMenu.Index);
	_result.push(this.LobbyMenu.Focus);
	_result.push(curTab.currentSelection);
	_result.push(curTab.currentItem.currentSelection);
	_result.push(curTab.currentItem.currentItem.Value);
	break;
	
	}
	
	return _result.toString();
	}
	
	
	function SET_SCROLL_EVENT(direction, isJoyPad)
	{
	// -1 up , 1 down
	var res = "";
	var focus = this.LobbyMenu.Focus;
	if (focus == 1)
	{
	var curTab = this.LobbyMenu.currentTab;
	var curItem = curTab.currentItem;
	if (!(curTab instanceof com.rockstargames.LobbyMenu.tabs.SimpleTab))
	{
	if (curItem.panelHovered || isJoyPad)
	{
	curItem.scrollAll(direction,true);
	res = "null";
	}
	else
	{
	res = this.SET_INPUT_EVENT((direction == -1) ? com.rockstargames.ui.game.GamePadConstants.DPADUP : com.rockstargames.ui.game.GamePadConstants.DPADDOWN);
	}
	}
	else if (curTab instanceof com.rockstargames.LobbyMenu.tabs.SimpleTab)
	{
	if (curTab.panelHovered || isJoyPad)
	{
	curTab.scrollAll(direction,true);
	res = "null";
	}
	}
	}
	else if (focus == 2)
	{
	res = this.SET_INPUT_EVENT((direction == -1) ? com.rockstargames.ui.game.GamePadConstants.DPADUP : com.rockstargames.ui.game.GamePadConstants.DPADDOWN);
	}
	return res;
	}
	
	function MOUSE_CLICK_EVENT()
	{
	var _result = [];
	var focus = this.LobbyMenu.Focus;
	var canIncrease = false;
	switch (focus)
	{
	case 0 :
	this.LobbyMenu.Focus++;
	break;
	case 1 :
	var curTab = this.LobbyMenu.currentTab;
	var _hoveredItem;
	if (curTab.currentItem.itemType == 3)
	{
	for (var j = 0; j < curTab.currentItem.ItemList.length; j++)
	{
	if (curTab.currentItem.ItemList[j]._hovered && !curTab.currentItem.ItemList[j]._highlighted)
	{
	curTab.currentItem.currentSelection = j;
	this.LobbyMenu.Focus++;
	break;
	}
	}
	}
	
	for (var i = 0; i < curTab.LeftItemList.length; i++)
	{
	if (curTab.LeftItemList[i].leftItem._hovered && !curTab.LeftItemList[i].Selected)
	{
	curTab.currentSelection = i;
	break;
	}
	}
	break;
	case 2 :
	var curTab = this.LobbyMenu.currentTab;
	var curItem = curTab.currentItem;
	
	for (var i = 0; i < curTab.LeftItemList.length; i++)
	{
	if (curTab.LeftItemList[i].leftItem._hovered && !curTab.LeftItemList[i].Selected)
	{
	this.LobbyMenu.Focus--;
	curTab.currentSelection = i;
	break;
	}
	}
	for (var i = 0; i < curItem.ItemList.length; i++)
	{
	if (curItem.ItemList[i]._hovered)
	{
	if (!curItem.ItemList[i]._highlighted)
	{
	curItem.currentSelection = i;
	}
	else
	{
	if (curItem.ItemList[i]._type == 4)
	{
	curItem.ItemList[i].Checked = !curItem.ItemList[i].Checked;
	}
	}
	}
	}
	break;
	}
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	
	switch (focus)
	{
	case 0 :
	_result.push(this.LobbyMenu.Index);
	_result.push(this.LobbyMenu.Focus);
	break;
	case 1 :
	_result.push(this.LobbyMenu.Index);
	_result.push(this.LobbyMenu.Focus);
	_result.push(this.LobbyMenu.currentTab.currentSelection);
	break;
	case 2 :
	_result.push(this.LobbyMenu.Index);
	_result.push(this.LobbyMenu.Focus);
	_result.push(this.LobbyMenu.currentTab.currentSelection);
	_result.push(this.LobbyMenu.currentTab.currentItem.currentSelection);
	_result.push(this.LobbyMenu.currentTab.currentItem.currentItem.Value);
	break;
	
	}
	return _result.toString();
	}
	    */

	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		if (success == true)
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd);
			}
		}
	}

	function TXD_HAS_LOADED(txd, success, strRef)
	{
		if (success == true)
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd, strRef)
	{
		var pMC = this.CONTENT;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}

	function CLEAR_ALL()
	{
		this.LobbyMenu.settingsColumn.Clear();
		this.LobbyMenu.playersColumn.Clear();
		this.LobbyMenu.missionDetails.Clear();
		this.LobbyMenu = undefined;
	}

	function debugData()
	{

	}
}