Return-Path: <davem@davemloft.net>
Date: Tue, 07 Jul 2020 15:39:04 -0700 (PDT)
Message-Id: <20200707.153904.491848475455000428.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200705191017.10546-1-linus.luessing@c0d3.blue>
References: <20200705191017.10546-1-linus.luessing@c0d3.blue>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net v2] bridge: mcast: Fix MLD2 Report IPv6
 payload length check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@c0d3.blue
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, martin@linuxlounge.net

From: Linus L=FCssing <linus.luessing@c0d3.blue>
Date: Sun,  5 Jul 2020 21:10:17 +0200

> Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
> igmp3/mld2 report handling") introduced a bug in the IPv6 header payl=
oad
> length check which would potentially lead to rejecting a valid MLD2 R=
eport:
> =

> The check needs to take into account the 2 bytes for the "Number of
> Sources" field in the "Multicast Address Record" before reading it.
> And not the size of a pointer to this field.
> =

> Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in =
igmp3/mld2 report handling")
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied and queued up for -stable, thank you.
