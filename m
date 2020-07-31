Return-Path: <andrii.nakryiko@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7yuTOXkhnjtQaEm9idGZaO/zfXegMB7ywvDDyNQyj/I=;
 b=Ia2KG8Dg+BQsHF7ZvXuqhVIIBXIEfPHODcfnL2p5ZboFoSn9gTATt5RC0apvua39Hk
 HdaIBqspB9J4V0exyzKhHQoo5hJcRMKO3jb99ftPqkLACSyTaBO+vU3hGwvRVG0Mkg3O
 XNcFh05JPS/txkOomOZQ0DqaK6erwgFsy2e5T1w2p562foq96lFZPfZ9oPSgHasLEuaS
 wAJLELm7a5mQXCzR4L68bqSRsxxXFcnI8mDwBw+9vth3cnfOu27NHeT8vn775fzCw3ku
 VajG0UgaXUiv0ntVgRB656n01g3b6EkUexByh7gvYQ6yz6rSP48rqTABWFwTKrPk0fBg
 waoA==
MIME-Version: 1.0
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <1596170660-5582-4-git-send-email-komachi.yoshiki@gmail.com>
In-Reply-To: <1596170660-5582-4-git-send-email-komachi.yoshiki@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 Jul 2020 10:48:18 -0700
Message-ID: <CAEf4BzaRKhJqFmXJEQy5LOjKx9nkPgAKHa3cesvywy2qqg93YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Networking <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <kafai@fb.com>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>, "David S. Miller" <davem@davemloft.net>

On Thu, Jul 30, 2020 at 9:45 PM Yoshiki Komachi
<komachi.yoshiki@gmail.com> wrote:
>
> This patch adds a simple example of XDP-based bridge with the new
> bpf_fdb_lookup helper. This program simply forwards packets based
> on the destination port given by FDB in the kernel. Note that both
> vlan filtering and learning features are currently unsupported in
> this example.
>
> There is another plan to recreate a userspace application
> (xdp_bridge_user.c) as a daemon process, which helps to automate
> not only detection of status changes in bridge port but also
> handling vlan protocol updates.
>
> Note: David Ahern suggested a new bpf helper [1] to get master
> vlan/bonding devices in XDP programs attached to their slaves
> when the master vlan/bonding devices are bridge ports. If this
> idea is accepted and the helper is introduced in the future, we
> can handle interfaces slaved to vlan/bonding devices in this
> sample by calling the suggested bpf helper (I guess it can get
> vlan/bonding ifindex from their slave ifindex). Notice that we
> don't need to change bpf_fdb_lookup() API to use such a feature,
> but we just need to modify bpf programs like this sample.
>
> [1]: http://vger.kernel.org/lpc-networking2018.html#session-1
>
> Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
> ---

Have you tried using a BPF skeleton for this? It could have saved a
bunch of mechanical code for your example. Also libbpf supports map
pinning out of the box now, I wonder if it would just work in your
case. Also it would be nice if you tried using BPF link-based approach
for this example, to show how it can be used. Thanks!


>  samples/bpf/Makefile          |   3 +
>  samples/bpf/xdp_bridge_kern.c | 129 ++++++++++++++++++
>  samples/bpf/xdp_bridge_user.c | 239 ++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 samples/bpf/xdp_bridge_kern.c
>  create mode 100644 samples/bpf/xdp_bridge_user.c
>

[...]
