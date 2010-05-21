Message-ID: <4BF64C67.5070206@si.ct.upc.edu>
Date: Fri, 21 May 2010 11:03:35 +0200
From: frank <frank@si.ct.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] MAC address in bridge device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,
we have a couple of Red Hat 5 servers with OpenVZ with some virtual=20
machines (VEs). This virtual machines have veths (virtual ethernet=20
devices), and this devices are attached to a bridge device with main=20
node ethernet.

# brctl show
vzbr2        8000.001851cfe1c3    no        veth130.0
                                                                  eth0
The bridge device also has an IP because we need to reach host with an=20
IP in this subnet.
We have noticed a problem:

When we boot the main host, the bridge takes the IP we have defined to=20
it and the MAC af the eth0 device. That's ok.
But when a veth is joined to the bridge device, this one takes the MAC=20
of the veth device, so MAC bridge device changes; of course this cause=20
different kind of network problems because all hosts which were=20
connected still has the old MAC in its arp table.

We have revised a lot of things, but we don't find any explanation. Does=20
anybody  know a possible cause of this behaviour?
Where can we look to get more information? Is the bridge working as=20
expected?

Thanks in advance for your help.
Regards.

Frank
UPC - Terrassa (Barcelona)



--=20
Aquest missatge ha estat analitzat per MailScanner
a la cerca de virus i d'altres continguts perillosos,
i es considera que est=E0 net.

