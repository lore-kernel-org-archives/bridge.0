Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Bridge performance problem
Date: Thu, 26 Aug 2004 09:29:09 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC97@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Joubert Berger <joubert@berger-family.org>, bridge <bridge@osdl.org>

Compared to the direct connection, the software bridge has a large
latency.  It takes longer for one packet to go from machine A to machine
B (& vice versa) when the bridge has to process it.

In the request/response test, the machines take turns sending each other
packets, so the latency is added to each exchange.

In the streaming test, the sending machine is able to send many packets
before the receiver acknowledges them, so the latency is divided among
many packets.

Is your bridge configured to do anything fancy, such as connection
tracking?  That would degrade performance for the connection test.  (But
I've never used it, so I don't know by how much.)
-- 
Dan Eble <dane@aiinet.com>  _____  .
Software Engineer          |  _  |/|
Applied Innovation Inc.    | |_| | |
http://www.aiinet.com/     |__/|_|_|

> -----Original Message-----
> From: bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Joubert Berger
> Sent: Wednesday, August 25, 2004 11:21 PM
> To: bridge@osdl.org
> Subject: [Bridge] Bridge performance problem
> 
> 
> I need some help understanding a strange bridge performance 
> problem I am
> seeing.  Maybe I am making more out of this than I need to.  
> I need your
> opinions.
> 
> The setup:
> 
> The first configuration is two machines connected via a cross over
> cable:
> 
> Machine A <====> Machine B
> 
> The second configuration is two machines with a Linux bridge between
> them:
> 
> Machine A  <===> Linux Bridge <===> Machine B
> 
> I am using netperf to do some performance measuring.  
> 
> I am running two tests.  One is the "streaming" test (the default test
> for netperf) and the other is the "Connect Request/Response" (TCP_CRR)
> test.
> 
> When I run the stream test against the top two setups, I get near line
> speed.  I am happy with these numbers.
> 
> When I run the TCP_CRR test, for the first setup I get around 2200
> connections per second, but in the second configuration I are getting
> around 700-800 connections per second.  Why am I getting this big of a
> difference?
> 
> I am running Redhat kernel 2.4.20-30.9 (RH9).  I also changed the
> txqueuelen on the two bridge interfaces to 50000.
> 
> Anyone have any idea why I am seeing such a big difference in the
> TCP_CRR test?  The introduction of the Linux bridge cause me some real
> performance problems.
> 
> --joubert
> 
> 

