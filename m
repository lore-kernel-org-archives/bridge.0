Return-Path: <john.fastabend@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:message-id:in-reply-to:references:subject
 :mime-version:content-transfer-encoding;
 bh=u0WnrEEbki1i/hcaafYSzslvQ7FMlY7zypF99r+3B/o=;
 b=c/MJnMa7iFlRBOG02m0T54NzFYPRsxOii1CeQ16KYQkd4QKokIa0N/RND9PSnQzmJx
 he9XFY1jf5LZkpWxNbD2SAbwnXGmTsUf+VIG9o6VK8HcaUB6LUdwqB6beOhniK9hlW00
 Ey4PLP49xYvfKkd8cAiURWATEuBPmZvqdnM2gDOnRfJUjd5FHSivmvmcYbazmgN6gE4B
 ApzN7hy16Bcmn9cYtU1venxzbdUkcaoGF0JmfArVDW++ro0Vr2c7RbREEBR3VlyEcYn9
 JKWbYSAeva3koTpN+9Jun6O6QJ+r3yZn4oqqeVj8ldWj70afnW8AmqVF/7rG5JjcSKuM
 OYSg==
Date: Fri, 31 Jul 2020 14:52:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
Message-ID: <5f2492aedba05_54fa2b1d9fe285b42d@john-XPS-13-9370.notmuch>
In-Reply-To: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [RFC PATCH bpf-next 0/3] Add a new bpf helper for FDB
	lookup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Yoshiki Komachi <komachi.yoshiki@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, KP Singh <kpsingh@chromium.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bridge@lists.linux-foundation.org, Yoshiki Komachi <komachi.yoshiki@gmail.com>

Yoshiki Komachi wrote:
> This series adds a new bpf helper for doing FDB lookup in the kernel
> tables from XDP programs. This helps users to accelerate Linux bridge
> with XDP.
> =

> In the past, XDP generally required users to reimplement their own
> networking functionalities with specific manners of BPF programming
> by themselves, hindering=C2=A0its=C2=A0potential=C2=A0uses. IMO, bpf he=
lpers to
> access networking stacks in kernel help to mitigate the programming
> costs because users reuse mature Linux networking feature more easily.
> =

> The previous commit 87f5fc7e48dd ("bpf: Provide helper to do forwarding=

> lookups in kernel FIB table") have already added a bpf helper for acces=
s
> FIB in the kernel tables from XDP programs. As a next step, this series=

> introduces the API for FDB lookup. In the future, other bpf helpers for=

> learning and VLAN filtering will also be required in order to realize
> fast XDP-based bridge although these are not included in this series.

Just to clarify for myself. I expect that with just the helpers here
we should only expect static configurations to work, e.g. any learning
and/or aging is not likely to work if we do redirects in the XDP path.

Then next to get a learning/filtering/aging we would need to have a
set of bridge helpers to get that functionality as well? I believe
I'm just repeating what you are saying above, but wanted to check.

Then my next question is can we see some performance numbers? These
things are always trade-off between performance and ease of
use, but would be good to know roughly what we are looking at vs
a native XDP bridge functionality.

Do you have a use case for a static bridge setup? Nothing wrong to
stage things IMO if the 'real' use case needs learning and filtering.

I guess to get STP working you would minimally need learning and
aging?

Thanks,
John=
