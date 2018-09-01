Return-Path: <davem@davemloft.net>
Date: Fri, 31 Aug 2018 23:13:28 -0700 (PDT)
Message-Id: <20180831.231328.2014260442176283292.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180830103318.60804-1-andriy.shevchenko@linux.intel.com>
References: <20180830103318.60804-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v1] bridge: Switch to bitmap_zalloc()
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
Date: Thu, 30 Aug 2018 13:33:18 +0300

> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to net-next, thanks.
