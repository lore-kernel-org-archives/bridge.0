Return-Path: <davem@davemloft.net>
Date: Mon, 25 May 2015 17:28:18 -0400 (EDT)
Message-Id: <20150525.172818.2000334376621437405.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1432343554-3493-1-git-send-email-linus.luessing@c0d3.blue>
References: <1432343554-3493-1-git-send-email-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCHv3 net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: herbert@gondor.apana.org.au, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, wkok@cumulusnetworks.com, cwang@twopensource.com

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Sat, 23 May 2015 03:12:34 +0200

> Network managers like netifd (used in OpenWRT for instance) try to
> configure interface options after creation but before setting the
> interface up.
> =

> Unfortunately the sysfs / bridge currently only allows to configure t=
he
> hash_max and multicast_router options when the bridge interface is up=
.=

> But since br_multicast_init() doesn't start any timers and only sets
> default values and initializes timers it should be save to reconfigur=
e
> the default values after that, before things actually get active afte=
r
> the bridge is set up.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied to net-next, thanks.
