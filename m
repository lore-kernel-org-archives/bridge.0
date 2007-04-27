From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: 27 Apr 2007 15:43:00 +0200
Message-ID: <m3zm4udjbv.fsf@ursa.amorsen.dk>
References: <H00000690017cb31.1177634858.mail.pacificwireless.net.au@MHS>
	<20070426210721.3fcf9f08@localhost.localdomain>
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

SH> Someone had sent some patches to do PVST, but PVST seems to be
SH> Cisco centric. and the patched version was too inflexible, so I
SH> didn't put it in mainline.

PVST is indeed Cisco centric. It is also the only way to stay sane if
you have several VLAN's.

However, isn't PVST the same as making a br100 out of eth0.100 and
eth1.100, and turning STP on? Hopefully the STP packets should then
emerge with a VLAN tag of 100.


/Benny


