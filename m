Return-Path: <ast@fiberby.net>
Message-ID: <52090C26.4090001@fiberby.net>
Date: Mon, 12 Aug 2013 16:24:06 +0000
From: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridge VLAN kernel/iproute2 incompatibility
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Vlad Yasevich <vyasevic@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Hi,

Let's start with a little history:

Feb 20:   Vlad Yasevich got his VLAN-aware bridge patchset included in
          the 3.9 merge window.
          In the kernel commit 6cbdceeb, he added attribute support to
          bridge GETLINK requests sent with rtgenmsg.

Mar 6th:  Vlad got this iproute2 reference implementation of the bridge
          vlan netlink interface accepted (iproute2 9eff0e5c)

Apr 25th: iproute2 switched from using rtgenmsg to ifinfomsg (63338dca)
          http://patchwork.ozlabs.org/patch/239602/
          http://marc.info/?t=136680900700007

Apr 28th: Linus released 3.9

Apr 30th: Stephen released iproute2 3.9.0

The `bridge vlan show` command haven't been working since the switch to
ifinfomsg, or in a released version of iproute2. Since the kernel side
only supports rtgenmsg, which iproute2 switched away from just prior to
the iproute2 3.9.0 release.

I haven't been able to find any documentation, about neither rtgenmsg
nor ifinfomsg, and in which situation to use which, but kernel commit
88c5b5ce seams to suggest that ifinfomsg should be used.

Fixing this in kernel will break compatibility, but I doubt that anybody
have been using it due to this bug in the user space reference
implementation, at least not without noticing this bug. That said the
functionality is still fully functional in 3.9, when reversing iproute2
commit 63338dca.

This could also be fixed in iproute2, but thats an ugly patch that would
reintroduce rtgenmsg in iproute2, and from searching in netdev it seams
like rtgenmsg usage is discouraged. I'm assuming that the only reason
that Vlad implemented the kernel side to use rtgenmsg, was because
iproute2 was using it at the time.

I will reply with kernel patch, I can also post the alternative iproute2
patch if requested.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network engineer
Fiberby ApS - AS42541
