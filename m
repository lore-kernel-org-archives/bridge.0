Date: Wed, 30 Mar 2011 02:30:01 -0700 (PDT)
Message-Id: <20110330.023001.13743450.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1301207244-10428-3-git-send-email-linus.luessing@web.de>
References: <20110327034404.GC31916@Sellars>
	<1301207244-10428-1-git-send-email-linus.luessing@web.de>
	<1301207244-10428-3-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: mcast snooping,
 fix length check of snooped MLDv1/2
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
Date: Sun, 27 Mar 2011 08:27:24 +0200

> "len =3D ntohs(ip6h->payload_len)" does not include the length of the=
 ipv6
> header itself, which the rest of this function assumes, though.
> =

> This leads to a length check less restrictive as it should be in the
> following line for one thing. For another, it very likely leads to an=

> integer underrun when substracting the offset and therefore to a very=

> high new value of 'len' due to its unsignedness. This will ultimately=

> lead to the pskb_trim_rcsum() practically never being called, even in=

> the cases where it should.
> =

> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Applied.
