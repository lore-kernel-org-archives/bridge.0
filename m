Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=ZS1hdM2dLsIlb7yqUlnhLDroUWcG6WpXbsGcaYexh7c=;
 b=qjND6vjWd4BjFopiGLmQ0HNSG0b/WKi8TcjTqCA8sTXu2ZwLUnAgG5h3Qi+MKckJFh
 O0pUM7YeiazFfT72a4FFL6WV+E0nejo0g8Z6ZqFWho5zV1WnALO1IkfZ3+DiY+gy9eyk
 vSPm4vxaX+xkJOFyUGnnNhJOnKF5/ZkPN873PS4tDAb0rs9ayOrTy3SXntA9yY6haLnS
 hEnmVAHdnRE4g5mU1DuUBfqkbFIlu4AMYrFkXK6XlHtyFlO28/PNX8ueUOz/rpnm7BqE
 s6KjH04ReAw1hp9n+7Beh8pbQe0qz+hlEv2Pvc4+xnuE5IbYnhee3/h8ko0ILSpfFgBF
 7R0Q==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
In-Reply-To: <20200731161519.5f413f82@carbon>
Date: Tue, 4 Aug 2020 19:08:59 +0900
Content-Transfer-Encoding: quoted-printable
Message-Id: <46CD5E66-D554-473A-BE9A-9AC2EF8D16B1@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-4-git-send-email-komachi.yoshiki@gmail.com>
 <20200731161519.5f413f82@carbon>
Subject: Re: [Bridge] [RFC PATCH bpf-next 3/3] samples/bpf: Add a simple
 bridge example accelerated with XDP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, "David S. Miller" <davem@davemloft.net>


> 2020/07/31 23:15=E3=80=81Jesper Dangaard Brouer =
<brouer@redhat.com>=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB:
>=20
>=20
> I really appreciate that you are working on adding this helper.
> Some comments below.

Thanks! Find my response below, please.

