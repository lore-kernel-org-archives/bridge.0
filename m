From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Nov 2009 14:13:09 +0100
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<200911241034.43961.arnd@arndb.de> <4B0BB818.6090509@trash.net>
In-Reply-To: <4B0BB818.6090509@trash.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911241413.09214.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 1/4] veth: move loopback logic to common
	location
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

On Tuesday 24 November 2009, Patrick McHardy wrote:
> I don't think its necessary, we bypass outgoing queuing anyways.
> But if you'd want to add it, just keeping the skb->mark clearing
> in veth should work from what I can tell.

Ok, I won't bother with it for now then.

	Arnd <><
