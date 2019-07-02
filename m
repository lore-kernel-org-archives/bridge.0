Return-Path: <martin@linuxlounge.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxlounge.net;
	s=mail; t=1562070559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	references:references:openpgp:openpgp:autocrypt:autocrypt;
	bh=re2ZqYeUM5Tez/ydwn5DJv1spDayYcuBMxdnc3+f7Fs=;
	b=EvDwa2OFYgXnQVUVjiIMQZLf1ZBAiBdf9JUdVOd3YE4OutEKLWMLulqPpjSk/cq1EXEzg7
	2GFtK1nbnvtIJf1tIdsvpX2koxmaF2wzsjBwGaM9QeR+tRnZx3Yf2tqsucXnyy+x68/3IK
	1CZ1mY5zMhOvlUHkGV2tc+sGwDV9kWc=
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
	<20190702120021.13096-2-nikolay@cumulusnetworks.com>
From: Martin Weinelt <martin@linuxlounge.net>
Message-ID: <300cdc5e-5dba-bdfe-5564-6a053d2fe77e@linuxlounge.net>
Date: Tue, 2 Jul 2019 14:29:11 +0200
In-Reply-To: <20190702120021.13096-2-nikolay@cumulusnetworks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="geCxhd2mYAHpNjRhKvKgxHDdNmrLQim74"
Subject: Re: [Bridge] [PATCH net 1/4] net: bridge: mcast: fix stale nsrcs
 pointer in igmp3/mld2 report handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--geCxhd2mYAHpNjRhKvKgxHDdNmrLQim74
Content-Type: multipart/mixed; boundary="fdVha97FKQDtaoTuzBMr9yoQ3MVJnBobv";
 protected-headers="v1"
From: Martin Weinelt <martin@linuxlounge.net>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, davem@davemloft.net,
 bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org
Message-ID: <300cdc5e-5dba-bdfe-5564-6a053d2fe77e@linuxlounge.net>
Subject: Re: [PATCH net 1/4] net: bridge: mcast: fix stale nsrcs pointer in
 igmp3/mld2 report handling
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
 <20190702120021.13096-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20190702120021.13096-2-nikolay@cumulusnetworks.com>

--fdVha97FKQDtaoTuzBMr9yoQ3MVJnBobv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Tested-by: Martin Weinelt <martin@linuxlounge.net>

