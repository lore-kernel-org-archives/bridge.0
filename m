Date: Thu, 15 Feb 2007 17:54:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <BAY131-F1857AFF907BF1716A253BBE2960@phx.gbl>
Message-ID: <Pine.LNX.4.61.0702151753450.786@yvahk01.tjqt.qr>
References: <BAY131-F1857AFF907BF1716A253BBE2960@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Bridge] bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: saravanan chanemouganandam <saravanan_sprt@hotmail.com>
Cc: netfilter@lists.netfilter.org, bridge@lists.osdl.org


On Feb 15 2007 22:06, saravanan chanemouganandam wrote:
>
> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0

That's a no-op. What you need is `ip l s eth0 up` (same for eth1)

> are configured. The problem is that, I can't ping the Router from the Host. But

brctl sethello br0 1



Jan
-- 
ft: http://freshmeat.net/p/chaostables/
