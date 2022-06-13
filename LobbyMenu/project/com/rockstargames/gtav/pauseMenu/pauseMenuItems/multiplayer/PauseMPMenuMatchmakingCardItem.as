//Sprite 110
//  InitClip
dynamic class com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
    static var VEHICLE_ITEM: Number = 0;
    static var PLAYER_BET_ITEM: Number = 1;
    static var PLAYER_ITEM: Number = 2;
    var _isStandalone: Boolean = true;
    var txdCallbackDepth: Number = -1;
    var _highlighted;
    var attachMovie;
    var avatarImg;
    var betMC;
    var bgMC;
    var carIconBGMC;
    var colourIconL;
    var colourIconR;
    var colourStrokeMC;
    var crewTagMC;
    var eyeMC;
    var getNextHighestDepth;
    var groupBGMC;
    var groupNumTF;
    var hBGColour;
    var highlightBGMC;
    var hostMC;
    var icon1MC;
    var icon2MC;
    var icon3MC;
    var initialIndex;
    var isAnimating;
    var isSelectable;
    var kickAnim;
    var labelMC;
    var leftIconColour;
    var nonSelectAlpha;
    var oddsTF;
    var rankBGMC;
    var rankNumTF;
    var rankingTF;
    var rightIconColour;
    var scoreTF;
    var selectAlpha;
    var type;
    var uniqueID;

    function PauseMPMenuMatchmakingCardItem()
    {
        super();
        this.hBGColour = new com.rockstargames.ui.utils.HudColour();
        this.leftIconColour = new com.rockstargames.ui.utils.HudColour();
        this.rightIconColour = new com.rockstargames.ui.utils.HudColour();
        this.selectAlpha = 100;
        this.nonSelectAlpha = 30;
        this.kickAnim = 0;
        this.isAnimating = false;
        _global.gfxExtensions = true;
        this.labelMC.nameTF.textAutoSize = "shrink";
        this.rankNumTF.textAutoSize = "shrink";
        this.oddsTF.textAutoSize = "shrink";
    }

    function set data(_d)
    {
        super.__set__data(_d);
        var __reg6 = new com.rockstargames.ui.utils.HudColour();
        com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK, __reg6);
        com.rockstargames.ui.utils.Colour.Colourise(this.bgMC, __reg6.r, __reg6.g, __reg6.b, 50);
        if (this.__get__data()[0] == "") 
        {
            this.__get__data()[0] = "-";
        }
        this.labelMC.titleTF.text = this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.VEHICLE_ITEM ? this.__get__data()[0] : "";
        this.labelMC.nameTF.text = this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.VEHICLE_ITEM ? "" : this.__get__data()[0];
        this.groupBGMC._visible = false;
        this.groupNumTF._visible = false;
        this.colourIconL._visible = this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.VEHICLE_ITEM;
        this.colourIconR._visible = this.colourIconL._visible;
        this.colourStrokeMC._visible = false;
        this.eyeMC._visible = false;
        if (this.crewTagMC) 
        {
            this.crewTagMC._visible = false;
        }
        var __reg3 = this.__get__data()[1];
        if (__reg3 == undefined) 
        {
            __reg3 = 1;
        }
        if (__reg3 == 1 || __reg3 == 0) 
        {
            var __reg7 = Boolean(__reg3) ? com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLUE : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_RED;
            com.rockstargames.ui.utils.Colour.setHudColour(__reg7, this.hBGColour);
            com.rockstargames.ui.utils.Colour.ApplyHudColour(this.hostMC, __reg7);
        }
        else 
        {
            com.rockstargames.ui.utils.Colour.setHudColour(__reg3, this.hBGColour);
            com.rockstargames.ui.utils.Colour.ApplyHudColour(this.hostMC, __reg3);
        }
        var __reg5 = this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.PLAYER_BET_ITEM;
        this.setIcon(__reg5 ? 0 : this.__get__data()[2], this.icon1MC);
        this.betMC._visible = __reg5;
        this.setIcon(__reg5 ? 0 : this.__get__data()[3], this.icon2MC);
        this.oddsTF._visible = __reg5;
        if (!this.isAnimating) 
        {
            this.setIcon(this.__get__data()[4], this.icon3MC);
        }
        var __reg4 = false;
        com.rockstargames.ui.utils.Colour.ApplyHudColour(this.carIconBGMC, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
        if ((__reg0 = this.type) === com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.VEHICLE_ITEM) 
        {
            com.rockstargames.ui.utils.Colour.Colourise(this.colourIconL, this.__get__data()[5], this.__get__data()[6], this.__get__data()[7], 100);
            com.rockstargames.ui.utils.Colour.Colourise(this.colourIconR, this.__get__data()[8], this.__get__data()[9], this.__get__data()[10], 100);
            this.colourStrokeMC._alpha = 30;
            this.colourStrokeMC._visible = true;
            if (this.__get__data()[11]) 
            {
                if (isNaN(this.__get__data()[11])) 
                {
                    this.labelMC.titleTF.text = "";
                    this.labelMC.nameTF.text = this.__get__data()[11];
                    this.setCrewTag(this.__get__data()[12]);
                    this.formatNameTF();
                    if (this.__get__data()[0] > 0) 
                    {
                        this.setGroupedBG(this.__get__data()[0]);
                    }
                }
                else if (this.__get__data()[11] > 0) 
                {
                    this.setGroupedBG(this.__get__data()[11]);
                }
            }
            __reg4 = true;
        }
        else if (__reg0 === com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.PLAYER_BET_ITEM) 
        {
            if (this.__get__data()[2]) 
            {
                this.betMC.labelMC.itemTF.text = this.__get__data()[2];
                this.betMC.bgMC._width = this.betMC.labelMC.itemTF.textWidth + 10;
                this.betMC.bgMC._x = 145 - this.betMC.bgMC._width;
            }
            else 
            {
                this.betMC._visible = false;
            }
            if (this.__get__data()[3]) 
            {
                this.oddsTF.text = this.__get__data()[3];
            }
            else 
            {
                this.oddsTF._visible = false;
            }
            var __reg8 = Boolean(this.isSelectable);
            if (__reg8) 
            {
                this.betMC.bgMC._visible = true;
                com.rockstargames.ui.utils.Colour.ApplyHudColour(this.betMC.bgMC, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN);
            }
            else 
            {
                this.betMC.bgMC._visible = false;
            }
            com.rockstargames.ui.utils.Colour.ApplyHudColour(this.betMC.labelMC, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
            if (this.__get__data()[10]) 
            {
                this.eyeMC._visible = Boolean(this.__get__data()[10]);
            }
            if (this.__get__data()[9] > 0) 
            {
                this.setGroupedBG(this.__get__data()[9]);
            }
            if (isNaN(this.__get__data()[5])) 
            {
                this.setAvatarImg(this.__get__data()[5], this.__get__data()[6]);
                __reg4 = true;
            }
            else 
            {
                this.rankingTF.text = this.__get__data()[5];
                this.rankingTF._visible = this.__get__data()[5] >= 0;
                __reg4 = this.__get__data()[5] != -1;
                if (__reg4) 
                {
                    com.rockstargames.ui.utils.Colour.ApplyHudColour(this.carIconBGMC, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
                }
                this.scoreTF.text = this.__get__data()[6];
            }
            this.setCrewTag(this.__get__data()[7]);
            this.formatNameTF();
        }
        else if (__reg0 === com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuMatchmakingCardItem.PLAYER_ITEM) 
        {
            if (this.__get__data()[9] > 0) 
            {
                this.setGroupedBG(this.__get__data()[9]);
            }
            if (isNaN(this.__get__data()[5])) 
            {
                this.setAvatarImg(this.__get__data()[5], this.__get__data()[6]);
                __reg4 = true;
            }
            else 
            {
                this.rankingTF.text = this.__get__data()[5];
                this.rankingTF._visible = this.__get__data()[5] >= 0;
                __reg4 = this.__get__data()[5] != -1;
                if (__reg4) 
                {
                    com.rockstargames.ui.utils.Colour.ApplyHudColour(this.carIconBGMC, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
                }
                this.scoreTF.text = this.__get__data()[6];
            }
            this.setCrewTag(this.__get__data()[7]);
            this.formatNameTF();
        }
        this.rankNumTF.text = this.initialIndex;
        this.rankBGMC._visible = false;
        this.carIconBGMC._visible = __reg4;
        com.rockstargames.ui.utils.Colour.ApplyHudColour(this.labelMC, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
        this.__set__highlighted(this._highlighted);
    }

    function setGroupedBG(numMembers)
    {
        this.groupBGMC._visible = true;
        this.groupNumTF._visible = true;
        this.groupBGMC._height = 27 * numMembers - 2;
        this.groupNumTF.text = String(this.uniqueID);
        this.groupNumTF._y = this.groupBGMC._height * 0.5 - this.groupNumTF._height * 0.5;
    }

    function setIcon(iconEnum, iconMC)
    {
        if (iconEnum == undefined) 
        {
            iconEnum = 0;
        }
        var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(iconEnum)[1];
        iconMC.gotoAndStop(__reg2);
        if (__reg2 == "RANK_FREEMODE") 
        {
            com.rockstargames.gtav.utils.GTAVUIUtils.colourRankIcon(iconMC.rankMC);
        }
        if (iconMC.animIcon) 
        {
            iconMC.animIcon.play();
        }
    }

    function setAvatarImg(txd, txn)
    {
        if (txd != undefined && txn != undefined) 
        {
            if (txd != "" && txn != "") 
            {
                this.ADD_TXD_REF(txd, txn);
            }
        }
    }

    function setCrewTag(crewTagStr)
    {
        if (crewTagStr && crewTagStr != "") 
        {
            if (!this.crewTagMC) 
            {
                this.crewTagMC = this.attachMovie("CREW_TAG_MOVIECLIP", "crewTagMC", this.getNextHighestDepth(), {_y: 5, _xscale: 70, _yscale: 70});
            }
            this.crewTagMC.UNPACK_CREW_TAG(crewTagStr);
            this.crewTagMC._visible = true;
        }
    }

    function formatNameTF()
    {
        var __reg2 = 210 - (this.crewTagMC._visible ? this.crewTagMC._width : 0) - (this.betMC._visible ? this.betMC.bgMC._width : 0);
        this.labelMC.nameTF._width = __reg2;
        this.crewTagMC._x = this.labelMC._x + this.labelMC.nameTF._x + this.labelMC.nameTF.textWidth + 10;
    }

    function animateKick(doAnimate)
    {
        if (doAnimate) 
        {
            com.rockstargames.ui.tweenStar.TweenStarLite.delayCall(this.rankNumTF, 1, {onCompleteScope: this, onComplete: this.kickflip});
            this.isAnimating = true;
            return;
        }
        com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.rankNumTF);
        this.isAnimating = false;
    }

    function kickflip()
    {
        this.kickAnim < 1 ? this.kickAnim++ : (this.kickAnim = 0);
        if (this.kickAnim) 
        {
            this.icon3MC.gotoAndStop("KICK");
            this.icon3MC.numTF.text = this.__get__data()[8];
            this.rankNumTF._visible = false;
        }
        else 
        {
            this.icon3MC.gotoAndStop(this.__get__data()[3][2]);
            this.rankNumTF._visible = true;
        }
        this.animateKick(true);
    }

    function set highlighted(_h)
    {
        var __reg2 = _h ? this.selectAlpha : this.nonSelectAlpha;
        com.rockstargames.ui.utils.Colour.Colourise(this.highlightBGMC, this.hBGColour.r, this.hBGColour.g, this.hBGColour.b, __reg2);
        if (this.groupBGMC._visible) 
        {
            this.groupNumTF._alpha = __reg2 + 25;
            com.rockstargames.ui.utils.Colour.Colourise(this.groupBGMC, this.hBGColour.r, this.hBGColour.g, this.hBGColour.b, __reg2);
        }
        this._highlighted = _h;
    }

    function set isStandalone(_s)
    {
        this._isStandalone = _s;
    }

    function get isStandalone()
    {
        return this._isStandalone;
    }

    function ADD_TXD_REF(txd, txn)
    {
        if (this.avatarImg == undefined) 
        {
            this.avatarImg = com.rockstargames.ui.media.ImageLoaderMC(this.attachMovie("avatarImage", "a", this.getNextHighestDepth(), {_x: 25, _y: 0}));
        }
        var __reg4 = this.__get__isStandalone() ? "mp_matchmaking_card" : "PAUSE_MENU_SP_CONTENT";
        if (this.avatarImg.textureDict == txd) 
        {
            if (this.avatarImg.isLoaded) 
            {
                if (this.avatarImg.textureFilename != txn) 
                {
                    this.avatarImg.init(__reg4, txd, txn, 25, 25);
                    this.avatarImg.displayTxdResponse(txd);
                }
            }
            return;
        }
        if (this.avatarImg.isLoaded) 
        {
            this.avatarImg.removeTxdRef();
        }
        this.avatarImg.init(__reg4, txd, txn, 25, 25);
        var __reg2 = this.__get__isStandalone() ? 3 : 4;
        if (this.txdCallbackDepth != -1) 
        {
            __reg2 = this.txdCallbackDepth;
        }
        var __reg5 = this.avatarImg.splitPath(String(this.avatarImg), __reg2);
        this.avatarImg.requestTxdRef(__reg5, true);
    }

    function ON_DESTROY()
    {
        this.animateKick(false);
        if (this.avatarImg != undefined && this.avatarImg.isLoaded) 
        {
            this.avatarImg.removeTxdRef();
        }
    }

    function mOver()
    {
    }

    function mOut()
    {
    }

    function mPress()
    {
    }

}

