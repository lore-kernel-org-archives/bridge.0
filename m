From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 16 Feb 2011 00:19:16 +0100
Message-Id: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [Bridge] Multicast snooping fixes and suggestions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, bridge@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.hengli.com.au>

Hello everyone,

While testing the (very awesome!) bridge igmp/mld snooping support I came across
two issues which are breaking IPv6 multicast snooping and IPv6
non-link-local multicast on bridges with multicast snooping support enabled
in general. The first two patches shall fix these issues.

The third one addresses a potential bug on little endian machines which I noticed
during this little code reviewing. This patch is untested though, feedback welcome.

The fourth and fifth patch are a suggestion to also permit using the bridge multicast
snooping feature for link local multimedia multicast traffic. Therefore
using the transient multicast flag instead of the non-link-local scope criteria
seems to be a suitable solution at least for IPv6, in my opinion. Let me know what
you think about it.

Thanks for reviewing these patches.

Cheers,
Linus
