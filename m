Return-Path: <joseph.salisbury@canonical.com>
Message-ID: <529E2D14.9000303@canonical.com>
Date: Tue, 03 Dec 2013 14:12:20 -0500
From: Joseph Salisbury <joseph.salisbury@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [Regression][3.12] bridge: fix NULL pointer deref of
	br_port_get_rcu
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: zhiguohong@tencent.com
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, "edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>

Hi Hong,

A kernel bug was opened against Ubuntu [0].  After a kernel bisect, it
was found that reverting the following commit resolved
this bug:

commit 716ec052d2280d511e10e90ad54a86f5b5d4dcc2
Author: Hong Zhiguo <zhiguohong@tencent.com>
Date:   Sat Sep 14 22:42:28 2013 +0800

    bridge: fix NULL pointer deref of br_port_get_rcu


The regression was introduced as of v3.12-rc2 and has made it into some
of the stable trees(3.10 and 3.11).

I was thinking of requesting a revert for this commit, but I wanted to
get your feedback first, since you are the patch author.


Thanks,

Joe


[0] http://pad.lv/1249880
