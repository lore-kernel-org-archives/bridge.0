Message-Id: <200503161611.j2GGBT0F004479@ginger.cmf.nrl.navy.mil>
In-reply-to: <20050315121930.GE3189@stusta.de> 
Date: Wed, 16 Mar 2005 11:11:29 -0500
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
Cc: netdev@oss.sgi.co, linux-atm-general@lists.sourceforge.net, bridge@osdl.org, linux-kernel@vger.kernel.org, shemminger@osdl.org

In message <20050315121930.GE3189@stusta.de>,Adrian Bunk writes:
>This patch fixes the following compile error with CONFIG_BRIDGE=y and 
>CONFIG_ATM_LANE=m:

isnt the problem more that CONFIG_ATM=m not CONFIG_ATM_LANE=m?
perhaps CONFIG_BRIDGE should be dependent on CONFIG_ATM.  if
atm is a module then bridge cannot be a module (unless the 
hooks are moved from atm to bridge)?
