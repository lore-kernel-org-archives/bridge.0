Date: Tue, 22 Feb 2011 10:08:06 -0800 (PST)
Message-Id: <20110222.100806.71122067.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Multicast snooping fixes and suggestions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, herbert@gondor.hengli.com.au

From: Linus L=FCssing <linus.luessing@web.de>
Date: Wed, 16 Feb 2011 00:19:16 +0100

> While testing the (very awesome!) bridge igmp/mld snooping support I =
came across
> two issues which are breaking IPv6 multicast snooping and IPv6
> non-link-local multicast on bridges with multicast snooping support e=
nabled
> in general. The first two patches shall fix these issues.
> =

> The third one addresses a potential bug on little endian machines whi=
ch I noticed
> during this little code reviewing. This patch is untested though, fee=
dback welcome.
> =

> The fourth and fifth patch are a suggestion to also permit using the =
bridge multicast
> snooping feature for link local multimedia multicast traffic. Therefo=
re
> using the transient multicast flag instead of the non-link-local scop=
e criteria
> seems to be a suitable solution at least for IPv6, in my opinion. Let=
 me know what
> you think about it.
> =

> Thanks for reviewing these patches.

Nice work, all applied to net-2.6, thanks!
