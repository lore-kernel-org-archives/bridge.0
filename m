Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EVtHDL3zK/M7ogfJLTnbqUj/+R1pnCu3LmpkYrXn7WI=;
 b=Us1H8RGxl87Uo//uGLeMoVDoUUO7W76DnC/ipQAIIFV8i6WnVTplLysjyIoSaotcVm
 BinZfOIVf1SRbwpyuGfHnCC2LizudABFRJX3N/GbgqBZtjeXnKFzd9bp1NUfEkfmSDD3
 484fJybh/iCN6DzYi3W3P6RgJTGDrpTair67iLqu6WU6aZOG3llDGadYM2ik0OS9xXTg
 o2ro+Txb4QQutHAp564nZWJId0a8eq35hIKo6/bilITKuDiWYMpcA8xN7ccHTPJgzbYV
 omIq5Wbf2uOdQsV5oqHHgzPYhYsYKJnUZNZuYBxIOGMpNGMbHXTP+Z5H3B64Sj3Eofdk
 benw==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
In-Reply-To: <8eda2f23-f526-bd56-b6ac-0d7ae82444b5@gmail.com>
Date: Fri, 7 Aug 2020 17:30:16 +0900
Content-Transfer-Encoding: quoted-printable
Message-Id: <901DF60C-F4DD-4125-80D6-128C1764424F@gmail.com>
References: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
 <5f2492aedba05_54fa2b1d9fe285b42d@john-XPS-13-9370.notmuch>
 <E2A7CC68-9235-4E97-9532-66D61A6B8965@gmail.com>
 <8eda2f23-f526-bd56-b6ac-0d7ae82444b5@gmail.com>
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
To: David Ahern <dsahern@gmail.com>, John Fastabend <john.fastabend@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Networking <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>, Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>


> 2020/08/06 1:36=E3=80=81David Ahern <dsahern@gmail.com>=E3=81=AE=E3=83=A1=
=E3=83=BC=E3=83=AB:
>=20
> On 8/5/20 4:26 AM, Yoshiki Komachi wrote:
>>>=20
>>> Just to clarify for myself. I expect that with just the helpers here
>>> we should only expect static configurations to work, e.g. any =
learning
>>> and/or aging is not likely to work if we do redirects in the XDP =
path.
>>=20
>> As you described above, learning and aging don=E2=80=99t work at this =
point.=20
>>=20
>> IMO, another helper for learning will be required to fill the =
requirements.
>> I guess that the helper will enable us to use the aging feature as =
well
>> because the aging is the functionality of bridge fdb.
>=20
> One option is to have a flag that bumps the ageing on successful =
lookup
> and do that in 1 call. You will already have access to the fdb entry.

It seems like a good idea to me! I guess that the flags in my suggested =
bpf
helper for the FDB lookup will be useful for such a case.

Thanks & Best regards,

=E2=80=94
Yoshiki Komachi
komachi.yoshiki@gmail.com

