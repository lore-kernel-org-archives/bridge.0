Message-ID: <4405.131.188.28.69.1094744038.squirrel@www.osdl.org>
In-Reply-To: <20040909082129.62059694.davem@davemloft.net>
References: <414057B1.1020902@siennax.com>
	<20040909082129.62059694.davem@davemloft.net>
Date: Thu, 9 Sep 2004 08:33:58 -0700 (PDT)
From: shemminger@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Cc: davem@redhat.com, shemminger@osdl.org, bridge@lists.osdl.org

> On Thu, 09 Sep 2004 15:16:33 +0200
> Mark Ruijter <bridge@siennax.com> wrote:
>
>> I noticed that the VLAN code of kernels >=2.6.8 contain the patch needed
>> to mirror link state information from the real device to the vlan
>> device.
>>
>> This however causes the system to hang in combination with net-snmpd.
>> The last thing that I see is an ioctl(0x8947...
>
> What kind of ethernet devices do you have making use of VLAN?

I suspect the underlying device doesn't support mii interface.
If that is true, then the code is doing the right thing (and net-snmp)
is being too dependant on MII.
