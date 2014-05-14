Return-Path: <davem@davemloft.net>
Date: Wed, 14 May 2014 15:29:53 -0400 (EDT)
Message-Id: <20140514.152953.1992805646844184373.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1400080168-16625-1-git-send-email-vyasevic@redhat.com>
References: <1400080168-16625-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/8] Non-promisc bidge ports support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jhs@mojatatu.com, john.r.fastabend@intel.com, shemminger@vyatta.com

From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed, 14 May 2014 11:09:20 -0400

> This series adds functionality to the bridge device to enable
> operations without setting all ports to promiscuous mode.

I'm prepared to apply this, please address the minor stylistic
feedback you've received and resubmit.

Also, what does:

====================
Conflicts:
	net/bridge/br_if.c
	net/bridge/br_private.h
====================

exactly mean in patch #7?

Thanks.
