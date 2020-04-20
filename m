Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bTtcioAVktBgcUTfi+bs1vdsWqSYfUDLbtTIZdRCNz8=; b=C7umDL1g3lTk+Vwd6Q6R0TWE8u
 q7btrSM81MUhI7cA63GDWG6lBHEUvpaDoh5aKxalnyyfYBVroMKB0Jz+Xt1OLMaCdTaevIGn4k8GH
 wz8y9FMWVXo4VBUod7x34sn1aIm9rZklz06PbBUXAraOLvFVIah0Y70QY21SQ0Mv3x3Y=;
Date: Mon, 20 Apr 2020 15:31:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200420133111.GL785713@lunn.ch>
References: <20200419161946.19984-1-dqfext@gmail.com>
 <20200419164251.GM836632@lunn.ch>
 <CALW65jYmcZJoP_i5=bgeWpcibzOmEPne3mHyBngE5bTiOZreDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALW65jYmcZJoP_i5=bgeWpcibzOmEPne3mHyBngE5bTiOZreDw@mail.gmail.com>
Subject: Re: [Bridge] [RFC PATCH net-next] net: bridge: fix client roaming
 from DSA user port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Ren=E9?= van Dorst <opensource@vdorst.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

> When a client moves from a hardware port (e.g. sw0p1) to a software port (wlan0)
> or another hardware port that belongs to a different switch (sw1p1),
> that MAC entry
> in sw0's MAC table should be deleted, or replaced with the CPU port as
> destination,
> by DSA. Otherwise the client is unable to talk to other hosts on sw0 because sw0
> still thinks the client is on sw0p1.

The MAC address needs to move, no argument there. But what are the
mechanisms which cause this. Is learning sufficient, or does DSA need
to take an active role?

Forget about DSA for the moment. How does this work for two normal
bridges? Is the flow of unicast packets sufficient? Does it requires a
broadcast packet from the device after it moves?

	  Andrew
