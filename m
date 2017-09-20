Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Kyh3BgoareetIWjKz50EvxrwfXtXqYlonfTeVeoqhkY=;
	b=Xuhvvj8QcGSehOPBNbGH6KrAb4F9RN3vax3FvOwuEQnwTNOiidPdkNUZ/hIixkEG3P
	J0ovzHK5JOfrxqS+VzjSluJ9kHLkurTaVfhrBHpPvxuM7eU/iwplvDgbcPtghULC9JPH
	qq/Zu+xy/lGOdy2t0Rd53+gW+oUqQhAlRRKIS/4YFoEiwOanpNlQGdXVHCq9lBzY77Rs
	1fBDiV0L8THvCRm164b9SK6xKzoO+mJUR225/B+bLmF20yFAeZNFaHB1QNIA/SPnjAbj
	kZT4Nr9LeIoD71EL8K4+kkc4y32w4UwLfyCorGXk4Me8GxKJVZ8l8uLUl4VkT/X/YYK9
	rtZQ==
Date: Wed, 20 Sep 2017 16:21:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170920162140.369bb198@xeon-e3>
In-Reply-To: <16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
	<20170920.140956.781667692297467325.davem@davemloft.net>
	<16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
 when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vincent@bernat.im, David Miller <davem@davemloft.net>

On Wed, 20 Sep 2017 15:57:16 -0600
David Ahern <dsahern@gmail.com> wrote:

> On 9/20/17 3:09 PM, David Miller wrote:
> > From: Vincent Bernat <vincent@bernat.im>
> > Date: Sat, 16 Sep 2017 16:18:33 +0200
> > 
> > David, I am CC:'ing you because you've done work in this area over the
> > past year.  I'm applying this patch, it's been sitting since the 16th
> > and likes entirely correct to me.  But if you have objections just let
> > me know.
> >   
> >> Currently, when an interface is released from a bridge via
> >> ioctl(), we get a RTM_DELLINK event through netlink:
> >>
> >> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
> >>     link/ether 6e:23:c2:54:3a:b3
> >>
> >> Userspace has to interpret that as a removal from the bridge, not as a
> >> complete removal of the interface. When an bridged interface is
> >> completely removed, we get two events:
> >>
> >> Deleted 2: dummy0: <BROADCAST,NOARP> mtu 1500 master bridge0 state DOWN
> >>     link/ether 6e:23:c2:54:3a:b3
> >> Deleted 2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default
> >>     link/ether 6e:23:c2:54:3a:b3 brd ff:ff:ff:ff:ff:ff
> >>
> >> In constrast, when an interface is released from a bond, we get a
> >> RTM_NEWLINK with only the new characteristics (no master):
> >>
> >> 3: dummy1: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN group default
> >>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> >> 3: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
> >>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> >> 4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
> >>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> >> 3: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default
> >>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> >> 3: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default
> >>     link/ether ca:c8:7b:66:f8:25 brd ff:ff:ff:ff:ff:ff
> >> 4: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
> >>     link/ether ae:dc:7a:8c:9a:3c brd ff:ff:ff:ff:ff:ff
> >>
> >> Userland may be confused by the fact we say a link is deleted while
> >> its characteristics are only modified. A first solution would have
> >> been to turn the RTM_DELLINK event in del_nbp() into a RTM_NEWLINK
> >> event. However, maybe some piece of userland is relying on this
> >> RTM_DELLINK to detect when a bridged interface is released. Instead,
> >> we also emit a RTM_NEWLINK event once the interface is
> >> released (without master info).
> >>
> >> Deleted 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 master bridge0 state UNKNOWN
> >>     link/ether 8a:bb:e7:94:b1:f8
> >> 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default
> >>     link/ether 8a:bb:e7:94:b1:f8 brd ff:ff:ff:ff:ff:ff
> >>
> >> This is done only when using ioctl(). When using Netlink, such an
> >> event is already automatically emitted in do_setlink().  
> 
> The DELLINK is for AF_BRIDGE family (ifi_family). Adding family to
> print_linkinfo and running the monitor I get:
> 
> 
> [LINK]family 0: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
> noqueue master br0 state UNKNOWN group default
>     link/ether d6:c3:73:86:3c:73 brd ff:ff:ff:ff:ff:ff
> 
> [LINK]family 7: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500
> master br0 state UNKNOWN
>     link/ether d6:c3:73:86:3c:73
> 
> [LINK]Deleted family 7: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu
> 1500 master br0 state UNKNOWN
>     link/ether d6:c3:73:86:3c:73
> 
> [LINK]family 0: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
> noqueue state UNKNOWN group default
>     link/ether d6:c3:73:86:3c:73 brd ff:ff:ff:ff:ff:ff
> 
> And that seems correct. So I think the RTM_NEWLINK added by this patch
> should not be needed.

Agreed, thanks for tracing this.

The one concern is that ports added or removed through ioctl should
cause same events as doing the same thing via netlink. Some users use
brctl (ioctl) and others use newer bridge (netlink) API.

