Date: Tue, 22 Feb 2011 10:08:17 -0800 (PST)
Message-Id: <20110222.100817.104065329.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1297966672-3457-2-git-send-email-linus.luessing@web.de>
References: <20110215154128.2a28632c@nehalam>
	<1297966672-3457-2-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 1/2] bridge: Fix MLD queries' ethernet source
	address
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
Date: Thu, 17 Feb 2011 19:17:51 +0100

> Map the IPv6 header's destination multicast address to an ethernet
> source address instead of the MLD queries multicast address.
> =

> For instance for a general MLD query (multicast address in the MLD qu=
ery
> set to ::), this would wrongly be mapped to 33:33:00:00:00:00, althou=
gh
> an MLD queries destination MAC should always be 33:33:00:00:00:01 whi=
ch
> matches the IPv6 header's multicast destination ff02::1.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Applied.
