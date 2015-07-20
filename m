Return-Path: <davem@davemloft.net>
Date: Mon, 20 Jul 2015 12:49:39 -0700 (PDT)
Message-Id: <20150720.124939.1328394717828737521.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/2] bridge: multicast: temp and perm
 entries behaviour enhancements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 15 Jul 2015 07:16:49 -0700

> Hi,
> Patch 01 adds a notify when a group is deleted via br_multicast_del_pg()
> (on expire, on device delete or on device down).
> Patch 02 changes how bridge device and bridge port delete and down/up are
> handled. Until now on bridge down all groups were flushed, now only the
> temp ones are (same for port), perm entries are flushed only on port or
> bridge removal.

Series applied, but if patch #2 breaks things for anyone depending upon the
old behavior of flushing all entries I will have to revert.
