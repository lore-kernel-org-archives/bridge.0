Message-Id: <200503161824.j2GIOArr007631@ginger.cmf.nrl.navy.mil>
In-reply-to: <20050316181532.GA3251@stusta.de> 
Date: Wed, 16 Mar 2005 13:24:11 -0500
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
Subject: [Bridge] Re: [2.6 patch] fix bridge <-> ATM compile error 
Reply-To: chas3@users.sourceforge.net
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-atm-general@lists.sourceforge.net, bridge@osdl.org, linux-kernel@vger.kernel.org, shemminger@osdl.org

In message <20050316181532.GA3251@stusta.de>,Adrian Bunk writes:
>Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
>idea, since I doubt all people using the Bridge code require ATM 
>support.

i agree.

>Moving the hooks to the bridge code will give you exactly the same 
>problems the other way round.

how about moving them to a third location like net/core/dev.c?
