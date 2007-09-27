Date: Thu, 27 Sep 2007 12:01:14 -0700 (PDT)
Message-Id: <20070927.120114.95884344.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <46FB99EF.4020806@aitel.hist.no>
References: <Pine.LNX.4.64.0709270017120.17414@fbirervta.pbzchgretzou.qr>
	<20070926153330.77aade4d@freepuppy.rosehill>
	<46FB99EF.4020806@aitel.hist.no>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: why network devices don't do reference counting?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: helge.hafting@aitel.hist.no
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jbeulich@novell.com, jengelh@computergmbh.de, olecom@flower.upol.cz

From: Helge Hafting <helge.hafting@aitel.hist.no>
Date: Thu, 27 Sep 2007 13:54:23 +0200

> Wouldn't it be enough to down all the interfaces and close all the sockets?
> No need to bring down every app.

And there are routes, and neighbour cache entries, and all sorts
of external references to the stack.  For example, if a packet
gets stuck in a device because the link just went down, that
can hold references to the ipv6 module from several angles.

But you have to add code to actually keep track of all of these
references and there is no such code in the ipv6 module at all
and it's a nontrivial time consuming job to implement it.
