Date: Tue, 24 Aug 2004 14:25:34 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: [PATCH] fix oops when mangling and brouting and
	tcpdumping packets
Message-Id: <20040824142534.2b5d9a87@dell_ss3.pdx.osdl.net>
In-Reply-To: <200408242235.10865.bdschuym@pandora.be>
References: <200408151158.55190.bdschuym@pandora.be>
	<20040824113837.2c3d037d@dell_ss3.pdx.osdl.net>
	<200408242235.10865.bdschuym@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Tue, 24 Aug 2004 22:35:10 +0200
Bart De Schuymer <bdschuym@pandora.be> wrote:

> On Tuesday 24 August 2004 20:38, Stephen Hemminger wrote:
> > How about this, it is basically Bart's patch with:
> > 	* some more cleanups to handle_bridge
> > 	* removing extra rcu_read_lock (already done in netif_receive_skb)
> > 	* pass bridge port to hook since already dereferenced in handle_bridge
> 
> Looks good.
> I'm not sure if the rcu_dereference() is needed, however. Can the bridge port 
> be removed while a packet is being processed? I thought the rcu_read_lock() 
> protects against that (del_nbp() does call_rcu(&p->rcu, destroy_nbp_rcu)).
> 
> cheers,
> Bart
> 
> 

rcu_read_lock is not really a lock, it just turns off preempt.
So, rcu_dereference is needed on CPU with weak consitency like Alpha.
It handles the case where a packet is processed between del_nbp() and destroy_nbp_rcu
where the bridge port still exists, but is being deleted.

