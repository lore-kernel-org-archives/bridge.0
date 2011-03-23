Date: Tue, 22 Mar 2011 19:26:54 -0700 (PDT)
Message-Id: <20110322.192654.246547109.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1300830032-6727-2-git-send-email-linus.luessing@web.de>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<1300830032-6727-1-git-send-email-linus.luessing@web.de>
	<1300830032-6727-2-git-send-email-linus.luessing@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: Fix possibly wrong MLD queries'
 ethernet source address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linus.luessing@web.de
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, JBeulich@novell.com

From: Linus L=FCssing <linus.luessing@web.de>
Date: Tue, 22 Mar 2011 22:40:32 +0100

> The ipv6_dev_get_saddr() is currently called with an uninitialized
> destination address. Although in tests it usually seemed to neverthel=
ess
> always fetch the right source address, there seems to be a possible r=
ace
> condition.
> =

> Therefore this commit changes this, first setting the destination
> address and only after that fetching the source address.
> =

> Reported-by: Jan Beulich <JBeulich@novell.com>
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>

Applied, thank you!
