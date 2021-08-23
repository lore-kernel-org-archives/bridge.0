Return-Path: <l4stpr0gr4m@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MaBl3rDtXESKyw3c63bPJNo7dg2UCFCV5le4IG3pXWo=;
 b=GbfZDaKnoXqjjhUOEGzo6BXu3i1+1SjQifDJV8eWlIzQ9++SCfEWOYg6yN7DqLP1Of
 NNunFBtWyyeoeiu2RuJa4zJgKCSAi88wl4IdP11bPwrelZfDo9IDr6H6OZxvH75Z1/QY
 J+9hkFB6rwPKuP9iZcF+rNCzJdW4SOBHQkDA8AOam9zc+qX0L7FHmwOMyR5YVM+uE8/8
 rDPAt3dXUUs1b2CVohBhOfiaTlDTXq/3xX03BPeStge8+5rNKBIHXQzZHdMoDbqa5GC2
 WYWzbbeb6KeCFlSR9kTe3l12UpPO5uxuFpqLfzoIanrPs7y5pJLW5PpRRyFb6YzQBcUz
 nSbQ==
MIME-Version: 1.0
References: <20210823061938.28240-1-l4stpr0gr4m@gmail.com>
 <13c1df91-be22-f4e0-cd61-7c99eb4e45f4@nvidia.com>
In-Reply-To: <13c1df91-be22-f4e0-cd61-7c99eb4e45f4@nvidia.com>
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Mon, 23 Aug 2021 18:12:31 +0900
Message-ID: <CAKW4uUyPdQ9hXeyjnC+5VS7zDaw+3sxy53HwOv2AxEZ7tngT=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] net: bridge: replace
	__vlan_hwaccel_put_tag with skb_vlan_push
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

2021=EB=85=84 8=EC=9B=94 23=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:00, N=
ikolay Aleksandrov <nikolay@nvidia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On 23/08/2021 09:19, Kangmin Park wrote:
>
> This changes behaviour though, I don't like changing code just for the sa=
ke of it.
> Perhaps the author had a reason to use hwaccel_put_tag instead. Before we=
 would
> just put hwaccel tag, now if there already is hwaccel tag we'll push it i=
nside
> the skb and then push the new tag in hwaccel. In fact I think you can eve=
n trigger
> the warning inside skb_vlan_push, so:
>
> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
>
>

Thanks for the review. I got it.
Then, how about cleanup by changing return type of
br_handle_ingress_vlan_tunnel()?
This function is only referenced in br_handle_frame(), and goto drop
when it return
non-zero. But, the ingress function always return 0, there is no
meaning for now.
If you think the cleanup is worth it, I'll send you a v2 patch.

Regards.
