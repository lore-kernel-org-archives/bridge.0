Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2009 23:14:30 +0800
Message-ID: <E9E3926FA9CDBF489EA1684042C8A026012DBDC1@zmy16exm72.ds.mot.com>
In-Reply-To: <20090414080800.178d636a@nehalam>
References: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com><20090413080009.034a5e7f@nehalam><E9E3926FA9CDBF489EA1684042C8A026012DBC38@zmy16exm72.ds.mot.com><20090413230431.50d58d61@nehalam><E9E3926FA9CDBF489EA1684042C8A026012DBC6B@zmy16exm72.ds.mot.com>
	<20090414080800.178d636a@nehalam>
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
>If the driver was open source and in one of the standard distributions,
it could be reviewed. But since you are on an=20
>older kernel with a non-standard driver there really isn't a lot of
interest on my part to help. Sorry.

That's fine and thanks for guiding till now.

But, Please look at this case once:
Now each of ports are attached to there own bridge instead of one, and
when I route traffic from one host to other, We will never face this
problem.

root@none:/$ brctl addbr br-lan1
root@none:/$ brctl addif br-lan1 eth0.0
root@none:/$ brctl stp br-lan1 on

root@none:/$ brctl addbr br-lan2
root@none:/$ brctl addif br-lan2 eth0.1
root@none:/$ brctl stp br-lan2 on

root@none:/$ brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan1         8000.001570d8d8fd       yes             eth0.0
br-lan2         8000.001570d8d8fd       yes             eth0.1

In this case, even if I send huge traffic the throughput is decreased
but device is not going out of memory.

Hence I feel there is some leak in bridge instead of driver

root@OpenWrt:/$ brctl --version
bridge-utils, 1.0.6.

If possible, please check this.

Thanks,
Sharad.



-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@vyatta.com]=20
Sent: Tuesday, April 14, 2009 10:08 AM
To: Tekale Sharad-FHJN78
Cc: bridge@lists.linux-foundation.org
Subject: Re: [Bridge] Out of memory problem

On Tue, 14 Apr 2009 14:10:01 +0800
"Tekale Sharad-FHJN78" <FHJN78@motorola.com> wrote:

> > What network device driver, that is probably the problem?
> We are using Openwrt on our AP, and the driver is mvswitch.c its an=20
> marvell driver.
>=20
> If possible, can you point me to some piece of code in the driver to=20
> check for memory leak?
>=20
> Thanks Again,
> Sharad.

If the driver was open source and in one of the standard distributions,
it could be reviewed. But since you are on an older kernel with a
non-standard driver there really isn't a lot of interest on my part to
help. Sorry.
