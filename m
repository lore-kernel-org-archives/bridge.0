Date: Wed, 30 Mar 2011 02:29:24 -0700 (PDT)
Message-Id: <20110330.022924.52196184.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1301207244-10428-2-git-send-email-linus.luessing@web.de>
References: <20110327034404.GC31916@Sellars>
	<1301207244-10428-1-git-send-email-linus.luessing@web.de>
	<1301207244-10428-2-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: mcast snooping,
 fix IPv6 MLD checksum calculation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: yoshfuji@linux-ipv6.org, herbert@gondor.hengli.com.au, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

From: Linus L=FCssing <linus.luessing@web.de>
Date: Sun, 27 Mar 2011 08:27:23 +0200

> In contrast to IGMP, the MLDv1/2 message checksum needs to include an=

> IPv6 "pseudo-header" in the calculations (see RFC2710, section 3.3;
> RFC3810, section 5.1.2).
> =

> The multicast snooping feature of the bridge code however did not tak=
e
> this "pseudo-header" into consideration for the checksum validation w=
hen
> parsing a snooped IPv6 MLDv1/2 message of another host, leading to
> possibly ignored, though valid MLDv1/2 messages. This commit shall fi=
x
> this issue.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

I'm waiting for am updated version of this patch which addresses Herber=
t
Xu's feedback.
