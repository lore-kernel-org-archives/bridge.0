From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20110513125314.66861b31@nehalam>
References: <20110506201234.6297.70279.reportbug@ip6-localhost>
	<1304995124.4065.157.camel@localhost>
	<20110510043833.GG6397@morgul.net>
	<1305031369.4065.259.camel@localhost>
	<20110510180540.GI6397@morgul.net>
	<20110510151100.52a9f8fa@nehalam> <20110510233540.GJ6397@morgul.net>
	<20110513125314.66861b31@nehalam>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 13 May 2011 22:00:44 +0200
Message-ID: <1305316844.3120.8.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] bridge: fix forwarding of IPv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: netdev <netdev@vger.kernel.org>, Noah Meyerhans <noahm@debian.org>, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Ben Hutchings <ben@decadent.org.uk>, David Miller <davem@davemloft.net>

Le vendredi 13 mai 2011 à 12:53 -0700, Stephen Hemminger a écrit :
> The commit 6b1e960fdbd75dcd9bcc3ba5ff8898ff1ad30b6e
>     bridge: Reset IPCB when entering IP stack on NF_FORWARD
> broke forwarding of IPV6 packets in bridge because it would
> call bp_parse_ip_options with an IPV6 packet.
> 
> Reported-by: Noah Meyerhans <noahm@debian.org>
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> ---
> Patch against net-next-2.6 but must be applied to net-2.6
> and stable as well
> 

Well, stable is not needed, since faulty commit is not in 2.6.38

Reviewed-by: Eric Dumazet <eric.dumazet@gmail.com>



