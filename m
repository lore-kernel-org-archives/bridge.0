Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 1 Dec 2004 10:14:22 +0100
Message-ID: <559955256E359E41860785213F701E980FD79E@EX5.d.ethz.ch>
From: =?iso-8859-1?Q?St=FCdi=2C_Patrick?= <stuedip@student.ethz.ch>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridge Performance
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi there,
 
I got a question regarding throughput performance using linux 2.4.5.1. My setup is very simple : I have two laptops with a wireless card. On each laptop I configure the wireless cards to be in ad hoc mode, create a bridge and include the interface within the bridge (stp is off). Then of course I'm assigning an IP address to the bridge while assigning 0.0.0.0 to the wireless interface (eth1). After having setup both machines I run throughput tests using iperf. What I measure is around 1.5 Mbit/s for TCP traffic. This is about 1/3 of what I get when communicating directly through the wireless interface on both machines, without any bridge on top. Where all this performance gets lost? Does anyone have an idea? The same performance degradation I measured on a 2.6 Kernel.
 
Any help would be appreciated.
 
Best Regards, 
Patrick

