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

	function CREATE_MENU(left,center,right)
	{
		this.CONTENT._alpha = 0;
		this.LobbyMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT,left,center,right);
	}

	function SET_PANELS_ORDER(left,center,right)
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

	function ADD_LEFT_ITEM(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13)
	{
		this.LobbyMenu.AddSetting(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYER_ITEM(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13)
	{
		this.LobbyMenu.AddPlayerItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}
	function REMOVE_PLAYER_ITEM(id)
	{
		this.LobbyMenu.playersColumn.RemoveItem(id);
	}

	/* to be implemented
	function UPDATE_SETTINGS_ITEM_LABEL_FONT(item, fontName, fontId)
	{
		this.LobbyMenu.settingsColumn.ItemList[item].updateFont(fontName, fontId);
	}
	*/

	function UPDATE_SETTINGS_ITEM_LABELS(item, lbl, rtxt)
	{
		if (this.LobbyMenu.settingsColumn.ItemList[item]._type == 0)
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.LobbyMenu.settingsColumn.ItemList[item].leftTextTF,lbl,true,true);
			this.LobbyMenu.settingsColumn.ItemList[item].SetRightText(rtxt);
		}
	}
	
	function UPDATE_SETTINGS_ITEM_BLINK_DESC(item, blink)
	{
		this.LobbyMenu.settingsColumn.ItemList[item].blinkDesc = blink;
	}

	function UPDATE_SETTINGS_ITEM_LABEL(item, txt)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.LobbyMenu.settingsColumn.ItemList[item].leftTextTF,txt,true,true);
	}

	function UPDATE_SETTINGS_ITEM_LABEL_RIGHT(item,_label)
	{
		this.LobbyMenu.settingsColumn.ItemList[item].SetRightText(_label);
	}

	function SET_SETTINGS_ITEM_LEFT_BADGE(item,badge)
	{
		this.LobbyMenu.settingsColumn.ItemList[item].SetLeftBadge(badge);
	}

	function SET_SETTINGS_ITEM_RIGHT_BADGE(item,badge)
	{
		this.LobbyMenu.settingsColumn.ItemList[item].SetRightBadge(badge);
	}

	function ENABLE_SETTINGS_ITEM(item,disable)
	{
		this.LobbyMenu.settingsColumn.ItemList[item].Enabled = disable;
	}

	function ADD_MISSION_PANEL_ITEM(itemType,textLeft,textRight,param3,param4,param5,param6)
	{
		this.LobbyMenu.AddMissionPanelItem(itemType,textLeft,textRight,param3,param4,param5,param6);
	}

	function REMOVE_MISSION_PANEL_ITEM(id)
	{
		this.LobbyMenu.RemoveMissionPanelItem(id);
	}

	function ADD_MISSION_PANEL_PICTURE(txd,txn)
	{
		this.LobbyMenu.SetPanelPicture(txd,txn);
	}

	function SET_MISSION_PANEL_TITLE(title)
	{
		this.LobbyMenu.SetMissionPanelTitle(title);
	}

	function SET_PLAYER_ITEM_LABEL(item,label)
	{
		this.LobbyMenu.playersColumn.ItemList[item].Label = label;
	}

	function SET_PLAYER_ITEM_COLOUR(item,colour,colorurTag)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setColour(colour,colorurTag);
	}

	function SET_PLAYER_ITEM_RANK(item,rank)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setRank(rank);
	}

	function SET_PLAYER_ITEM_CREW(item,crew)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setCrew(crew);
	}

	function SET_PLAYER_ITEM_STATUS(item,status,statusColor)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setStatus(status,statusColor);
	}

	function SET_PLAYER_ITEM_ICON_LEFT(item,icon,isCustom)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setIconLeft(icon,isCustom);
	}

	function SET_PLAYER_ITEM_ICON_RIGHT(item,icon,isCustom)
	{
		this.LobbyMenu.playersColumn.ItemList[item].setIconRight(icon,isCustom);
	}

	// too many arguments to write.. using arguments[] array;
	//item, id, title, subtitle, titleColor, rankNum, bool1, bool2, bool3, bool4, _icon, param9, param10, param11, param12, param13
	function SET_PLAYER_ITEM_PANEL()
	{
		this.LobbyMenu.playersColumn.ItemList[arguments[0]].addPanel(arguments.slice(1));
		this.LobbyMenu.playersColumn.updateItemsDrawing();
	}

	// too many arguments to write.. using arguments[] array;
	function SET_PLAYER_ITEM_PANEL_STAT()
	{
		this.LobbyMenu.playersColumn.ItemList[arguments[0]].panel.AddStatItem(arguments.slice(1));
	}

	function SET_PLAYER_ITEM_PANEL_DESCRIPTION(item,desc,type,unused,collapse)
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

	function SET_INPUT_EVENT(direction,time)
	{
		var retVal = -1;
		var _result = new Array  ;
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
					curItem.Checked = ! curItem.Checked;
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
		this.LobbyMenu.settingsColumn.Clear();
		this.LobbyMenu.playersColumn.Clear();
		this.LobbyMenu.missionDetails.Clear();
		this.LobbyMenu = undefined;
	}

	function debugData()
	{

	}
}