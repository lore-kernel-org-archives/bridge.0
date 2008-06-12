From: Luis Carlos Cobo <luisca@cozybit.com>
In-Reply-To: <1213255570.3871.8.camel@johannes.berg>
References: <1213232760.6645.24.camel@localhost>
	(sfid-20080612_030607_332834_1EFDE126)
	<1213255570.3871.8.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 11:19:53 -0700
Message-Id: <1213294793.6615.16.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] Do not activate promiscuous mode on wlan
	interfaces for	bridging.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: j@w1.fi, bridge@linux-foundation.org, linux-wireless@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>

On Thu, 2008-06-12 at 09:26 +0200, Johannes Berg wrote:
> All your description makes a lot of sense, but I don't see why altering
> the bridge code is necessary. In mac80211, we decided that the "promisc"
> bit only means to capture all frames in the current BSS (remember that
> in ethernet there is no way to capture frames from different LAN
> segments) and hence an AP would not behave differently in promisc mode
> at all since, by definition, it sees all BSS traffic.

You are right, within the BSS every frame is going to be addressed to
the AP anyway, so we should not receive more or less frames when
activating promiscuous mode.

When activating promiscuous mode in this device, it stops acknowledging
frames, and this impairs the association process. The other solution
would be to ignore the promiscuous mode commands (i.e. never send the
command to the device) for interfaces in AP mode. If this is the only
device showing this behavior, maybe that would be the best solution.

-- 
Luis Carlos Cobo Rus       GnuPG ID: 44019B60
cozybit Inc.


