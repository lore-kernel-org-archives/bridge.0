Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2009 14:10:01 +0800
Message-ID: <E9E3926FA9CDBF489EA1684042C8A026012DBC6B@zmy16exm72.ds.mot.com>
In-Reply-To: <20090413230431.50d58d61@nehalam>
References: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com><20090413080009.034a5e7f@nehalam><E9E3926FA9CDBF489EA1684042C8A026012DBC38@zmy16exm72.ds.mot.com>
	<20090413230431.50d58d61@nehalam>
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

> What network device driver, that is probably the problem?
We are using Openwrt on our AP, and the driver is mvswitch.c its an
marvell driver.

If possible, can you point me to some piece of code in the driver to
check for memory leak?

Thanks Again,
Sharad.

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@vyatta.com]=20
Sent: Tuesday, April 14, 2009 1:05 AM
To: Tekale Sharad-FHJN78
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Out of memory problem

On Tue, 14 Apr 2009 13:21:13 +0800
"Tekale Sharad-FHJN78" <FHJN78@motorola.com> wrote:

> =20
>=20
> Hi Stephen
> > Most likely, you have created a loop and are not running spanning
> tree. When a loop happens, packets multiply until all > resources are=20
> exhausted.
>=20
> > you have created a loop.
> Ya, I have bridge named br-lan created by($brctl), and I have attached

> two interfaces to it, and I'm sending traffic from PC1 to PC2. Some=20
> thing like this
>=20
>  	    		 -----------------------=20
> 	   		|    ------------       |
> 	   		|   |   br-lan   |      |    <--- AP
> 	   		|    ------------       |     =20
> 	   		|  eth0.0       eth0.1  |=20
> 	    		 ----|------------|-----
>=20
> 	      	     |	      |
> 	      	     |	      |
>   	     		    PC1          PC2
>=20
> Previously:
> root@none:/$ brctl show
> bridge name     bridge id               STP enabled     interfaces
> br-lan          8000.001570d8d8fd       no              eth0.0
>                                                         eth0.1
>=20
> >are not running spanning tree.
> Is it always necessary to enable spanning tree when traffic is sent=20
> over loop?
>=20
> I have enabled spanning tree using
>=20
> root@none:/$ brctl stp br-lan on
> root@none:/$ brctl show
> bridge name     bridge id               STP enabled     interfaces
> br-lan          8000.001570d8d8fd       yes             eth0.0
>                                                         eth0.1
>=20
> But again, when huge traffic is pumped from PC1 to PC2, The=20
> skbuff_head_cache value is increased rapidly and even after stop=20
> pumping the traffic, this value doesn't come down, and system goes for

> crash or reboot because of out of memory.
>=20
> root@none:/$ cat /proc/slabinfo | grep skbuff_head
> skbuff_head_cache   4560   4560    192   20    1 : tunables  120   60
> 0 : slabdata    228    228      0
>=20
> One more point, say I have each port attached to there own bridge, and

> when I route traffic from one host to other, I'll not face this=20
> behavior, This behavior is relevant only in above case.
>=20
> Do I have to do any other setting to overcome out of memory problem?=20
> Also, Please let me know if any other information is required to=20
> isolate this behavior.

What network device driver, that is probably the problem?
