Return-Path: <davem@davemloft.net>
Date: Sat, 23 Feb 2019 18:36:51 -0800 (PST)
Message-Id: <20190223.183651.798454146886527920.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190222132232.24123-1-liuhangbin@gmail.com>
References: <20190222132232.24123-1-liuhangbin@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net] Revert "bridge: do not add port to router
 list when receives query with source 0.0.0.0"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: liuhangbin@gmail.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, stable@vger.kernel.org, yinxu@redhat.com, gregkh@linuxfoundation.org, s.gottschall@newmedia-net.de

From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 22 Feb 2019 21:22:32 +0800

> This reverts commit 5a2de63fd1a5 ("bridge: do not add port to router =
list
> when receives query with source 0.0.0.0") and commit 0fe5119e267f ("n=
et:
> bridge: remove ipv6 zero address check in mcast queries")
> =

> The reason is RFC 4541 is not a standard but suggestive. Currently we=

> will elect 0.0.0.0 as Querier if there is no ip address configured on=

> bridge. If we do not add the port which recives query with source
> 0.0.0.0 to router list, the IGMP reports will not be about to forward=

> to Querier, IGMP data will also not be able to forward to dest.
> =

> As Nikolay suggested, revert this change first and add a boolopt api
> to disable none-zero election in future if needed.
> =

> Reported-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> Reported-by: Sebastian Gottschall <s.gottschall@newmedia-net.de>
> Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when rec=
eives query with source 0.0.0.0")
> Fixes: 0fe5119e267f ("net: bridge: remove ipv6 zero address check in =
mcast queries")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Applied and queued up for -stable, thanks.
