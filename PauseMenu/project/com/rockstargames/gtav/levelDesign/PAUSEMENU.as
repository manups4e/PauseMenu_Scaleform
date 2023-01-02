class com.rockstargames.gtav.levelDesign.PAUSEMENU extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var PauseMenu;
	static var MouseEnabled = true;
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

	function SET_FOCUS(foc)
	{
		this.PauseMenu.Focus = foc;
	}

	function SET_TAB_INDEX(val,Lval)
	{
		this.PauseMenu.setTabIndex(val,Lval);
	}

	function SELECT_LEFT_ITEM_INDEX(item)
	{
		this.PauseMenu.currentTab.currentSelection = item;
	}

	function SELECT_RIGHT_ITEM_INDEX(item)
	{
		if (this.PauseMenu.currentTab.currentItem.itemType == 3)
		{
			if (this.PauseMenu.Focus == 2)
			{
				this.PauseMenu.currentTab.currentItem.currentSelection = item;
			}
		}
	}

	function ADD_LEFT_ITEM(tab,type,str,enabled,param1,param2,param3,param4)
	{
		this.PauseMenu.AddLeftItem(tab,type,str,enabled,param1,param2,param3,param4);
	}

	function ADD_RIGHT_TITLE(tab,leftIndex,param1,param2,param3)
	{
		this.PauseMenu.AddRightTitle(tab,leftIndex,param1,param2,param3);
	}

	function ADD_RIGHT_LIST_ITEM(tab,leftIndex,type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10)
	{
		this.PauseMenu.AddRightItem(tab,leftIndex,type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
	}

	function SET_RIGHT_SETTINGS_ITEM_VALUE(tab,leftIndex,itemIndex,value)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].Value = value;
	}

	function UPDATE_COLORED_BAR_COLOR(tab,leftIndex,itemIndex,hudColor)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].bar.updateColor(hudColor);
	}

	function UPDATE_RIGHT_ITEM_RIGHT_LABEL(tab,leftIndex,itemIndex,label)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].itemTextRight,label);
	}

	function UPDATE_RIGHT_STATS_ITEM(tab,leftIndex,itemIndex,label,rightLabel,hudColor)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].updateItem(label,rightLabel,hudColor);
	}

	function UPDATE_KEYMAP_ITEM(tab,leftIndex,itemIndex,value1,value2)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[leftIndex].ItemList[itemIndex].UpdateValues(value1,value2);
	}

	function UPDATE_LEFT_ITEM_LABELS(tab,item,lbl,rtxt)
	{
		if (this.PauseMenu.Tabs[tab].LeftItemList[item]._type == 0)
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tabs[tab].LeftItemList[item].leftTextTF,lbl,true,true);
			this.PauseMenu.Tabs[tab].LeftItemList[item].SetRightText(rtxt);
		}
	}
	function UPDATE_LEFT_ITEM_LABEL(tab,item,_label)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[item].Label = _label;
	}

	function UPDATE_LEFT_ITEM_LABEL_RIGHT(tab,item,_label)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[item].SetRightText(_label);
	}

	function SET_LEFT_ITEM_LEFT_BADGE(tab,item,badge)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[item].SetLeftBadge(badge);
	}

	function UPDATE_LEFT_ITEM_TITLE(tab,item,txt,param1,param2)
	{
		this.PauseMenu.AddRightTitle(tab,item,txt,param1,param2);
	}

	function SET_LEFT_ITEM_RIGHT_BADGE(tab,item,badge)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[item].SetRightBadge(badge);
	}

	function ENABLE_LEFT_ITEM(tab,item,disable)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[item].Enabled = disable;
	}

	function ENABLE_RIGHT_ITEM(tab,litem,ritem,disable)
	{
		this.PauseMenu.Tabs[tab].LeftItemList[litem].ItemList[ritem].Enabled = disable;
	}

	function SET_INPUT_EVENT(direction)
	{
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
				return this.PauseMenu.GoUp();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
				return this.PauseMenu.GoDown();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				return this.PauseMenu.GoLeft();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				return this.PauseMenu.GoRight();
				break;
			case com.rockstargames.ui.game.GamePadConstants.CROSS :
				switch (this.PauseMenu.Focus)
				{
					case 1 :
						if (this.PauseMenu.currentTabinstanceofcom.rockstargames.PauseMenu.tabs.PlayerListTab)
						{
							switch (this.PauseMenu.currentTab.Focus)
							{
								case 1 :
									var curCol = this.PauseMenu.currentTab.currentColumn.column;
									if (curCol.currentItem._type == 2)
									{
										curCol.currentItem.Checked = ! curCol.currentItem.Checked;
									}
									break;
							}
						}
						break;
					case 2 :
						{
							var curItem = this.PauseMenu.currentTab.currentItem;
							if (curItem.currentItem._type == 4)
							{
								curItem.currentItem.Checked = ! curItem.currentItem.Checked;
								com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
							}

						};
						break;
				}
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
		}
	}

	function SET_SCROLL_EVENT(direction,isJoyPad)
	{
		// -1 up , 1 down
		var focus = this.PauseMenu.Focus;
		if ((focus == 1))
		{
			var curTab = this.PauseMenu.currentTab;
			var curItem = curTab.currentItem;
			if (! (curTabinstanceofcom.rockstargames.PauseMenu.tabs.SimpleTab))
			{
				if (curItem.panelHovered || isJoyPad)
				{
					curItem.scrollAll(direction,true);
				}
			}
			else if ((curTabinstanceofcom.rockstargames.PauseMenu.tabs.SimpleTab))
			{
				if (curTab.panelHovered || isJoyPad)
				{
					curTab.scrollAll(direction,true);
				}
			}
		}
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
						if (curTab.currentItem.ItemList[j]._hovered && ! curTab.currentItem.ItemList[j]._highlighted)
						{
							curTab.currentItem.currentSelection = j;
							this.PauseMenu.Focus++;
							break;
						}
					}
				}

				for (var i = 0; i < curTab.LeftItemList.length; i++)
				{
					if (curTab.LeftItemList[i].leftItem._hovered && ! curTab.LeftItemList[i].Selected)
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
					if (curTab.LeftItemList[i].leftItem._hovered && ! curTab.LeftItemList[i].Selected)
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
						if (! curItem.ItemList[i]._highlighted)
						{
							curItem.currentSelection = i;
						}
						else
						{
							if (curItem.ItemList[i]._type == 4)
							{
								curItem.ItemList[i].Checked = ! curItem.ItemList[i].Checked;
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


	function ADD_PLAYERS_TAB_SETTINGS_ITEM(tab,id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13)
	{
		this.PauseMenu.Tabs[tab].AddSettings(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYERS_TAB_PLAYER_ITEM(tab,id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13)
	{
		this.PauseMenu.Tabs[tab].AddPlayer(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function REMOVE_PLAYERS_TAB_PLAYER_ITEM(tab,id)
	{
		this.PauseMenu.Tabs[tab].RemovePlayer(id);
	}

	function SET_PLAYERS_TAB_SETTINGS_SELECTION(tab,id)
	{
		this.PauseMenu.Tabs[tab].settingsColumn.currentSelection = id;
	}
	function SET_PLAYERS_TAB_PLAYERS_SELECTION(tab,id)
	{
		this.PauseMenu.Tabs[tab].playersColumn.currentSelection = id;
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL()
	{
		this.PauseMenu.Tabs[arguments[0]].playersColumn.ItemList[arguments[1]].addPanel(arguments.slice(2));
		this.PauseMenu.Tabs[arguments[0]].playersColumn.updateItemsDrawing();
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL_STAT()
	{
		this.PauseMenu.Tabs[arguments[0]].playersColumn.ItemList[arguments[1]].panel.AddStatItem(arguments.slice(2));
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL_DESCRIPTION(tab,item,desc,type,unused,collapse)
	{
		this.PauseMenu.Tabs[tab].playersColumn.ItemList[item].panel.SET_DESCRIPTION(desc,type,unused,collapse);
	}

	function SET_PLAYERS_TAB_FOCUS(tab,focus)
	{
		this.PauseMenu.Tabs[tab].Focus = focus;
	}

	// inizia qui
	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_LABELS(tab,item,lbl,rtxt)
	{
		if (this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item]._type == 0)
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].leftTextTF,lbl,true,true);
			this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].SetRightText(rtxt);
		}
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_BLINK_DESC(tab,item,blink)
	{
		this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].blinkDesc = blink;
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_LABEL(tab,item,txt)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].leftTextTF,txt,true,true);
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_LABEL_RIGHT(tab,item,_label)
	{
		this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].SetRightText(_label);
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_LEFT_BADGE(tab,item,badge)
	{
		this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].SetLeftBadge(badge);
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_RIGHT_BADGE(tab,item,badge)
	{
		this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].SetRightBadge(badge);
	}

	function ENABLE_PLAYERS_TAB_SETTINGS_ITEM(tab,item,disable)
	{
		this.PauseMenu.Tabs[tab].settingsColumn.ItemList[item].Enabled = disable;
	}

	function ADD_TXD_REF_RESPONSE(txd,strRef,success)
	{
		if ((success == true))
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
			if ((pMC != undefined))
			{
				il.displayTxdResponse(txd);
			}
		}
	}

	function TXD_HAS_LOADED(txd,success,strRef)
	{
		if ((success == true))
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
			if ((pMC != undefined))
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd,strRef)
	{
		var pMC = this.CONTENT;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
		if ((pMC != undefined))
		{
			il.displayTxdResponse(txd,true);
		}
	}

	function CLEAR_ALL()
	{
		for (var it in this.PauseMenu.Tabs)
		{
			var tab = this.PauseMenu.Tabs[it];
			if ((tabinstanceofcom.rockstargames.PauseMenu.tabs.SimpleTab))
			{
				for (var ii in tab.ItemList)
				{
					tab.ItemList[ii].itemMC.removeMovieClip();
				}
				tab._title.itemMC.removeMovieClip();
				tab.rightItemUpMC.removeMovieClip();
			}
			else if ((tabinstanceofcom.rockstargames.PauseMenu.tabs.PlayerListTab))
			{
				tab.Clear();
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
		this.CONTENT.mouseCatcher.removeMovieClip();
		this.PauseMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT);
	}
}