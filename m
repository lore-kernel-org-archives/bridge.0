From: "kingz" <jzhang@cienettechnologies.com>
Date: Tue, 30 Nov 2004 20:08:58 -0800
Message-ID: <000101c4d75b$7ec82c20$6c01a8c0@kingz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Ethernet bridge and 802.1Q VLAN , hotmail login error
Reply-To: jzhang@cienettechnologies.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi All,
 
I posted this question several days before, as if no one reply, any
help, hint would be highly appreciated!

PLEASE SAVE ME!

Now I am having trouble in Ethernet bridge and 802.1Q VLAN, I have the
following network:
   Internet
       |
       |
  Gateway
       |
       |    <---------  If insert one Ethernet bridge box in here
,somethings changes
       |
     H u b    ( one normal hub or switch , no VLAN settings)
      |   \
      |     \
  D-Link  802.1Q VLAN Switches (their uplink port-port 1  connected to
the upper hub are tagged, those ports connected with PCs are untagged).
 
Our client PCs connect to these VLAN Switches, they access Internet
through that UPNP gateway, It works all OK; Every PC connects to one
untagged port in a 802.1Q VLAN Switch , this untagged port and the
tagged  uplink port (e.g. port 1) make up of one VLAN,  the tagged port
1 is a common uplink port , So from the gateway we can see these VLAN ID
of PCs, so far it all work fine;  but when I insert one Ethernet bridge
box ( one linux box, kernel 2.4.26, ebtables-brnf-6_vs_2.4.26 patch, one
rt8139 NIC, one e100 NIC) between the gateway and the Hub, somethings
changed: 
I was not able to log  in hotmail, maybe also on certain websites. 
For example, I access  www.hotmail.com <http://www.hotmail.com/> , it
loads OK. When I input my account, and hit Login, it goes to a error
page(DNS error or server not found)  after a moment. Except the above
site, maybe also have others, but most sites work fine, very strange! I
am sure that this Linux Ethernet bridge is only transparent bridge, no
any Iptables filter and rule. 
If I remove the tag for VLAN(just change the port 1 to untagged),  also
with this Linux Ethernet bridge it works all OK, also have no hotmail
login error. Very strange, it as if the issue is on VLAN , tag, or Linux
Ethernet  bridge , I have no idea of it now! Is it a MTU issue on
Bridge?

I am stuck here now! 

Any help, comments, hints would be greatly appreciated!
If you need more info on it, please let me know soon!
Thanks!

Kingz


