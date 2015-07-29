Return-Path: <davem@davemloft.net>
Date: Tue, 28 Jul 2015 23:33:33 -0700 (PDT)
Message-Id: <20150728.233333.793723681312359738.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1437674465-4388-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1437667657-16954-1-git-send-email-nikolay@cumulusnetworks.com>
	<1437674465-4388-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] bridge: stp: when using userspace stp
 stop kernel hello and hold timers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 23 Jul 2015 11:01:05 -0700

> From: Nikolay Aleksandrov <razor@blackwall.org>
> 
> These should be handled only by the respective STP which is in control.
> They become problematic for devices with limited resources with many
> ports because the hold_timer is per port and fires each second and the
> hello timer fires each 2 seconds even though it's global. While in
> user-space STP mode these timers are completely unnecessary so it's better
> to keep them off.
> Also ensure that when the bridge is up these timers are started only when
> running with kernel STP.
> 
> Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
