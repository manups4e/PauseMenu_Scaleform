class com.rockstargames.PauseMenu.TabView
{
	var CONTENT;
	var Tabs;
	var _focusLevel;
	var Index;
	var Header;
	var totalMenuWidth = 868;
	var scrollingMenuWidth = 725;
	var menuItemWidth = 143;

	function TabView(mc)
	{
		this.CONTENT = mc;
		this.Header = new com.rockstargames.PauseMenu.header.Header(this.CONTENT);// y_:60...
		//this.Header.BuildMenu();
		this._focusLevel = 0;
		this.Index = 0;
	}

	function SetTitle(title, subtitle, isChallenge)
	{
		this.Header.SetHeaderTitle(title,subtitle,isChallenge);
	}

	function SetHeadingDetails(str1, str2, str3, isSinglePlayer)
	{
		this.Header.SetHeadingDetails(str1,str2,str3,isSinglePlayer);
	}

	function SetCharImg(txd, charTexturePath, show)
	{
		this.Header.SetCharImg(txd,charTexturePath,show);
		this.Header.ShowHeadingDetails(true);
	}

	function AddTab(title, dim)
	{
		this.Header.menubar.AddItem(title, dim);
	}
}