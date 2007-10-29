From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Mon, 29 Oct 2007 14:06:33 +0100
Message-ID: <m3k5p6hxye.fsf@ursa.amorsen.dk>
References: <96CF49BD8B56384395D698BA99007FA32D06@exchange.pacwire.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Subject: [Bridge] Re: Small packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

>>>>> "LS" == Leigh Sharpe <lsharpe@pacificwireless.com.au> writes:

LS> Standard e1000 hardware. The packets being bridged contain a VLAN
LS> tag, which is included in the 60 bytes.

The e1000 has VLAN acceleration. The VLAN tag is sent in a separate
register. If you do packet capture on the sender, the packet will
likely look 60 bytes long, even if it is 64 bytes on the wire.

The same thing happens on receive. Packet dumping with VLAN's is a bit
of a mess in Linux. If you're lucky you can find a card without VLAN
acceleration to do the packet dump.


/Benny


