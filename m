Message-ID: <4569FA06.6050004@kingsley.co.za>
Date: Sun, 26 Nov 2006 22:33:10 +0200
From: Etienne Pretorius <etiennep@kingsley.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] ARP spoofing.
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello all.

I know this does not directly relay to Ethernet bridging but I need some 
advise... anyone want to give me some info/help on the subject.
In the interest of multipath routing I need to know if it is possible to 
do a one-way arp spoof. Lets start with the machines layout...

    br1------ADSL

    br2------cisco router-----serial line.
 
    br0-----Internal network.


I already have ebtables setup to do the following:
# Make this the router for all packets from our networks.
# " MAC destination is the router, IP destination is the actual box
# you want to communicate with. (That's how routing works) " - EBTABLES
$EBT -t broute -A BROUTING --logical-in $NWIF -p IPv4 --destination ! 
$NWIF_MAC \
   -j dnat --to-destination $NWIF_MAC

Now.... I would like the "cisco router" to have a second ip address in 
the same range as the internal network on eth0. My desire is to make the 
gw's on all of the internal network machines point to the cisco router's 
ip address and would like ARP packets to pass between the internal 
network and the cisco router only. Obviously I will drop all packet 
attempting to access the cisco router's second ip address if not from 
br0. So is it possible to make this machine spoof the arp packets 
because I have 2 such machines working in the network and I see this as 
a seemless way to setup multipath routing to survive if one of these 
machines fail.






-- 
Kind Regards
Etienne


