Date: Mon, 1 Sep 2008 09:38:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20080901093827.24eec86f@lxorguk.ukuu.org.uk>
In-Reply-To: <48BB295A.6050200@vyatta.com>
References: <fa.wTMiBcGRgw2fBtdHwtX7y0lkc8s@ifi.uio.no>
	<48975BD3.6040709@shaw.ca>
	<a08621850808041337k1d1deb6fk78098d9fcd4930dd@mail.gmail.com>
	<20080807185802.GA16327@electric-eye.fr.zoreil.com>
	<a08621850808101200n220afd2dve58abe67830b7a4f@mail.gmail.com>
	<a08621850808110053j5cbf23e6xdf52c9e7440abf19@mail.gmail.com>
	<a08621850808291848q5660148fx57d576ecfcbfce8@mail.gmail.com>
	<a08621850808310151o143845h195a8658d02270d9@mail.gmail.com>
	<20080831100537.6929c51e@extreme> <20080831104309.780cc01f@extreme>
	<20080831230247.76b5a193@lxorguk.ukuu.org.uk>
	<48BB295A.6050200@vyatta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] bridge: STP timer management range checking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen.hemminger@vyatta.com>
Cc: Robert Hancock <hancockr@shaw.ca>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, Stephen Hemminger <shemminger@vyatta.com>, Dushan Tcholich <dusanc@gmail.com>, David Miller <davem@davemloft.net>

> > Seems bogus extra code to me - stops things working that should be
> > allowed too.
> >   
> The timer configuration is propagated in network protocol, so 
> misconfigured Linux box
> could survive but effect other devices on the network that are less 
> robust. Maybe the

That would be irrelevant. CAP_NET_ADMIN lets you make that size mess
anyway.

> small values would cause some other bridge to crash, go infinite loop, ...
> More likely robust devices might ignore our packets (because values out 
> of range), leading to
> routing loops and other disasters.

Spamming tree isn't secure, news at 11.

> The kernel does need to stop administrative settings from taking out a 
> network. 

If you have CAP_NET_ADMIN you can trivially take out the network unless
it is properly switched.

Now you might want your pretty little GUI and/or config tools to warn
people that their configuration is outside 802 specs but that is a
different matter altogether

Alan
