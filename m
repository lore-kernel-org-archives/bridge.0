From: Luis Carlos Cobo <luisca@cozybit.com>
In-Reply-To: <1213296250.3730.33.camel@johannes.berg>
References: <1213232760.6645.24.camel@localhost>
	(sfid-20080612_030607_332834_1EFDE126)
	<1213255570.3871.8.camel@johannes.berg>
	<1213294793.6615.16.camel@localhost>
	(sfid-20080612_202000_504292_98E93460)
	<1213294852.3730.31.camel@johannes.berg>
	<1213295643.6615.20.camel@localhost>
	(sfid-20080612_203408_119945_EA437275)
	<1213296250.3730.33.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 11:53:35 -0700
Message-Id: <1213296815.6615.24.camel@localhost>
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

On Thu, 2008-06-12 at 20:44 +0200, Johannes Berg wrote:
> But in response to what mac80211 command are you sending the promisc
> mode to the hw?

In the function associated to .configure_filter (struct ieee80211_ops)
in the driver, when (*new_flags & (FIF_PROMISC_IN_BSS))

-- 
Luis Carlos Cobo Rus       GnuPG ID: 44019B60
cozybit Inc.


