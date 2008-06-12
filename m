From: Luis Carlos Cobo <luisca@cozybit.com>
In-Reply-To: <1213294852.3730.31.camel@johannes.berg>
References: <1213232760.6645.24.camel@localhost>
	(sfid-20080612_030607_332834_1EFDE126)
	<1213255570.3871.8.camel@johannes.berg>
	<1213294793.6615.16.camel@localhost>
	(sfid-20080612_202000_504292_98E93460)
	<1213294852.3730.31.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 11:34:03 -0700
Message-Id: <1213295643.6615.20.camel@localhost>
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

On Thu, 2008-06-12 at 20:20 +0200, Johannes Berg wrote:
> Is this a mac80211 driver? When are you activating promisc?

Yes, libertastf (adaptation of the libertas driver to use a thin
firmware and mac80211), you can check it out at 

git://dev.laptop.org/users/javier/libertastf.git

Still want to polish it a bit before submitting.

Promiscuous mode is being activated when attaching the interface to a
bridge, in the lines included in the patch on the first mail in the
thread.

-- 
Luis Carlos Cobo Rus       GnuPG ID: 44019B60
cozybit Inc.


