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
		return res;
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
}