From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 22 Mar 2011 22:40:31 +0100
Message-Id: <1300830032-6727-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing
	ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Beulich <JBeulich@novell.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

> One unrelated other observation with this change of yours:
> daddr is an input argument to ipv6_dev_get_saddr(), yet
> it gets initialized only after the function was called. Is that
> really correct?
Hmm, that wasn't intentional. I tested that again and so far I still always
got the right source address. I had a little deeper look at ipv6_dev_get_saddr()
and seems like it could get racy the way it is now, so I'm attaching a patch
for that. Thanks for reporting, Jan.

And I hope I didn't cause too much inconvience with the build breakage,
didn't think of testing BRIDGE=y and IPV6=m.

Cheers, Linus
