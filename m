Date: Fri, 13 May 2011 16:02:32 -0400 (EDT)
Message-Id: <20110513.160232.1127228366429050055.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1305316844.3120.8.camel@edumazet-laptop>
References: <20110510233540.GJ6397@morgul.net>
	<20110513125314.66861b31@nehalam>
	<1305316844.3120.8.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: fix forwarding of IPv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org, noahm@debian.org, bridge@lists.linux-foundation.org, herbert@gondor.hengli.com.au, shemminger@vyatta.com, ben@decadent.org.uk

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Fri, 13 May 2011 22:00:44 +0200

> Le vendredi 13 mai 2011 =E0 12:53 -0700, Stephen Hemminger a =E9crit =
:
>> The commit 6b1e960fdbd75dcd9bcc3ba5ff8898ff1ad30b6e
>>     bridge: Reset IPCB when entering IP stack on NF_FORWARD
>> broke forwarding of IPV6 packets in bridge because it would
>> call bp_parse_ip_options with an IPV6 packet.
>> =

>> Reported-by: Noah Meyerhans <noahm@debian.org>
>> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
>> =

>> ---
>> Patch against net-next-2.6 but must be applied to net-2.6
>> and stable as well
>> =

> =

> Well, stable is not needed, since faulty commit is not in 2.6.38
> =

> Reviewed-by: Eric Dumazet <eric.dumazet@gmail.com>

I do need to queue it up for -stable because the faulty commit is
also queued up there :-)
