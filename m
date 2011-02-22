Date: Tue, 22 Feb 2011 10:08:23 -0800 (PST)
Message-Id: <20110222.100823.189696335.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1297966672-3457-3-git-send-email-linus.luessing@web.de>
References: <20110215154128.2a28632c@nehalam>
	<1297966672-3457-3-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 2/2] bridge: Use IPv6 link-local address for
 multicast listener queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, herbert@gondor.hengli.com.au

From: Linus L=FCssing <linus.luessing@web.de>
Date: Thu, 17 Feb 2011 19:17:52 +0100

> Currently the bridge multicast snooping feature periodically issues
> IPv6 general multicast listener queries to sense the absence of a
> listener.
> =

> For this, it uses :: as its source address - however RFC 2710 require=
s:
> "To be valid, the Query message MUST come from a link-local IPv6 Sour=
ce
> Address". Current Linux kernel versions seem to follow this requireme=
nt
> and ignore our bogus MLD queries.
> =

> With this commit a link local address from the bridge interface is be=
ing
> used to issue the MLD query, resulting in other Linux devices which a=
re
> multicast listeners in the network to respond with a MLD response (wh=
ich
> was not the case before).
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Applied.
