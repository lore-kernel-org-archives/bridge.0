Date: Thu, 27 Sep 2007 12:15:22 -0700 (PDT)
Message-Id: <20070927.121522.52884745.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0709271654270.30621@fbirervta.pbzchgretzou.qr>
References: <46FB99EF.4020806@aitel.hist.no>
	<20070927075102.4335a263@freepuppy.rosehill>
	<Pine.LNX.4.64.0709271654270.30621@fbirervta.pbzchgretzou.qr>
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
To: jengelh@computergmbh.de
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jbeulich@novell.com, helge.hafting@aitel.hist.no, olecom@flower.upol.cz

From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Thu, 27 Sep 2007 16:55:36 +0200 (CEST)

> 
> On Sep 27 2007 07:51, Stephen Hemminger wrote:
> >
> >You need every socket to close and all routes to go away including the 
> >routes through loopback device, and still there probably are control 
> >sockets buried inside ipv6 that hold ref count.
> >
> >IMHO the kernel should just admit that IPV6 can't be removed.
> 
> I cannot accept that. If ipv6.ko has a way to tack ipv6 structs onto all 
> sockets, interfaces and addresses, it should also be able to untack it 
> again.

Then you do the work and see how incredibly difficult the
implementation is, others have tried.  It's not trivial
and at best it's a very time consuming piece of work to
embark on.

Until then it's un-removable, plain as that :-)

I don't know why we're wasting our fingers discussing this
at all to be honest with you.
