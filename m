Return-Path: <davem@davemloft.net>
Date: Wed, 20 Dec 2017 12:46:29 -0500 (EST)
Message-Id: <20171220.124629.1450992574441432030.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
References: <20171219181053.86320-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v1] bridge: Use helpers to handle MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: andriy.shevchenko@linux.intel.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 19 Dec 2017 20:10:53 +0200

> Use
> 	%pM to print MAC
> 	mac_pton() to convert it from ASCII to binary format, and
> 	ether_addr_copy() to copy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to net-next
