Sender: fulvio@zeroshell.net
From: "Fulvio Ricciardi" <fulvio.ricciardi@zeroshell.net>
Date: Sat, 28 Jun 2008 06:56:07 +0200
Message-id: <4865c467.386.27ed.998123722@webmaildh4.aruba.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bridge] 802.1q packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I notice that with the Kernel 2.6.25.9 the 802.1q VLAN
tagged packets larger than 1470 bytes are not forwarded at
all by a bridge.
I think there is a bad interaction between bridge and
netfilter codes. Any chance to a have a patch to solve this
problem that limit the possibility to use the Linux bridges
in a environment with VLANs?

Best Regards
Fulvio Ricciardi

--------------------------------------------------------------------
Fulvio Ricciardi
web: http://www.zeroshell.net/eng/
skype: zeroshellnet
Phone: +3908321835630
