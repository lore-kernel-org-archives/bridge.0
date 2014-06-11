Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 12 Jun 2014 01:41:22 +0200
Message-Id: <1402530084-15061-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 0/2 net-next] bridge: fix bugs introduced by last
	multicast patchset
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

Once my last patchset got applied, I got slapped by an automatic smatch
and build bot. Here are two patches fixing the according issues, a potential
null pointer dereference and a compile error when compiling without IPv6.

[PATCH 1/2] is probably not the ideal solution - the assignment of the
group and max_delay is still a mess and has subtle differences between
IGMPv2, IGMPv3, MLDv1 and MLDv2. That should probably be fixed $later.
But for now, I think the easier fix might be better, restoring the
behaviour before my "adhere to querier mechanism" patch and therefore
keeping things bisect'able.

Cheers, Linus
