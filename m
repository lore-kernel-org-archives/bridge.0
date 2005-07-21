Message-ID: <42DFBB23.6000308@grc.nasa.gov>
Date: Thu, 21 Jul 2005 11:11:31 -0400
From: Tad Kollar <tkollar@grc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge not working with jumbo frames
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I searched the mailman archives for this topic and there were some older
messages that indicate that a large MTU should work, but it's not going
too well here.  I've got three systems (A, B, and C) with kernel
2.6.12.2; there are back-to-back gigabit connections between A & B and
between B & C. Testing prior to bridging, the MTU is set to 9000 on
every interface and a 100 MB iperf transfer is made between A & B and
then between B & C with no problems.

When the two interfaces on B are bridged and an A to C transfer
attempted, a few packets (four, in the test I'm looking at now) go
through and the session freezes. One of the bridged interfaces on B
shows some frame errors. With an MTU of 1500, and everything else left
the same, the bridge works perfectly.

What additional information can I provide?

Thanks,
Tad