> On Fri, 31 Jul 2020 13:44:20 +0900
> Yoshiki Komachi <komachi.yoshiki@gmail.com> wrote:
>=20
>> diff --git a/samples/bpf/xdp_bridge_kern.c =
b/samples/bpf/xdp_bridge_kern.c
>> new file mode 100644
>> index 000000000000..00f802503199
>> --- /dev/null
>> +++ b/samples/bpf/xdp_bridge_kern.c
>> @@ -0,0 +1,129 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2020 NTT Corp. All Rights Reserved.
>> + *
> [...]
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
>> +	__uint(key_size, sizeof(int));
>> +	__uint(value_size, sizeof(int));
>> +	__uint(max_entries, 64);
>> +} xdp_tx_ports SEC(".maps");
>> +
>> +static __always_inline int xdp_bridge_proto(struct xdp_md *ctx, u16 =
br_vlan_proto)
>> +{
>> +	void *data_end =3D (void *)(long)ctx->data_end;
>> +	void *data =3D (void *)(long)ctx->data;
>> +	struct bpf_fdb_lookup fdb_lookup_params;
>> +	struct vlan_hdr *vlan_hdr =3D NULL;
>> +	struct ethhdr *eth =3D data;
>> +	u16 h_proto;
>> +	u64 nh_off;
>> +	int rc;
>> +
>> +	nh_off =3D sizeof(*eth);
>> +	if (data + nh_off > data_end)
>> +		return XDP_DROP;
>> +
>> +	__builtin_memset(&fdb_lookup_params, 0, =
sizeof(fdb_lookup_params));
>> +
>> +	h_proto =3D eth->h_proto;
>> +
>> +	if (unlikely(ntohs(h_proto) < ETH_P_802_3_MIN))
>> +		return XDP_PASS;
>> +
>> +	/* Handle VLAN tagged packet */
>> +	if (h_proto =3D=3D br_vlan_proto) {
>> +		vlan_hdr =3D (void *)eth + nh_off;
>> +		nh_off +=3D sizeof(*vlan_hdr);
>> +		if ((void *)eth + nh_off > data_end)
>> +			return XDP_PASS;
>> +
>> +		fdb_lookup_params.vlan_id =3D =
ntohs(vlan_hdr->h_vlan_TCI) &
>> +					VLAN_VID_MASK;
>> +	}
>> +
>> +	/* FIXME: Although Linux bridge provides us with vlan filtering =
(contains
>> +	 * PVID) at ingress, the feature is currently unsupported in =
this XDP program.
>> +	 *
>> +	 * Two ideas to realize the vlan filtering are below:
>> +	 *   1. usespace daemon monitors bridge vlan events and notifies =
XDP programs
>                   ^^
> Typo: usespace -> userspace

I will fix this in the next version.

>> +	 *      of them through BPF maps
>> +	 *   2. introduce another bpf helper to retrieve bridge vlan =
information
>=20
> The comment appears two times time this file.

I was aiming to show future implementation of the vlan filtering at =
ingress (not egress) to
be required here by the above comment.

>> +	 *
>> +	 *
>> +	 * FIXME: After the vlan filtering, learning feature is required =
here, but
>> +	 * it is currently unsupported as well. If another bpf helper =
for learning
>> +	 * is accepted, the processing could be implemented in the =
future.
>> +	 */
>> +
>> +	memcpy(&fdb_lookup_params.addr, eth->h_dest, ETH_ALEN);
>> +
>> +	/* Note: This program definitely takes ifindex of ingress =
interface as
>> +	 * a bridge port. Linux networking devices can be stacked and =
physical
>> +	 * interfaces are not necessarily slaves of bridges (e.g., =
bonding or
>> +	 * vlan devices can be slaves of bridges), but stacked bridge =
ports are
>> +	 * currently unsupported in this program. In such cases, XDP =
programs
>> +	 * should be attached to a lower device in order to process =
packets with
>> +	 * higher speed. Then, a new bpf helper to find upper devices =
will be
>> +	 * required here in the future because they will be registered =
on FDB
>> +	 * in the kernel.
>> +	 */
>> +	fdb_lookup_params.ifindex =3D ctx->ingress_ifindex;
>> +
>> +	rc =3D bpf_fdb_lookup(ctx, &fdb_lookup_params, =
sizeof(fdb_lookup_params), 0);
>> +	if (rc !=3D BPF_FDB_LKUP_RET_SUCCESS) {
>> +		/* In cases of flooding, XDP_PASS will be returned here =
*/
>> +		return XDP_PASS;
>> +	}
>> +
>> +	/* FIXME: Although Linux bridge provides us with vlan filtering =
(contains
>> +	 * untagged policy) at egress as well, the feature is currently =
unsupported
>> +	 * in this XDP program.
>> +	 *
>> +	 * Two ideas to realize the vlan filtering are below:
>> +	 *   1. usespace daemon monitors bridge vlan events and notifies =
XDP programs
>> +	 *      of them through BPF maps
>> +	 *   2. introduce another bpf helper to retrieve bridge vlan =
information
>> +	 */
>=20
> (2nd time the comment appears)

The 2nd one is marking for future implementation of the egress =
filtering.

Sorry for confusing you. I will try to remove the redundancy and =
confusion.

>> +
>=20
> A comment about below bpf_redirect_map() would be good.  Explaining
> that we depend on fallback behavior, to let normal bridge code handle
> other cases (e.g. flood/broadcast). And also that if lookup fails,
> XDP_PASS/fallback also happens.

In this example, flooded packets will be transferred to the upper normal =
bridge by not the
bpf_redirect_map() call but the XDP_PASS action as below:

+	rc =3D bpf_fdb_lookup(ctx, &fdb_lookup_params, =
sizeof(fdb_lookup_params), 0);
+	if (rc !=3D BPF_FDB_LKUP_RET_SUCCESS) {
+		/* In cases of flooding, XDP_PASS will be returned here =
*/
+		return XDP_PASS;
+	}

Thus, such a comment should be described as above, IMO.

Thanks & Best regards,

>> +	return bpf_redirect_map(&xdp_tx_ports, =
fdb_lookup_params.ifindex, XDP_PASS);
>> +}
>> +
>> +SEC("xdp_bridge")
>> +int xdp_bridge_prog(struct xdp_md *ctx)
>> +{
>> +	return xdp_bridge_proto(ctx, 0);
>> +}
>> +
>> +SEC("xdp_8021q_bridge")
>> +int xdp_8021q_bridge_prog(struct xdp_md *ctx)
>> +{
>> +	return xdp_bridge_proto(ctx, htons(ETH_P_8021Q));
>> +}
>> +
>> +SEC("xdp_8021ad_bridge")
>> +int xdp_8021ad_bridge_prog(struct xdp_md *ctx)
>> +{
>> +	return xdp_bridge_proto(ctx, htons(ETH_P_8021AD));
>> +}
>> +
>> +char _license[] SEC("license") =3D "GPL";
>=20
>=20
> --=20
> Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: http://www.linkedin.com/in/brouer
>=20

=E2=80=94
Yoshiki Komachi
komachi.yoshiki@gmail.com

