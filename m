Message-ID: <018f01c48c4c$84cc2130$8805640a@chriss>
From: "Chris Shaw" <chriss@watertech.com>
References: <1093490432.23223.86.camel@localhost.localdomain><20040826091553.5b691020@dell_ss3.pdx.osdl.net>
	<1093577817.23223.122.camel@localhost.localdomain>
Subject: Re: [Bridge] Bridge performance problem
Date: Fri, 27 Aug 2004 08:42:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Reply-To: Chris Shaw <chriss@watertech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Joubert Berger <joubert@berger-family.org>
Cc: bridge@lists.osdl.org

> Would you mind explaining what the txqueuelen does?  Or point me to a
> location I can read about it?  More about wanting to know what it does
> than anything else.

The TXQUEUELEN parameter is strictly for QoS, namely the PFIFO Scheduler, it
sets the Queue length for that scheduler and that's all I think it does...

> BTW, can you enable NAPI dynamically on the driver?  Or is this a
> compile time only option?

Compile-Time only I believe, it changes the driver code a bit where
interrupt handling is done I think...

> Finally, just to see if it was a software issue or hardware issue, I
> kept the OS/software the same and install on a new machine.  New
> machine/different NICS.  In this case I saw much improved performance.
> Whereas before I was taking a 45% hit, on this new hardware I was taking
> a 17% hit.  This make me think I have a hardware problem.

This concerns me a bit, I have a Dual-Port E1000 server adapter and I've
been very happy with it's operation, I do notice however that it could be
faster... The only other GbE NICS I've tried  have been NatSemi 83820-Based
and a Marvell OnBoard GbE NIC, both of which suck out loud as far as
performance goes... The Marvell one especially, it has some kind of wierd
timeout issue when receiving packets, a TCP dump shows it intermittently
pausing for like 2 seconds every 10 seconds or so... I could never figure
that one out...

    -Chris

