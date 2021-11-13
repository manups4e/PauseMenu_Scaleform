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
		var tab;
		switch (tabType)
		{
			case 0 :
				tab = new com.rockstargames.PauseMenu.tabs.SimpleTab(this.CONTENT, this.Tabs.length);
				break;
			case 1 :
				tab = new com.rockstargames.PauseMenu.tabs.InfoTab(this.CONTENT, this.Tabs.length);
				break;
		}
		this.Tabs.push(tab);
		this.updateTabsDrawing();
	}

	function AddLeftItem(tab, type, str, param1, param2, param3, param4)
	{
		var tab = this.Tabs[tab];
		if (!(tab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab))
		{
			tab.AddLeftItemToList(str,type,param1,param2,param3,param4);
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
					curTab.currentSelection--;
				}
				break;
			case 2 :
				if (curTab.currentItem.itemType == 3)
				{
					if (focus == 2)
					{
						curTab.currentItem.currentSelection--;
					}
				}
				break;
		}
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
					curTab.currentSelection++;
				}
				break;
			case 2 :
				if (curTab.currentItem.itemType == 3)
				{
					if (focus == 2)
					{
						curTab.currentItem.currentSelection++;
					}
				}
				break;
		}
	}

	function GoLeft()
	{
		var focus = this.Focus;
		var curTab = this.currentTab;
		switch (focus)
		{
			case 0 :
				this.Index--;
				break;
			case 2 :
				var curItem = curTab.currentItem;
				if (curItem.currentItem instanceof com.rockstargames.PauseMenu.items.SettingsTabItem)
				{
					switch (curItem.currentItem._type)
					{
						case 1 :
							curItem.currentItem.textIndex--;
							break;
						case 2 :
						case 3 :
							curItem.currentItem.barscale--;
							break;
						case 5 :
							curItem.currentItem.sliderscale--;
							break;
					}
				}
				break;
		}
	}

	function GoRight()
	{
		var focus = this.Focus;
		var curTab = this.currentTab;
		switch (focus)
		{
			case 0 :
				this.Index++;
			case 2 :
				var curItem = curTab.currentItem;
				if (curItem.currentItem instanceof com.rockstargames.PauseMenu.items.SettingsTabItem)
				{
					switch (curItem.currentItem._type)
					{
						case 1 :
							curItem.currentItem.textIndex++;
							break;
						case 2 :
						case 3 :
							curItem.currentItem.barscale++;
							break;
						case 5 :
							curItem.currentItem.sliderscale++;
							break;
					}
				}
				break;
		}
	}

	function set Index(_i)
	{
		this._tabIndex = _i;
		// DA SOSTITUIRE COL CODICE VIA SCRIPT (GESTIRA INDEX VIA SCRIPT)
		if (this._tabIndex > this.Tabs.length - 1)
		{
			this._tabIndex -= this.Tabs.length;
		}
		else if (this._tabIndex < 0)
		{
			this._tabIndex += this.Tabs.length;
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
	}

	function get Focus()
	{
		return this._focusLevel;
	}

	function get currentTab()
	{
		return this.Tabs[this.Index];
	}
}