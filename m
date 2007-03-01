Date: Wed, 28 Feb 2007 19:56:11 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070228195611.24cf19ee@deepthought>
In-Reply-To: <45E62C29.7010203@candelatech.com>
References: <20070228171846.679d8733@dxpl.pdx.osdl.net>
	<45E62C29.7010203@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: avoid ptype_all packet handling
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, David Miller <davem@davemloft.net>

On Wed, 28 Feb 2007 17:28:09 -0800
Ben Greear <greearb@candelatech.com> wrote:

> Stephen Hemminger wrote:
> > I was measuring bridging/routing performance and noticed this.
> > 
> > The current code runs the "all packet" type handlers before calling
> > the bridge hook.  If an application (like some DHCP clients) is
> > using AF_PACKET, this means that each received packet gets run
> > through the Berkeley Packet Filter code in sk_run_filter (slow).
> > 
> > By moving the bridging hook to run first, the packets flowing
> > through the bridge get filtered out there. This results in a 14%
> > improvement in performance, but it does mean that some snooping
> > applications would miss packets if being used on a bridge.  The
> > correct way to see all packets on a bridge is to set the bridge
> > pseudo-device to promiscuous mode.
> 
> Seems it would be better to fix these clients to be more selective as
> to where they bind.

The problem is any use of BPF is a lose, if it has to be done to all
traffic.

> This breaks the case where you want to see packets on a particular
> interface, not just the entire bridge, right?

It might be possible to use promisc counter to handle this.
