Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=2ca/QrowQ6tGL3YlTY/zRzYbbmOdjci7HQ5UaZxrd7U=;
 b=uhLd9SNImtAJuG345pumkWc7FFAQzZbxGRfbrVJwZOpFi4CFPdRWTGdoq2H3T0vOIf
 MaMUXqtaXYbapCXrNGKUHCPvOvPbH48p3S+Lh/MiWYGV70NumnYN01whEEXCcC74VfSJ
 O+pReSH2YR+ZeXiNNx+NYXjlSQwbhY19LtlSyzYFXKPo4O7Om7yX5vj574VhSms6uEu6
 ijHHACvc1QRuoqvMh/oNutsSd8CJAsXocXVTOQRMMuGbtKpzTcsUbMKndywIf6YmdZV8
 cDsbV5FXHNaBwFpLZF9sHJ8u/+LIDFjL7JU4YIg25KyMSCRnpW5U24qhJfGEVDtRBOpV
 0oBg==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
In-Reply-To: <CAEf4BzaRKhJqFmXJEQy5LOjKx9nkPgAKHa3cesvywy2qqg93YA@mail.gmail.com>
Date: Tue, 4 Aug 2020 19:35:08 +0900
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BA4E035-5045-4D62-BA39-F3990CA4EF1E@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-4-git-send-email-komachi.yoshiki@gmail.com>
 <CAEf4BzaRKhJqFmXJEQy5LOjKx9nkPgAKHa3cesvywy2qqg93YA@mail.gmail.com>
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Networking <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>, "David S. Miller" <davem@davemloft.net>


> 2020/08/01 2:48=E3=80=81Andrii Nakryiko =
<andrii.nakryiko@gmail.com>=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB:
>=20
> On Thu, Jul 30, 2020 at 9:45 PM Yoshiki Komachi
> <komachi.yoshiki@gmail.com> wrote:
>>=20
>> This patch adds a simple example of XDP-based bridge with the new
>> bpf_fdb_lookup helper. This program simply forwards packets based
>> on the destination port given by FDB in the kernel. Note that both
>> vlan filtering and learning features are currently unsupported in
>> this example.
>>=20
>> There is another plan to recreate a userspace application
>> (xdp_bridge_user.c) as a daemon process, which helps to automate
>> not only detection of status changes in bridge port but also
>> handling vlan protocol updates.
>>=20
>> Note: David Ahern suggested a new bpf helper [1] to get master
>> vlan/bonding devices in XDP programs attached to their slaves
>> when the master vlan/bonding devices are bridge ports. If this
>> idea is accepted and the helper is introduced in the future, we
>> can handle interfaces slaved to vlan/bonding devices in this
>> sample by calling the suggested bpf helper (I guess it can get
>> vlan/bonding ifindex from their slave ifindex). Notice that we
>> don't need to change bpf_fdb_lookup() API to use such a feature,
>> but we just need to modify bpf programs like this sample.
>>=20
>> [1]: http://vger.kernel.org/lpc-networking2018.html#session-1
>>=20
>> Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
>> ---
>=20
> Have you tried using a BPF skeleton for this? It could have saved a
> bunch of mechanical code for your example. Also libbpf supports map
> pinning out of the box now, I wonder if it would just work in your
> case. Also it would be nice if you tried using BPF link-based approach
> for this example, to show how it can be used. Thanks!
>=20

It is still under consideration, but these features seems to be useful =
for
this example.

I would try to apply them in the next version.

Thank you for giving me good advice.

Best regards,

>=20
>> samples/bpf/Makefile          |   3 +
>> samples/bpf/xdp_bridge_kern.c | 129 ++++++++++++++++++
>> samples/bpf/xdp_bridge_user.c | 239 =
++++++++++++++++++++++++++++++++++
>> 3 files changed, 371 insertions(+)
>> create mode 100644 samples/bpf/xdp_bridge_kern.c
>> create mode 100644 samples/bpf/xdp_bridge_user.c
>>=20
>=20
> [...]

=E2=80=94
Yoshiki Komachi
komachi.yoshiki@gmail.com

