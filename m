Date: Mon, 2 Aug 2004 23:50:36 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Message-ID: <20040802215035.GA6799@man.manty.net>
References: <20040802153128.GA5423@man.manty.net>
	<20040802130840.434c409b@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802130840.434c409b@dell_ss3.pdx.osdl.net>
Subject: [Bridge] Re: [PATCH] 2.4.27-rc4 bridge fix
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, netdev@osd.org, bridge@osdl.org, "Marcelo W. Tosatti" <marcelo.tosatti@cyclades.com.br>

> The problem was that the br_add_bridge ended up calling register_netdev
> that did a rtnl_lock.  This fixes that, and gets rid of the bridge_list,
> there is no need to keep a separate device list of just bridges.  By not
> having multiple lists, races are avoided. 

Ok, this time it looks ok, it seems to fix the problem I had reported for
rc3 and also the one itroduced by the patch that was applied on rc4 to fix
it, so far everything seems to work ok now.

Thanks for fixing this.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
