Return-Path: <pabeni@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9670404B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42FB14040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675165629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viqpHWhPo/KOVRQlm6/EPChg5qrOk8FiTFF1q6ZWvFs=;
 b=Fo7vvvq4cpC5wiS0VrPOv8sP5i1DrF54KkajQJKGbiPyd7MGHZxrBN/rkdvrO790Ey1FKK
 mwlY3bIksYIXnhj8QH7g0cEzkDsqkUzhoTU4B7Hrzg74AasLOoa1FFAa8e5axeHP6hykjz
 re+5rbbz7s1tUBepjx9HEdSaW15mr88=
Message-ID: <801a4a44f0fb6e37f79037eae9a3db50191cdb12.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 31 Jan 2023 12:47:03 +0100
In-Reply-To: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
References: <c1a88f471a8aa6d780dde690e76b73ba15618b6d.1675010984.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v2] netlink: provide an ability to set
 default extack message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leon Romanovsky <leon@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>

Hello,

On Sun, 2023-01-29 at 18:51 +0200, Leon Romanovsky wrote:
> In netdev common pattern, extack pointer is forwarded to the drivers
> to be filled with error message. However, the caller can easily
> overwrite the filled message.
>=20
> Instead of adding multiple "if (!extack->_msg)" checks before any
> NL_SET_ERR_MSG() call, which appears after call to the driver, let's
> add new macro to common code.
>=20
> [1] https://lore.kernel.org/all/Y9Irgrgf3uxOjwUm@unreal
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

I'm sorry for nit-picking, but checkpatch complains the author
(leon@kernel.org) does not match the SoB tag. A v3 with a suitable
From: tag should fix that.

Thanks,

Paolo

