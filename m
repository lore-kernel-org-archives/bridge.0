Message-ID: <408C4DAF.5000206@netcabo.pt>
Date: Mon, 26 Apr 2004 00:45:51 +0100
From: filipe abrantes <filipe_abrantes@netcabo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridging ipv6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

hello all:

im trying to set up a bridge for ipv6, but i cant manage to get it 
working, does someone have experience with this?

i used the common :

brctl addbr br0
brctl addif br0 eth0
brctl addif br0 eth2

then to set up the ip's i tried

ifconfig eth0 inet6 add ::/0
ifconfig eth2 inet6 add ::/0
ifconfig br0 inet6 add 2020::2/128

and also tried(the above didnt work for me):

removing all addresses from all bridged interfaces (even the link local 
ones).


Another question:

Is there any way i can set up a bridge and then block all level 2 
forwarding between the bridged interfaces?

I know it seems odd, but the idea was to have only one interface to 
handle the other two - its good for ipv6 multicasting,  that way you 
dont need to bind sockets to all interfaces.


thanks a lot
