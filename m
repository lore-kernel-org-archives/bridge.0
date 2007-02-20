Message-ID: <45DB0B1C.4020703@gmx.net>
Date: Tue, 20 Feb 2007 15:52:12 +0100
From: Michael Rennt <m.rennt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Measuring Bridge Performance (+ebtables/iptables)
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

has anyone done any performance measuring of Linux Bridge + firewalling?

I did search the net for a long time, to find out what would be the best way to measure the
(maximum) performance/throughput. I didn't really come to a conclusion I'm satisfied with.

Nevertheless I did create a small bridged test setup with 4 servers (gbit nics) and a linux bridge
(2 x 100 mbit nic), all on 2.6.19. Two servers are in the MZ and two in the DMZ, the bridge is (of
course) in the middle. There are two gbit switches (MZ and DMZ). iptables has ~400 rules loaded.

For actually testing the performance I ran packetgenerator as well as netperf on the servers.
Starting with one server and ending up with all machines sending and receiving. On the bridge I used
vnstat and iptraf to measure the throughput. I also wrote a perl script which is reading the device
counters from /proc to calculate an average.

On my search I found this, which is pretty interessting, but I don't have an Ixia testing device.
http://facweb.cti.depaul.edu/jyu/Publications/Yu-Linux-TSM2004.pdf
Is it worth to rent such a device or are there any good ways to create a similar setup?

Why I'm not satisfied with my tests? There's a production setup running, which is working at much
higher packet/throughput rates than I was able to reproduce in the lab. This is really bugging me. I
know about the different packet sizes involved when looking at real life traffic.

As I know that performance always depends on the setup, I'd really be interessted in your experience
in creating a test setup that is getting as close to real traffic as possible.

Best,

Michael
