Message-ID: <41407816.4050908@siennax.com>
Date: Thu, 09 Sep 2004 17:34:46 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
References: <414057B1.1020902@siennax.com>
	<20040909082129.62059694.davem@davemloft.net>
In-Reply-To: <20040909082129.62059694.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Problem in changed VLAN code can cause systems to hang.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: davem@redhat.com, bridge@lists.osdl.org, shemminger@osdl.org

David S. Miller wrote:
> On Thu, 09 Sep 2004 15:16:33 +0200
> Mark Ruijter <bridge@siennax.com> wrote:
> 
> 
>>I noticed that the VLAN code of kernels >=2.6.8 contain the patch needed 
>>to mirror link state information from the real device to the vlan device.
>>
>>This however causes the system to hang in combination with net-snmpd.
>>The last thing that I see is an ioctl(0x8947...
> 
> 
> What kind of ethernet devices do you have making use of VLAN?

The machine that would hang had these cards installed ( and had vlan's 
on them) :

eth0: Tigon3 [partno(NA) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 
10/100/1000BaseT Ethernet 00:0f:20:32:35:53
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] 
WireSpeed[1] TSOcap[1]
eth1: Tigon3 [partno(NA) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 
10/100/1000BaseT Ethernet 00:0f:20:32:35:52

e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection

The laptop that I use however shows the same results:

eth0: RealTek RTL8139 at 0xd902a800, 00:02:3f:6e:58:6e, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8101'

So I don't think it's related to the hardware.

net-snmp-5.1 will demonstrate the problem right away.
Just start the deamon on the host and type:
snmpwalk -c public -v 2c 127.0.0.1

Mark.

-- 

