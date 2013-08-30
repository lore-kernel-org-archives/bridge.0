Return-Path: <davem@davemloft.net>
Date: Fri, 30 Aug 2013 15:29:02 -0400 (EDT)
Message-Id: <20130830.152902.1277686222231900490.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1377876497-6185-1-git-send-email-linus.luessing@web.de>
References: <20130828.200831.289304393401193657.davem@davemloft.net>
	<1377876497-6185-1-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCHv2] bridge: separate querier and query timer
 into IGMP/IPv4 and MLD/IPv6 ones
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: amwang@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux@baker-net.org.uk, stephen@networkplumber.org, herbert@gondor.apana.org.au

From: Linus L=FCssing <linus.luessing@web.de>
Date: Fri, 30 Aug 2013 17:28:17 +0200

> Currently we would still potentially suffer multicast packet loss if =
there
> is just either an IGMP or an MLD querier: For the former case, we wou=
ld
> possibly drop IPv6 multicast packets, for the latter IPv4 ones. This =
is
> because we are currently assuming that if either an IGMP or MLD queri=
er
> is present that the other one is present, too.
> =

> This patch makes the behaviour and fix added in
> "bridge: disable snooping if there is no querier" (b00589af3b04)
> to also work if there is either just an IGMP or an MLD querier on the=

> link: It refines the deactivation of the snooping to be protocol
> specific by using separate timers for the snooped IGMP and MLD querie=
s
> as well as separate timers for our internal IGMP and MLD queriers.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Looks great, applied, thanks.
