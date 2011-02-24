Message-ID: <4D65CD81.4070203@zytor.com>
Date: Wed, 23 Feb 2011 19:16:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Multicast snooping fixes and suggestions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>, "David S. Miller" <davem@davemloft.net>

On 02/15/2011 03:19 PM, Linus Lüssing wrote:
> Hello everyone,
> 
> While testing the (very awesome!) bridge igmp/mld snooping support I came across
> two issues which are breaking IPv6 multicast snooping and IPv6
> non-link-local multicast on bridges with multicast snooping support enabled
> in general. The first two patches shall fix these issues.
> 
> The third one addresses a potential bug on little endian machines which I noticed
> during this little code reviewing. This patch is untested though, feedback welcome.
> 
> The fourth and fifth patch are a suggestion to also permit using the bridge multicast
> snooping feature for link local multimedia multicast traffic. Therefore
> using the transient multicast flag instead of the non-link-local scope criteria
> seems to be a suitable solution at least for IPv6, in my opinion. Let me know what
> you think about it.
> 

Hello,

I have just noticed that when using a Linux bridge, IPv6 often fails to
configure until some considerable time has passed, presumably some kind
of retry timer.  The dmesg shows:

[178292.449300] br0: port 1(eth0) entering learning state
[178292.449304] br0: port 1(eth0) entering learning state
[178302.536098] br0: no IPv6 routers present
[178307.416139] br0: port 1(eth0) entering forwarding state

... even though there is a configured and active IPv6 router on the network.

I have also seen some serious delays with DHCPv4 which presumably is due
to lost packets during bridge learning.

Are these packets likely to address that situation (or am I just plain
doing something stupid)?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

