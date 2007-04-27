From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: 28 Apr 2007 01:19:13 +0200
Message-ID: <m3ps5pe77y.fsf@ursa.amorsen.dk>
References: <H00000690017cb31.1177634858.mail.pacificwireless.net.au@MHS>
	<20070426210721.3fcf9f08@localhost.localdomain>
	<m3zm4udjbv.fsf@ursa.amorsen.dk>
	<20070427114814.66962558@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: PVST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

>>>>> "SH" == Stephen Hemminger <shemminger@linux-foundation.org> writes:

SH> The problem is if you bridge two vlan's then the Cisco box will
SH> see two STP bpdu's arrive, and conclude that there is a cycle and
SH> bring the link down.

Even if the VLAN's are both numbered 100?

Bridging eth0.100 with eth1.101 won't work if a Cisco is involved, but
that is not so surprising.


/Benny


