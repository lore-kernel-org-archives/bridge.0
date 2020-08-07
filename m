Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=4XLPHo6ufXjqCRDRX6dlamDg8saN7x8jg/SbIqu516I=;
 b=fNAJf5Jqo/OU8MSnbks8APaPlFcPTPed8hIm+RF5uEP0MVlFRE51bceB9XUr97PQOy
 t6JhhXMLqUxUYPRhiV5Yk1xKUw8Ize2YilArRhUK6PbX1zZxbzxL7mGxtkTUFatf3xll
 KoUvM2lP7agOvM+akXjePCzMdgYg/X+PlOlZdn5eDXtURGPCItCgGqfuIlBTNuDfJj3D
 7TnsxcrRYWps8jln59GtRWMo2qM6VyQ3yARXqFDFYvVUg6OCWZiUVYueGX8WkkjGLkoE
 YDa3/nZKhZx3hCu8N6Xb+GIvHiJU4EuLktAM83d5WbjLPv6M4CELkaqtZp66hsIXbo3S
 szYg==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
In-Reply-To: <e92455ce-3a3f-7c52-1388-da40e8ceefd0@gmail.com>
Date: Fri, 7 Aug 2020 17:06:41 +0900
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B486A33-7A46-436A-A563-80F842A16F23@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-3-git-send-email-komachi.yoshiki@gmail.com>
 <5970d82b-3bb9-c78f-c53a-8a1c95a1fad7@gmail.com>
 <F99B20F3-4F88-4AFC-9DF8-B32EFD417785@gmail.com>
 <e92455ce-3a3f-7c52-1388-da40e8ceefd0@gmail.com>
Subject: Re: [Bridge] [RFC PATCH bpf-next 2/3] bpf: Add helper to do
 forwarding lookups in kernel FDB table
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, "David S. Miller" <davem@davemloft.net>


> 2020/08/06 1:38=E3=80=81David Ahern <dsahern@gmail.com>=E3=81=AE=E3=83=A1=
=E3=83=BC=E3=83=AB:
>=20
> On 8/4/20 5:27 AM, Yoshiki Komachi wrote:
>>=20
>> I guess that no build errors will occur because the API is allowed =
when
>> CONFIG_BRIDGE is enabled.
>>=20
>> I successfully build my kernel applying this patch, and I don=E2=80=99t=
 receive any
>> messages from build robots for now.
>=20
> If CONFIG_BRIDGE is a module, build should fail: filter.c is built-in
> trying to access a symbol from module.

When I tried building my kernel with CONFIG_BRIDGE set as a module, I =
got
the following error as you pointed out:

    ld: net/core/filter.o: in function `____bpf_xdp_fdb_lookup':
    /root/bpf-next/net/core/filter.c:5108: undefined reference to =
`br_fdb_find_port_xdp'

It may be necessary to fix it to support kernels built with =
CONFIG_BRIDGE set
as a mfodule, so let me make sure if it should be called via netdev ops =
to get
destination port in a bridge again.

Thanks & Best regards,


=E2=80=94
Yoshiki Komachi
komachi.yoshiki@gmail.com

