Return-Path: <davem@davemloft.net>
Date: Mon, 23 Jul 2018 09:32:45 -0700 (PDT)
Message-Id: <20180723.093245.1883999792575475458.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180723081659.21986-1-nikolay@cumulusnetworks.com>
References: <20180723081659.21986-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/2] net: bridge: add support for
 backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 23 Jul 2018 11:16:57 +0300

> This set introduces a new bridge port option that allows any port to have
> any other port (in the same bridge of course) as its backup and traffic
> will be forwarded to the backup port when the primary goes down. This is
> mainly used in MLAG and EVPN setups where we have peerlink path which is
> a backup of many (or even all) ports and is a participating bridge port
> itself. There's more detailed information in patch 02. Patch 01 just
> prepares the port sysfs code for options that take raw value. The main
> issues that this set solves are scalability and fallback latency.
 ...

Series applied, thanks Nikolay.
