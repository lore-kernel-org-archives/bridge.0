From: Joubert Berger <joubert@berger-family.org>
Content-Type: text/plain
Message-Id: <1093490432.23223.86.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Wed, 25 Aug 2004 23:20:32 -0400
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge performance problem
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

I need some help understanding a strange bridge performance problem I am
seeing.  Maybe I am making more out of this than I need to.  I need your
opinions.

The setup:

The first configuration is two machines connected via a cross over
cable:

Machine A <====> Machine B

The second configuration is two machines with a Linux bridge between
them:

Machine A  <===> Linux Bridge <===> Machine B

I am using netperf to do some performance measuring.  

I am running two tests.  One is the "streaming" test (the default test
for netperf) and the other is the "Connect Request/Response" (TCP_CRR)
test.

When I run the stream test against the top two setups, I get near line
speed.  I am happy with these numbers.

When I run the TCP_CRR test, for the first setup I get around 2200
connections per second, but in the second configuration I are getting
around 700-800 connections per second.  Why am I getting this big of a
difference?

I am running Redhat kernel 2.4.20-30.9 (RH9).  I also changed the
txqueuelen on the two bridge interfaces to 50000.

Anyone have any idea why I am seeing such a big difference in the
TCP_CRR test?  The introduction of the Linux bridge cause me some real
performance problems.

--joubert

