Return-Path: <davem@davemloft.net>
Date: Thu, 01 Sep 2016 22:48:56 -0700 (PDT)
Message-Id: <20160901.224856.296397400865362347.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1472650612-2123-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1472650612-2123-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 31 Aug 2016 15:36:50 +0200

> The first patch prepares the forwarding path by having the exact packet
> type passed down so we can later filter based on it and the per-port
> unknown mcast flood flag introduced in the second patch. It is similar to
> how the per-port unknown unicast flood flag works.
> Nice side-effects of patch 01 are the slight reduction of tests in the
> fast-path and a few minor checkpatch fixes.
> 
> v3: don't change br_auto_mask as that will change user-visible behaviour
> v2: make pkt_type an enum as per Stephen's comment

Series applied, thanks Nikolay.
