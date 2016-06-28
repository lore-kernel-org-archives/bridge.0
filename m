Return-Path: <davem@davemloft.net>
Date: Tue, 28 Jun 2016 05:48:48 -0400 (EDT)
Message-Id: <20160628.054848.470650145752210386.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1466764518-11358-1-git-send-email-daniel@dd-wrt.com>
References: <1466764518-11358-1-git-send-email-daniel@dd-wrt.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net] Bridge: Fix ipv6 mc snooping if bridge has
 no ipv6 address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: daniel@dd-wrt.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Daniel Danzberger <daniel@dd-wrt.com>
Date: Fri, 24 Jun 2016 12:35:18 +0200

> The bridge is falsly dropping ipv6 mulitcast packets if there is:
>  1. No ipv6 address assigned on the brigde.
>  2. No external mld querier present.
>  3. The internal querier enabled.
> =

> When the bridge fails to build mld queries, because it has no
> ipv6 address, it slilently returns, but keeps the local querier enabl=
ed.
> This specific case causes confusing packet loss.
> =

> Ipv6 multicast snooping can only work if:
>  a) An external querier is present
>  OR
>  b) The bridge has an ipv6 address an is capable of sending own queri=
es
> =

> Otherwise it has to forward/flood the ipv6 multicast traffic,
> because snooping cannot work.
> =

> This patch fixes the issue by adding a flag to the bridge struct that=

> indicates that there is currently no ipv6 address assinged to the bri=
dge
> and returns a false state for the local querier in
> __br_multicast_querier_exists().
> =

> Special thanks to Linus L=FCssing.
> =

> Signed-off-by: Daniel Danzberger <daniel@dd-wrt.com>

Applied.
