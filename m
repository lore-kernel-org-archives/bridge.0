From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Re: [PATCH] fix oops when mangling and brouting and
	tcpdumping packets
Date: Tue, 24 Aug 2004 22:35:10 +0200
References: <200408151158.55190.bdschuym@pandora.be>
	<20040824113837.2c3d037d@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040824113837.2c3d037d@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408242235.10865.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge <bridge@osdl.org>

On Tuesday 24 August 2004 20:38, Stephen Hemminger wrote:
> How about this, it is basically Bart's patch with:
> 	* some more cleanups to handle_bridge
> 	* removing extra rcu_read_lock (already done in netif_receive_skb)
> 	* pass bridge port to hook since already dereferenced in handle_bridge

Looks good.
I'm not sure if the rcu_dereference() is needed, however. Can the bridge port 
be removed while a packet is being processed? I thought the rcu_read_lock() 
protects against that (del_nbp() does call_rcu(&p->rcu, destroy_nbp_rcu)).

cheers,
Bart

