Date: Wed, 18 May 2011 16:48:31 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110518164831.333ef0a1@nehalam>
In-Reply-To: <4DD3F168.1060308@candelatech.com>
References: <20110518081718.0b1fc390@nehalam> <4DD3E38C.30609@candelatech.com>
	<20110518083948.261ded68@nehalam>
	<4DD3F168.1060308@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: add notification over netlink
 when STP changes state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org, David Miller <davem@davemloft.net>

I updated rstp daemon to handle hearing itself (and some other issues).
Not sure how many users there are of that code.

See:
  git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/rstp.git

