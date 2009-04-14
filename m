Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2009 13:21:13 +0800
Message-ID: <E9E3926FA9CDBF489EA1684042C8A026012DBC38@zmy16exm72.ds.mot.com>
In-Reply-To: <20090413080009.034a5e7f@nehalam>
References: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com>
	<20090413080009.034a5e7f@nehalam>
From: "Tekale Sharad-FHJN78" <FHJN78@motorola.com>
Subject: Re: [Bridge] Out of memory problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

=20

Hi Stephen=20
> Most likely, you have created a loop and are not running spanning
tree. When a loop happens, packets multiply until all > resources are
exhausted.

> you have created a loop.
Ya, I have bridge named br-lan created by($brctl), and I have attached
two interfaces to it, and I'm sending traffic from PC1 to PC2. Some
thing like this

 	    		 -----------------------=20
	   		|    ------------       |
	   		|   |   br-lan   |      |    <--- AP
	   		|    ------------       |     =20
	   		|  eth0.0       eth0.1  |=20
	    		 ----|------------|-----

	      	     |	      |
	      	     |	      |
  	     		    PC1          PC2

Previously:
root@none:/$ brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan          8000.001570d8d8fd       no              eth0.0
                                                        eth0.1

>are not running spanning tree.
Is it always necessary to enable spanning tree when traffic is sent over
loop?

I have enabled spanning tree using

root@none:/$ brctl stp br-lan on
root@none:/$ brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan          8000.001570d8d8fd       yes             eth0.0
                                                        eth0.1

But again, when huge traffic is pumped from PC1 to PC2, The
skbuff_head_cache value is increased rapidly and even after stop pumping
the traffic, this value doesn't come down, and system goes for crash or
reboot because of out of memory.

root@none:/$ cat /proc/slabinfo | grep skbuff_head
skbuff_head_cache   4560   4560    192   20    1 : tunables  120   60
0 : slabdata    228    228      0

One more point, say I have each port attached to there own bridge, and
when I route traffic from one host to other, I'll not face this
behavior, This behavior is relevant only in above case.

Do I have to do any other setting to overcome out of memory problem?=20
Also, Please let me know if any other information is required to isolate
this behavior.

Thanks,
Sharad.

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@vyatta.com]=20
Sent: Monday, April 13, 2009 10:00 AM
To: Tekale Sharad-FHJN78
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Out of memory problem

On Mon, 13 Apr 2009 16:58:20 +0800
"Tekale Sharad-FHJN78" <FHJN78@motorola.com> wrote:

> Hi, I'm using linux 2.6.21.5 and our kernel is freeze.
> =20
> The problem is, if I create a Software bridge using $brctl command.=20
> and add two interfaces say, eth0.0 and eth0.1 using
>=20
> $brctl addbr br-lan
> $brctl addif br-lan eth0.0
> $brctl addif br-lan eth0.1
> =20
> and when i send traffic from a host connected to one port to host=20
> connected at other end, soon all the memory is dried up and and kernel

> crashes, then oom-killer gets invoked which kills all the processes=20
> finally system reboots.
> =20
> Can any one help me to refer to some patch  or point some location in=20
> code from where memory is failed to deallocate.
> =20
> Thanks,
> Sharad.

