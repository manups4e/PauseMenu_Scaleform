class com.rockstargames.PauseMenu.TabView
{
	var CONTENT;
	var Tabs;
	var _focusLevel = 0;
	var _tabIndex = 0;
	static var FOCUS_LEVEL = 0;
	function TabView(mc)
	{
		this.CONTENT = mc;
		this.Tabs = new Array();
	}

	function setTabIndex(idx, Lidx, RIdx)
	{
		if (this.Tabs.length > 0)
		{
			this._tabIndex = idx;
			for (var tab in this.Tabs)
			{
				this.Tabs[tab].isVisible = (tab == this._tabIndex);
				if (this.Tabs[tab].isVisible)
				{
					if (Lidx != undefined)
					{
						this.Tabs[tab].currentSelection = Lidx;
					}
					else
					{
						this.Tabs[tab].currentSelection = 0;
					}
				}
			}
		}
		this.updateTabsDrawing();
	}

	function AddTab(tabType)
	{
		if (this.CONTENT.mouseCatcher)
		{
			this.CONTENT.mouseCatcher.dispose();
			this.CONTENT.mouseCatcher.removeMovieClip();
		}
		var tab;
		switch (tabType)
		{
			case 0 :
				tab = new com.rockstargames.PauseMenu.tabs.SimpleTab(this.CONTENT, this.Tabs.length);
				break;
			case 1 :
				tab = new com.rockstargames.PauseMenu.tabs.InfoTab(this.CONTENT, this.Tabs.length);
				break;
			case 2 :
				tab = new com.rockstargames.PauseMenu.tabs.PlayerListTab(this.CONTENT, this.Tabs.length);
				break;
		}
		this.Tabs.push(tab);
		this.updateTabsDrawing();
		if (this._focusLevel == 0)
		{
			if (!this.CONTENT.mouseCatcher)
			{
				this.CONTENT.attachMovie("mouseCatcher","mouseCatcher",this.CONTENT.getNextHighestDepth(),{_width:this.CONTENT._width, _height:this.CONTENT._height});
				this.CONTENT.mouseCatcher.setupGenericMouseInterface(-1,0,this.onMouseEvent,[this]);
			}
		}
	}

	function AddLeftItem(tab, type, str, enabled, param1, param2, param3, param4)
	{
		var tab = this.Tabs[tab];
		if (!(tab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab))
		{
			tab.AddLeftItemToList(str,type,enabled,param1,param2,param3,param4);
		}
		this.updateTabsDrawing();
	}

	function AddRightTitle(tab, leftIndex, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var tab = this.Tabs[tab];
		if (tab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab)
		{
			tab.AddTitle(-1,param1);
		}
		else
		{
			tab.AddTitle(leftIndex,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
		}
		this.updateTabsDrawing();
	}
	function AddRightItem(tab, leftIndex, type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var tab = this.Tabs[tab];
		if (tab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab)
		{
			tab.AddItem(-1,type,param1,param2,param3,param4);
		}
		else
		{
			tab.AddItem(leftIndex,type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
		}
		this.updateTabsDrawing();
	}

	function updateTabsDrawing()
	{
		for (var t in this.Tabs)
		{
			this.Tabs[t].isVisible = (t == this._tabIndex);
			this.Tabs[t].focused = this.Focus == 0 ? false : true;
		}
	}

	function GoUp()
	{
		var focus = this.Focus;
		var curTab = this.currentTab;
		switch (focus)
		{
			case 1 :
				if (!(curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab))
				{
					if (curTab instanceof com.rockstargames.PauseMenu.tabs.PlayerListTab)
					{
						return curTab.GoUp(150);
					}
					else
					{
						curTab.currentSelection--;
						while (!curTab.currentItem.Enabled)
						{
							curTab.currentSelection--;
						}
						return curTab.currentSelection;
					}
				}
				break;
			case 2 :
				if (curTab.currentItem.itemType == 3)
				{
					if (focus == 2)
					{
						curTab.currentItem.currentSelection--;
						while (!curTab.currentItem.currentItem.Enabled)
						{
							curTab.currentItem.currentSelection--;
						}
						return curTab.currentItem.currentSelection;
					}
				}
				break;
		}
		return -1;
	}

	function GoDown()
	{
		var focus = this.Focus;
		var curTab = this.currentTab;
		switch (focus)
		{
			case 1 :
				if (!(curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab))
				{
					if (curTab instanceof com.rockstargames.PauseMenu.tabs.PlayerListTab)
					{
						return curTab.GoDown(150);
					}
					else
					{
						curTab.currentSelection++;
						while (!curTab.currentItem.Enabled)
						{
							curTab.currentSelection++;
						}
						return curTab.currentSelection;
					}
				}
				break;
			case 2 :
				if (curTab.currentItem.itemType == 3)
				{
					if (focus == 2)
					{
						curTab.currentItem.currentSelection++;
						while (!curTab.currentItem.currentItem.Enabled)
						{
							curTab.currentItem.currentSelection++;
						}

						return curTab.currentItem.currentSelection;
					}
				}
				break;
		}
		return -1;
	}

	function GoLeft()
	{
		var focus = this.Focus;
		var curTab = this.currentTab;
		var val = 0;
		switch (focus)
		{
			case 0 :
				this.Index = this.Index - 1;
				val = this.Index;
				break;
			case 1 :
				if (curTab instanceof com.rockstargames.PauseMenu.tabs.PlayerListTab)
				{
					return curTab.GoLeft(150);
				}
				break;
			case 2 :
				var curItem = curTab.currentItem;
				if (curItem.currentItem instanceof com.rockstargames.PauseMenu.items.SettingsTabItem)
				{
					switch (curItem.currentItem._type)
					{
						case 1 :
							curItem.currentItem.textIndex--;
							val = curItem.currentItem.textIndex;
							break;
						case 2 :
						case 3 :
							curItem.currentItem.barscale--;
							val = curItem.currentItem.barscale;
							break;
						case 5 :
							curItem.currentItem.sliderscale--;
							val = curItem.currentItem.sliderscale;
							break;
					}
				}
				break;
		}
		return val;
	}

	function GoRight()
	{
		var focus = this.Focus;
		var curTab = this.currentTab;
		var val = 0;
		switch (focus)
		{
			case 0 :
				this.Index = this.Index + 1;
				val = this.Index;
			case 1 :
				if (curTab instanceof com.rockstargames.PauseMenu.tabs.PlayerListTab)
				{
					return curTab.GoRight(150);
				}
				break;
			case 2 :
				var curItem = curTab.currentItem;
				if (curItem.currentItem instanceof com.rockstargames.PauseMenu.items.SettingsTabItem)
				{
					switch (curItem.currentItem._type)
					{
						case 1 :
							curItem.currentItem.textIndex++;
							val = curItem.currentItem.textIndex;
							break;
						case 2 :
						case 3 :
							curItem.currentItem.barscale++;
							val = curItem.currentItem.barscale;
							break;
						case 5 :
							curItem.currentItem.sliderscale++;
							val = curItem.currentItem.sliderscale;
							break;
					}
				}
				break;
		}
		return val;
	}

	function set Index(_i)
	{
		this._tabIndex = _i;
		if (this._tabIndex > this.Tabs.length - 1)
		{
			this._tabIndex = 0;
		}
		else if (this._tabIndex < 0)
		{
			this._tabIndex = this.Tabs.length - 1;
		}
		this.updateTabsDrawing();
	}

	function get Index()
	{
		return this._tabIndex;
	}

	function set Focus(_f)
	{
		this._focusLevel = _f;
		com.rockstargames.PauseMenu.TabView.FOCUS_LEVEL = _f;
		if (this._focusLevel < 0)
		{
			this._focusLevel = 0;
		}
		this.currentTab.focused = this._focusLevel == 0 ? false : true;
		if (this._focusLevel == 0)
		{
			if (!this.CONTENT.mouseCatcher)
			{
				this.CONTENT.attachMovie("mouseCatcher","mouseCatcher",this.CONTENT.getNextHighestDepth(),{_width:this.CONTENT._width, _height:this.CONTENT._height});
				this.CONTENT.mouseCatcher.setupGenericMouseInterface(-1,0,this.onMouseEvent,[this]);
			}
		}
		else
		{
			if (this.CONTENT.mouseCatcher)
			{
				this.CONTENT.mouseCatcher.dispose();
				this.CONTENT.mouseCatcher.removeMovieClip();
			}
		}
	}

	function get Focus()
	{
		return this._focusLevel;
	}

	function get currentTab()
	{
		return this.Tabs[this.Index];
	}

	function onMouseEvent(evtType, targetMC, args)
	{
		var tabView = args[0];

		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				break;
		}
	}
}