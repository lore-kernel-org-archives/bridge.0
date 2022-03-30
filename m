Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648655516;
 bh=1pUS2wJLudc1jkoub3g8WBHIEAC+pseXQcvY3pZfMu0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Am+WCxZTX2ITKAVP1o3qsr1gOdGMuaYiyHkH/+EeJjkLJMeHxAGQjWSYSmKc1pcKC
 4SOCgd+UMk5FsYlLEu+tu3mg47i11olIyeGVD9pvutsC6gjIrFX9olST43xxIAu1qU
 Hc62eLt3TXXNEagEoDSBjwTjg++wOKoA+wrDBXyK1llsJjD5E+QCCUeySXEov7u4MM
 s7XONWYwwKb1GwB5ytvtdcT6Q6znOaTj7ERLF2P8m3baOlOi68j0oHOkEvzV5/bNgL
 CvZWHhZRHwJG9HFnmojGDwQ5DPqx3fbVYne3oKRmKZHLVktVGOTnWqx4b2BLST7h7V
 jz0t7rEqBEVjg==
Date: Wed, 30 Mar 2022 08:51:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220330085154.34440715@kernel.org>
In-Reply-To: <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
References: <20220329114052.237572-1-wintera@linux.ibm.com>
 <20220329175421.4a6325d9@kernel.org>
 <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
 <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] veth: Support bonding events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexandra Winter <wintera@linux.ibm.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>

On Wed, 30 Mar 2022 13:14:12 +0200 Alexandra Winter wrote:
> >> This patch in no way addresses (2). But then, again, if we put 
> >> a macvlan on top of a bridge master it will shotgun its GARPS all 
> >> the same. So it's not like veth would be special in that regard.
> >>
> >> Nik, what am I missing?
> > 
> > If we're talking about macvlan -> bridge -> bond then the bond flap's
> > notify peers shouldn't reach the macvlan.

Hm, right. I'm missing a step in my understanding. As you say bridge
does not seem to be re-broadcasting the event to its master. So how
does Alexandra catch this kind of an event? :S

	case NETDEV_NOTIFY_PEERS:
		/* propagate to peer of a bridge attached veth */
		if (netif_is_bridge_master(dev)) {  

IIUC bond will notify with dev == bond netdev. Where is the event with
dev == br generated?

> > Generally broadcast traffic
> > is quite expensive for the bridge, I have patches that improve on the
> > technical side (consider ports only for the same bcast domain), but you also
> > wouldn't want unnecessary bcast packets being sent around. :)
> > There are setups with tens of bond devices and propagating that to all would be
> > very expensive, but most of all unnecessary. It would also hurt setups with
> > a lot of vlan devices on the bridge. There are setups with hundreds of vlans
> > and hundreds of macvlans on top, propagating it up would send it to all of
> > them and that wouldn't scale at all, these mostly have IP addresses too.

Ack.

> > Perhaps we can enable propagation on a per-port or per-bridge basis, then we
> > can avoid these walks. That is, make it opt-in.

Maybe opt-out? But assuming the event is only generated on
active/backup switch over - when would it be okay to ignore
the notification?

> >>> It also seems difficult to avoid re-bouncing the notifier.  
> >>
> >> syzbot will make short work of this patch, I think the potential
> >> for infinite loops has to be addressed somehow. IIUC this is the 
> >> first instance of forwarding those notifiers to a peer rather
> >> than within a upper <> lower device hierarchy which is a DAG.  
> 
> My concern was about the Hangbin's alternative proposal to notify all
> bridge ports. I hope in my porposal I was able to avoid infinite loops.

Possibly I'm confused as to where the notification for bridge master
gets sent..
