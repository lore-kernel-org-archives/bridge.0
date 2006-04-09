Subject: Re: [Bridge] [PATCH] fix 802.3ad multicast
From: Vlad Drukker <vlad@storewiz.com>
In-Reply-To: <20060407165928.022d4ad8@dxpl.pdx.osdl.net>
References: <1144340106.17145.8.camel@quant>
	<20060407165928.022d4ad8@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 17:42:54 +0300
Message-Id: <1144593774.23360.16.camel@quant>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Fri, 2006-04-07 at 16:59 -0700, Stephen Hemminger wrote:
> On Thu, 06 Apr 2006 19:15:06 +0300
> Vlad Drukker <vlad@storewiz.com> wrote:
> 
> > Hi Stephen,
> > 
> > there was a bug in bridging bonds.
> > multicast packets needed for 802.3ad netif_carrier_ok() were dropped.
> > attached patch works for me.
> > 
> > Cheers,
> > Vlad.
> > 
> > 
> > 
> 
> Making a bonding specific hack like this seems wrong. The
> port could also be disabled during shutdown (for RCU removal),
> and in that case we need to drop the packet.
> 
> There must be a better solution.
> 

you probably right, 
skb_bond() looks like a proper place for this, because
netif_receive_skb() needs to call ETH_P_SLOW hadler instead of
hadle_bridge hook.

the fix is moving to linux-net . 