On 7/2/19 2:00 PM, Nikolay Aleksandrov wrote:
> We take a pointer to grec prior to calling pskb_may_pull and use it
> afterwards to get nsrcs so record nsrcs before the pull when handling
> igmp3 and we get a pointer to nsrcs and call pskb_may_pull when handlin=
g
> mld2 which again could lead to reading 2 bytes out-of-bounds.
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: use-after-free in br_multicast_rcv+0x480c/0x4ad0 [bridge]
>  Read of size 2 at addr ffff8880421302b4 by task ksoftirqd/1/16
>=20
>  CPU: 1 PID: 16 Comm: ksoftirqd/1 Tainted: G           OE     5.2.0-rc6=
+ #1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 0=
4/01/2014
>  Call Trace:
>   dump_stack+0x71/0xab
>   print_address_description+0x6a/0x280
>   ? br_multicast_rcv+0x480c/0x4ad0 [bridge]
>   __kasan_report+0x152/0x1aa
>   ? br_multicast_rcv+0x480c/0x4ad0 [bridge]
>   ? br_multicast_rcv+0x480c/0x4ad0 [bridge]
>   kasan_report+0xe/0x20
>   br_multicast_rcv+0x480c/0x4ad0 [bridge]
>   ? br_multicast_disable_port+0x150/0x150 [bridge]
>   ? ktime_get_with_offset+0xb4/0x150
>   ? __kasan_kmalloc.constprop.6+0xa6/0xf0
>   ? __netif_receive_skb+0x1b0/0x1b0
>   ? br_fdb_update+0x10e/0x6e0 [bridge]
>   ? br_handle_frame_finish+0x3c6/0x11d0 [bridge]
>   br_handle_frame_finish+0x3c6/0x11d0 [bridge]
>   ? br_pass_frame_up+0x3a0/0x3a0 [bridge]
>   ? virtnet_probe+0x1c80/0x1c80 [virtio_net]
>   br_handle_frame+0x731/0xd90 [bridge]
>   ? select_idle_sibling+0x25/0x7d0
>   ? br_handle_frame_finish+0x11d0/0x11d0 [bridge]
>   __netif_receive_skb_core+0xced/0x2d70
>   ? virtqueue_get_buf_ctx+0x230/0x1130 [virtio_ring]
>   ? do_xdp_generic+0x20/0x20
>   ? virtqueue_napi_complete+0x39/0x70 [virtio_net]
>   ? virtnet_poll+0x94d/0xc78 [virtio_net]
>   ? receive_buf+0x5120/0x5120 [virtio_net]
>   ? __netif_receive_skb_one_core+0x97/0x1d0
>   __netif_receive_skb_one_core+0x97/0x1d0
>   ? __netif_receive_skb_core+0x2d70/0x2d70
>   ? _raw_write_trylock+0x100/0x100
>   ? __queue_work+0x41e/0xbe0
>   process_backlog+0x19c/0x650
>   ? _raw_read_lock_irq+0x40/0x40
>   net_rx_action+0x71e/0xbc0
>   ? __switch_to_asm+0x40/0x70
>   ? napi_complete_done+0x360/0x360
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x40/0x70
>   ? __schedule+0x85e/0x14d0
>   __do_softirq+0x1db/0x5f9
>   ? takeover_tasklets+0x5f0/0x5f0
>   run_ksoftirqd+0x26/0x40
>   smpboot_thread_fn+0x443/0x680
>   ? sort_range+0x20/0x20
>   ? schedule+0x94/0x210
>   ? __kthread_parkme+0x78/0xf0
>   ? sort_range+0x20/0x20
>   kthread+0x2ae/0x3a0
>   ? kthread_create_worker_on_cpu+0xc0/0xc0
>   ret_from_fork+0x35/0x40
>=20
>  The buggy address belongs to the page:
>  page:ffffea0001084c00 refcount:0 mapcount:-128 mapping:000000000000000=
0 index:0x0
>  flags: 0xffffc000000000()
>  raw: 00ffffc000000000 ffffea0000cfca08 ffffea0001098608 00000000000000=
00
>  raw: 0000000000000000 0000000000000003 00000000ffffff7f 00000000000000=
00
>  page dumped because: kasan: bad access detected
>=20
>  Memory state around the buggy address:
>  ffff888042130180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff888042130200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  > ffff888042130280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                      ^
>  ffff888042130300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff888042130380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Disabling lock debugging due to kernel taint
>=20
> Fixes: bc8c20acaea1 ("bridge: multicast: treat igmpv3 report with INCLU=
DE and no sources as a leave")
> Reported-by: Martin Weinelt <martin@linuxlounge.net>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_multicast.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index de22c8fbbb15..f37897e7b97b 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -911,6 +911,7 @@ static int br_ip4_multicast_igmp3_report(struct net=
_bridge *br,
>  	int type;
>  	int err =3D 0;
>  	__be32 group;
> +	u16 nsrcs;
> =20
>  	ih =3D igmpv3_report_hdr(skb);
>  	num =3D ntohs(ih->ngrec);
> @@ -924,8 +925,9 @@ static int br_ip4_multicast_igmp3_report(struct net=
_bridge *br,
>  		grec =3D (void *)(skb->data + len - sizeof(*grec));
>  		group =3D grec->grec_mca;
>  		type =3D grec->grec_type;
> +		nsrcs =3D ntohs(grec->grec_nsrcs);
> =20
> -		len +=3D ntohs(grec->grec_nsrcs) * 4;
> +		len +=3D nsrcs * 4;
>  		if (!ip_mc_may_pull(skb, len))
>  			return -EINVAL;
> =20
> @@ -946,7 +948,7 @@ static int br_ip4_multicast_igmp3_report(struct net=
_bridge *br,
>  		src =3D eth_hdr(skb)->h_source;
>  		if ((type =3D=3D IGMPV3_CHANGE_TO_INCLUDE ||
>  		     type =3D=3D IGMPV3_MODE_IS_INCLUDE) &&
> -		    ntohs(grec->grec_nsrcs) =3D=3D 0) {
> +		    nsrcs =3D=3D 0) {
>  			br_ip4_multicast_leave_group(br, port, group, vid, src);
>  		} else {
>  			err =3D br_ip4_multicast_add_group(br, port, group, vid,
> @@ -983,7 +985,8 @@ static int br_ip6_multicast_mld2_report(struct net_=
bridge *br,
>  	len =3D skb_transport_offset(skb) + sizeof(*icmp6h);
> =20
>  	for (i =3D 0; i < num; i++) {
> -		__be16 *nsrcs, _nsrcs;
> +		__be16 *_nsrcs, __nsrcs;
> +		u16 nsrcs;
> =20
>  		nsrcs_offset =3D len + offsetof(struct mld2_grec, grec_nsrcs);
> =20
> @@ -991,12 +994,13 @@ static int br_ip6_multicast_mld2_report(struct ne=
t_bridge *br,
>  		    nsrcs_offset + sizeof(_nsrcs))
>  			return -EINVAL;
> =20
> -		nsrcs =3D skb_header_pointer(skb, nsrcs_offset,
> -					   sizeof(_nsrcs), &_nsrcs);
> -		if (!nsrcs)
> +		_nsrcs =3D skb_header_pointer(skb, nsrcs_offset,
> +					    sizeof(__nsrcs), &__nsrcs);
> +		if (!_nsrcs)
>  			return -EINVAL;
> =20
> -		grec_len =3D struct_size(grec, grec_src, ntohs(*nsrcs));
> +		nsrcs =3D ntohs(*_nsrcs);
> +		grec_len =3D struct_size(grec, grec_src, nsrcs);
> =20
>  		if (!ipv6_mc_may_pull(skb, len + grec_len))
>  			return -EINVAL;
> @@ -1021,7 +1025,7 @@ static int br_ip6_multicast_mld2_report(struct ne=
t_bridge *br,
>  		src =3D eth_hdr(skb)->h_source;
>  		if ((grec->grec_type =3D=3D MLD2_CHANGE_TO_INCLUDE ||
>  		     grec->grec_type =3D=3D MLD2_MODE_IS_INCLUDE) &&
> -		    ntohs(*nsrcs) =3D=3D 0) {
> +		    nsrcs =3D=3D 0) {
>  			br_ip6_multicast_leave_group(br, port, &grec->grec_mca,
>  						     vid, src);
>  		} else {
>=20



--fdVha97FKQDtaoTuzBMr9yoQ3MVJnBobv--

--geCxhd2mYAHpNjRhKvKgxHDdNmrLQim74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE7tAWAry9GWw4vJofvUqgUo9j8X4FAl0bThcACgkQvUqgUo9j
8X4rDgf/VtCx/2cN3lg7iMX0nk1vmS1CshEWPYDHRZcr3CsltMcX8QEVlLm5wS2V
vylqbFHqAndmMderscingVIE3aBdzdBH7ZvI8tSMUl1dtGff6vvburHGzUbME2Na
GyK/ahZnocsd+eijqHIYih7G9pxUVCAvpgvBJp2ryCar+RkT6XQ061A2M6DYyJs8
7QmTcISNfGiTJqUX1vxvX5r7cgQsJpmGAiN/8jXz5qIJrmxnWxk5/St4p50/ipc2
FKc4RZQKLtAK/txTho5CktwMrsswcWaDiQ3xLcwhib7b4GlJJk1ps2QRxGCKGs5Q
P86SPIhrh0QuLqgxtWEbfqxsb/njPQ==
=W4B9
-----END PGP SIGNATURE-----

--geCxhd2mYAHpNjRhKvKgxHDdNmrLQim74--
