Return-Path: <davem@davemloft.net>
Date: Thu, 05 Jun 2014 15:21:51 -0700 (PDT)
Message-Id: <20140605.152151.1874961526019573838.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1401969212-19193-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1401969212-19193-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next] bridge: Fix incorrect judgment of
	promisc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: stephen@networkplumber.org, vyasevic@redhat.com, David.Laight@ACULAB.COM, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu,  5 Jun 2014 20:53:32 +0900

> br_manage_promisc() incorrectly expects br_auto_port() to return only 0
> or 1, while it actually returns flags, i.e., a subset of BR_AUTO_MASK.
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

I'm applying this as-is for now, even though I saw the other
suggestions in this thread (which BTW didn't get picked up by
patchwork, maybe some of you dropped the Message-Id in your replies by
accident).
