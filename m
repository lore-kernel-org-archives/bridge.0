Return-Path: <davem@davemloft.net>
Date: Thu, 03 May 2018 13:41:19 -0400 (EDT)
Message-Id: <20180503.134119.613881858170428292.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180503104724.17799-1-nikolay@cumulusnetworks.com>
References: <20180503104724.17799-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: avoid duplicate
 notification on up/down/change netdev events
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
Date: Thu,  3 May 2018 13:47:24 +0300

> While handling netdevice events, br_device_event() sometimes uses
> br_stp_(disable|enable)_port which unconditionally send a notification,
> but then a second notification for the same event is sent at the end of
> the br_device_event() function. To avoid sending duplicate notifications
> in such cases, check if one has already been sent (i.e.
> br_stp_enable/disable_port have been called).
> The patch is based on a change by Satish Ashok.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> We've been running with a similar patch for over an year, it's been
> thoroughly tested. Sending for net-next since it's an improvement and
> not really a bug fix.

Looks good, applied, thanks!
