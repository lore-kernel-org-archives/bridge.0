Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ByAhn8PBoSHwSze0020yTDNOWgitigJYN6xUVhhH4V4=;
	b=i8WHatCXHlzWML1a/dlS1DOzjGvAB8+Sp0/Fuft4o3RaC3VR13ilXcV8SnH8e1lRCk
	al9rcbRQ5/lZ7O//56aSijBddb/sAc+FlnoV8XnFYMXBkGD0UieIKfAUMURbM/WmoJl4
	fHmwM3UcXT7FaKMV+BOUD5G8e0fW17/6v2OcnSzhB5HpHn9ERthWXPUC/0cOCfT0ElP7
	x8skdfHzkKTWhi6M8DgwYj/dGdVTamGj+ek02WDQpHVd/b3+50rcgdbc/4ES0SM0ue3G
	9AXZued68MH4/+9jHAqSWu7woFktXLR2sX2nBqtwpZYz+cCMhTB79qSbr2AhexCBbdQh
	QEEg==
Date: Wed, 31 Aug 2016 08:59:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20160831085918.686148a6@xeon-e3>
In-Reply-To: <1472650612-2123-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1472650612-2123-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/2] net: bridge: add per-port
 unknown multicast flood control
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On Wed, 31 Aug 2016 15:36:50 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Hi,
> The first patch prepares the forwarding path by having the exact packet
> type passed down so we can later filter based on it and the per-port
> unknown mcast flood flag introduced in the second patch. It is similar to
> how the per-port unknown unicast flood flag works.
> Nice side-effects of patch 01 are the slight reduction of tests in the
> fast-path and a few minor checkpatch fixes.
> 
> v3: don't change br_auto_mask as that will change user-visible behaviour
> v2: make pkt_type an enum as per Stephen's comment
> 
> Thanks,
>  Nik
> 
> 
> Nikolay Aleksandrov (2):
>   net: bridge: change unicast boolean to exact pkt_type
>   net: bridge: add per-port multicast flood flag
> 
>  include/linux/if_bridge.h    |  1 +
>  include/uapi/linux/if_link.h |  1 +
>  net/bridge/br_device.c       |  8 ++++----
>  net/bridge/br_forward.c      |  7 +++++--
>  net/bridge/br_if.c           |  2 +-
>  net/bridge/br_input.c        | 40 +++++++++++++++++++++++++---------------
>  net/bridge/br_netlink.c      | 12 +++++++++---
>  net/bridge/br_private.h      |  7 ++++++-
>  net/bridge/br_sysfs_if.c     |  1 +
>  9 files changed, 53 insertions(+), 26 deletions(-)
> 

Looks good thanks, and most importantly shouldn't break existing users.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
