class com.rockstargames.gtav.levelDesign.PAUSEMENU extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var PauseMenu;

	function PAUSEMENU()
	{
		super();
		_global.gfxExtensions = true;
	}

	function INITIALISE(mc)
	{
		super.INITIALISE(mc);
		//this.getDisplayConfig(true);
		this.PauseMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT);
	}

	function ADD_TAB(type)
	{
		this.PauseMenu.AddTab(type);
	}

	function SET_TAB_INDEX(val, Lval)
	{
		this.PauseMenu.setTabIndex(val,Lval);
	}

	function ADD_LEFT_ITEM(tab, type, str, param1, param2, param3, param4)
	{
		this.PauseMenu.AddLeftItem(tab,type,str,param1,param2,param3,param4);
	}

	function ADD_RIGHT_TITLE(tab, leftIndex, param1)
	{
		this.PauseMenu.AddRightTitle(tab,leftIndex,param1);
	}

	function ADD_RIGHT_LIST_ITEM(tab, leftIndex, type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		this.PauseMenu.AddRightItem(tab,leftIndex,type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
	}

	function SET_RIGHT_SETTINGS_ITEM_VALUE(tab, leftIndex, itemIndex, value)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].Value = value;
	}

	function UPDATE_COLORED_BAR_COLOR(tab, leftIndex, itemIndex, hudColor)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].bar.updateColor(hudColor);
	}

	function UPDATE_RIGHT_ITEM_RIGHT_LABEL(tab, leftIndex, itemIndex, label)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].itemTextRight,label);
	}

	function UPDATE_RIGHT_STATS_ITEM(tab, leftIndex, itemIndex, label, rightLabel, hudColor)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].updateItem(label,rightLabel,hudColor);
	}

	function SET_INPUT_EVENT(direction)
	{
		var retVal = -1;
		var _result = new Array();
		var focus = this.PauseMenu.Focus;
		var curTab = this.PauseMenu.currentTab;
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				this.PauseMenu.GoUp();
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				this.PauseMenu.GoDown();
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				this.PauseMenu.GoLeft();
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				this.PauseMenu.GoRight();
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
					this.PauseMenu.Focus++;
				}
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.CIRCLE :
				this.PauseMenu.Focus--;
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"BACK","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
		}

		focus = this.PauseMenu.Focus;
		curTab = this.PauseMenu.currentTab;


		switch (focus)
		{
			case 0 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				break;
			case 1 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				_result.push(curTab.currentSelection);
				break;
			case 2 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				_result.push(curTab.currentSelection);
				_result.push(curTab.currentItem.currentSelection);
				_result.push(curTab.currentItem.currentItem.Value);
				break;

		}
		/*
		this.PauseMenu.Index,
		this.PauseMenu.Focus,
		curTab.currentSelection,
		curTab.currentItem.currentSelection,
		curTab.currentItem.currentItem.Value
		*/
		return _result.toString();
	}


	function SET_SCROLL_EVENT(direction, isJoyPad)
	{
		// -1 up , 1 down
		var res = "";
		var focus = this.PauseMenu.Focus;
		if (focus == 1)
		{
			var curTab = this.PauseMenu.currentTab;
			var curItem = curTab.currentItem;
			if (!(curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab))
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
			else if (curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab)
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
		var focus = this.PauseMenu.Focus;
		var canIncrease = false;
		switch (focus)
		{
			case 0 :
				this.PauseMenu.Focus++;
				break;
			case 1 :
				var curTab = this.PauseMenu.currentTab;
				var _hoveredItem;
				if (curTab.currentItem.itemType == 3)
				{
					for (var j = 0; j < curTab.currentItem.ItemList.length; j++)
					{
						if (curTab.currentItem.ItemList[j]._hovered && !curTab.currentItem.ItemList[j]._highlighted)
						{
							curTab.currentItem.currentSelection = j;
							this.PauseMenu.Focus++;
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
				var curTab = this.PauseMenu.currentTab;
				var curItem = curTab.currentItem;

				for (var i = 0; i < curTab.LeftItemList.length; i++)
				{
					if (curTab.LeftItemList[i].leftItem._hovered && !curTab.LeftItemList[i].Selected)
					{
						this.PauseMenu.Focus--;
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
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				break;
			case 1 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				_result.push(this.PauseMenu.currentTab.currentSelection);
				break;
			case 2 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				_result.push(this.PauseMenu.currentTab.currentSelection);
				_result.push(this.PauseMenu.currentTab.currentItem.currentSelection);
				_result.push(this.PauseMenu.currentTab.currentItem.currentItem.Value);
				break;

		}
		return _result.toString();
	}

	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		if (success == true)
		{
			var pMC = this.CONTENT.headerMC;
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
			var pMC = this.CONTENT.headerMC;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd, strRef)
	{
		var pMC = this.CONTENT.headerMC;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}

	function CLEAR_ALL()
	{
		for (var it in this.PauseMenu.Tabs)
		{
			var tab = this.PauseMenu.Tabs[it];
			if (tab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab)
			{
				for (var ii in tab.ItemList)
				{
					tab.ItemList[ii].itemMC.removeMovieClip();
				}
				tab._title.itemMC.removeMovieClip();
				tab.rightItemUpMC.removeMovieClip();
			}
			for (var li in tab.LeftItemList)
			{
				var item = tab.LeftItemList[li];
				for (var ii in item.ItemList)
				{
					item.ItemList[ii].itemMC.removeMovieClip();
				}
				item._title.itemMC.removeMovieClip();
				item.leftItem.itemMC.removeMovieClip();
				item.rightMenuUp.removeMovieClip();
				item.footerMC.removeMovieClip();
			}
			this.PauseMenu.Tabs[it].itemMC.removeMovieClip();
		}
		this.PauseMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT);
	}
	/*
	function CREATE_MENU(title, subtitle, txd, txn)
	{
	this.UIMenu = new com.rockstargames.NativeUI.UIMenu(this.CONTENT, title, subtitle, txd, txn);
	}
	
	function CLEAR_ALL()
	{
	this.UIMenu.Clear();
	this.UIMenu = undefined;
	}
	
	function ADD_ITEM(id, str, sub, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11)
	{
	this.UIMenu.addItem(id,str,sub,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
	}
	
	function ADD_PANEL(item, panelType, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
	this.UIMenu.addPanel(item,panelType,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
	}
	
	function ADD_HERITAGE_WINDOW(mom, dad)
	{
	this.UIMenu.addWindow(mom,dad);
	}
	function UPDATE_HERITAGE_WINDOW(id, mom, dad)
	{
	this.UIMenu.windows[id].setIndex(mom,dad);
	}
	
	function SET_INPUT_EVENT(direction, item, val)
	{
	var retVal = 0;
	switch (direction)
	{
	case com.rockstargames.ui.game.GamePadConstants.CROSS :
	
	var _item = this.UIMenu.menuItems[item];
	if (_item instanceof com.rockstargames.NativeUI.items.UIMenuCheckboxItem)
	{
	_item.Checked = val;
	retVal = _item.Checked;
	}
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADUP :
	retVal = this.UIMenu.goUp();
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
	retVal = this.UIMenu.goDown();
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
	retVal = this.UIMenu.goLeft();
	break;
	case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
	retVal = this.UIMenu.goRight();
	break;
	}
	return retVal;
	}
	
	function SET_CURRENT_ITEM(item)
	{
	this.UIMenu.currentSelection = item;
	}
	
	function SET_INPUT_MOUSE_EVENT_SINGLE(posX, posY)
	{
	var retVal = new Array();
	var limit = this.UIMenu.itemCount - 1;
	var counter = 0;
	if (this.UIMenu.itemCount > this.UIMenu.maxItemsOnScreen + 1)
	{
	limit = this.UIMenu._maxItem;
	}
	
	for (var i = this.UIMenu._minItem; i <= limit; i++)
	{
	var item = this.UIMenu.menuItems[i];
	if (item._hovered)
	{
	if (!item.highlighted)
	{
	this.UIMenu.currentSelection = i;
	}
	var _type = 0;
	if (this.UIMenu.currentItem instanceof com.rockstargames.NativeUI.items.UIMenuListItem)
	{
	_type = 1;
	}
	else if (this.UIMenu.currentItem instanceof com.rockstargames.NativeUI.items.UIMenuCheckboxItem)
	{
	_type = 2;
	}
	else if (this.UIMenu.currentItem instanceof com.rockstargames.NativeUI.items.UIMenuSliderItem)
	{
	_type = 3;
	}
	else if (this.UIMenu.currentItem instanceof com.rockstargames.NativeUI.items.UIMenuProgressItem)
	{
	_type = 4;
	}
	retVal.push("it");
	retVal.push(this.UIMenu.currentSelection);
	retVal.push(_type);
	retVal.push(this.UIMenu.currentItem.Select(posX, posY));
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	return retVal.toString();
	}
	}
	
	if (this.UIMenu.currentItem.panels.length > 0)
	{
	for (var i = 0; i < this.UIMenu.currentItem.panels.length; i++)
	{
	var _panel = this.UIMenu.currentItem.panels[i];
	if (_panel._hovered)
	{
	if (_panel instanceof com.rockstargames.NativeUI.panels.UIMenuColorPanel)
	{
	retVal.push("pan");
	retVal.push(i);
	retVal.push(0);
	retVal.push(_panel.Value);
	com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
	return retVal.toString();
	}
	}
	}
	}
	}
	
	function SET_INPUT_MOUSE_EVENT_CONTINUE(posX, posY)
	{
	var retVal = new Array();
	var limit = this.UIMenu.itemCount - 1;
	var counter = 0;
	if (this.UIMenu.itemCount > this.UIMenu.maxItemsOnScreen + 1)
	{
	limit = this.UIMenu._maxItem;
	}
	
	for (var i = this.UIMenu._minItem; i <= limit; i++)
	{
	var item = this.UIMenu.menuItems[i];
	if (item._hovered)
	{
	var _type = 0;
	if (this.UIMenu.currentItem instanceof com.rockstargames.NativeUI.items.UIMenuSliderItem)
	{
	_type = 3;
	}
	else if (this.UIMenu.currentItem instanceof com.rockstargames.NativeUI.items.UIMenuProgressItem)
	{
	_type = 4;
	}
	if (_type == 3 || _type == 4)
	{
	retVal.push("it");
	retVal.push(this.UIMenu.currentSelection);
	retVal.push(_type);
	retVal.push(this.UIMenu.currentItem.Select(posX, posY));
	return retVal.toString();
	}
	}
	}
	
	if (this.UIMenu.currentItem.panels.length > 0)
	{
	for (var i = 0; i < this.UIMenu.currentItem.panels.length; i++)
	{
	var _panel = this.UIMenu.currentItem.panels[i];
	if (_panel._hovered)
	{
	var _panType = 0;
	if (_panel instanceof com.rockstargames.NativeUI.panels.UIMenuColorPanel)
	{
	_panType = 0;
	}
	else if (_panel instanceof com.rockstargames.NativeUI.panels.UIMenuPercentagePanel)
	{
	_panType = 1;
	_panel.Coords = posX;
	}
	else if (_panel instanceof com.rockstargames.NativeUI.panels.UIMenuGridPanel)
	{
	_panType = 2;
	_panel.Coords = new Array(posX, posY);
	}
	if (_panType == 1 || _panType == 2)
	{
	retVal.push("pan");
	retVal.push(i);
	retVal.push(_panType);
	retVal.push(_panel.Value);
	return retVal.toString();
	}
	}
	}
	}
	}
	
	function ADD_ITEM_TO_ITEMLIST(listItemId, item)
	{
	this.UIMenu.menuItems[listItemId].itemList.push(item);
	}
	
	function REMOVE_ITEM_FROM_ITEMLIST(item, idx)
	{
	this.UIMenu.menuItems[item].itemList.splice(idx,1);
	}
	
	function SET_RIGHT_BADGE(item, txd, icon)
	{
	this.UIMenu.menuItems[item].SetRightBadge(txd,icon);
	}
	
	function SET_ITEM_LABELS(item, lbl, rtxt)
	{
	com.rockstargames.ui.utils.UIText.setSizedText(this.UIMenu.menuItems[item].leftTextTF,lbl,true,true);
	this.UIMenu.menuItems[item].SetRightText(rtxt);
	}
	
	function SET_LEFT_LABEL(item, txt)
	{
	com.rockstargames.ui.utils.UIText.setSizedText(this.UIMenu.menuItems[item].leftTextTF,txt,true,true);
	}
	function SET_RIGHT_LABEL(item, txt)
	{
	this.UIMenu.menuItems[item].SetRightText(txt);
	}
	
	function GET_VALUE_FROM_PANEL(item, panel)
	{
	return this.UIMenu.menuItems[item].panels[panel].Value;
	}
	
	function ADD_STATISTIC_TO_PANEL(item, panel, _label, _value)
	{
	this.UIMenu.menuItems[item].panels[panel].addStat(_label,_value);
	}
	
	function SET_PANEL_STATS_ITEM_VALUE(item, panel, statId, _value)
	{
	this.UIMenu.menuItems[item].panels[panel].setStat(statId,_value);
	}
	
	function SET_COLOR_PANEL_RETURN_VALUE(item, panel)
	{
	// returns -1 if no selection is done
	return this.UIMenu.menuItems[item].panels[panel].Value;
	}
	function SET_COLOR_PANEL_VALUE(item, panel, val)
	{
	this.UIMenu.menuItems[item].panels[panel].Value = val;
	}
	
	function SET_PERCENT_PANEL_RETURN_VALUE(item, panel, val)
	{
	// set percentage and its value
	this.UIMenu.menuItems[item].panels[panel].Value = val;
	return this.UIMenu.menuItems[item].panels[panel].Value;
	}
	
	function SET_GRID_PANEL_POSITION_RETURN_VALUE(item, panel, posX, posY)
	{
	// returns grid position (x, y)
	this.UIMenu.menuItems[item].panels[panel].Coords = new Array(posX, posY);
	return this.UIMenu.menuItems[item].panels[panel].Value.toString();
	}
	function SET_GRID_PANEL_POSITION_RETURN_COORDS(item, panel, posX, posY)
	{
	// returns dot coordinates
	this.UIMenu.menuItems[item].panels[panel].Coords = new Array(posX, posY);
	return this.UIMenu.menuItems[item].panels[panel].Coords.toString();
	}
	function SET_GRID_PANEL_VALUE_RETURN_COORDS(item, panel, posX, posY)
	{
	// returns dot coordinates
	this.UIMenu.menuItems[item].panels[panel].Value = new Array(posX, posY);
	return this.UIMenu.menuItems[item].panels[panel].Coords.toString();
	}
	function SET_GRID_PANEL_VALUE_RETURN_VALUE(item, panel, posX, posY)
	{
	// returns dot coordinates
	this.UIMenu.menuItems[item].panels[panel].Value = new Array(posX, posY);
	return this.UIMenu.menuItems[item].panels[panel].Value.toString();
	}
	
	function SET_PERCENT_PANEL_POSITION_RETURN_VALUE(item, panel, posX)
	{
	// set percentage based on mouse and returns its value
	this.UIMenu.menuItems[item].panels[panel].Coords = posX;
	return this.UIMenu.menuItems[item].panels[panel].Value.toString();
	}
	*/
}