Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092171;
	b=C3c/rBM+svT/1nezf7iWCTkCE169annJV0BqwFqH3YjKPcIkMJpdXsIl3N5hsI8h3MF+
	 D1dKTGtDZRdHQhAm/Oo89ZK4Eff3+l0hLYVtGjCXNZlQT1gwnc5QJr7TQXDJjpDU1+lfo
	 E+v7Jbi++JTOT/Lxc3vwVe0Tr3XuXVfsQFxI5Ai8fdzwzQ2AFwv+Fi29WJvSMoMQeKe8/
	 M7S1BIE3wHR8XJFcgQox94zrQjR0szGVtMRX01+eZEO1RDo4ZSE32OgmnrXy/XNuJt3d/
	 dp65NQbD0d7XdxEORHI9Gb/A+NrNyotXaRVAPs59NFZe+GZFjupUXJHhuHKGnQgYapQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092171;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VT3Y5OvSFbO9QB1vLrL/JDIAFG6W923q7UqKoS0saRw=;
	b=u7wmgDy9zO75O5JufkzGlnI+qswGEErB7/Zq3juOLwGgiRhjin8/ccnaFhec1iP7ny/F
	 bJXgcDRKhd1LE/yYDxQEC9aLAqcitlichvYkGxeFCBpQ3pul7jGhpm7kpEMugbxksY/JY
	 dinw24a0CYRI2gHvTac6XERNXAWotQ8n6DbvXywAseXBSOisc27MTEiNb0LhJE0aCK84u
	 A+hljrBhrlXLpaBAvaRPBFvuyAhuRptCkr6+cnec9Fvsi3XIpETt3jC9PQAmqqW08AcL/
	 pVllJY9n9QzIWLAdW5BkcQGVmZJoQ6CRJahjqxwLimcAK1fWKpNCisblDYsZhcG/kNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL6g0cDE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A9606A31A
	for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gL6g0cDE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657EB1F031E2
	for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092170;
	bh=VT3Y5OvSFbO9QB1vLrL/JDIAFG6W923q7UqKoS0saRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gL6g0cDE/fM1YcljoA1aZnBkluyETfSVdCPCFznt39+S1LfqX3W7PXafW2wNDlgYC
	 Hu+y4trakWqb+ewn7BqriCAIhkt0cawB9tPQ21k4vGD12sliSPExBxINuJxv2rQotr
	 vNDOCC/e1xCvkCGiWU8EzPqlORFljrhhZ2/AIe1AqHBZgJ2kp8cv2NPWpscdff3UUQ
	 vA8WqiGKhwBKQUj4QIKqzNunDhvnOAIJ4Kl6wTo1DiCt6gDREEwwCyQKCJkGGfTZpw
	 EBg/NC6iNMSupxIDQeZ2UmHxXbGEwAfzhWo5W6tsOVBigBCnOwL+4lY/WSBItmSvb3
	 AO3lKl6893s+Q==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so25436681fa.0
        for <bridge@lists.linux.dev>; Tue, 27 Oct 2026 02:09:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy6dtkNbqrSTEBpPoOJDTV3sKM+YG4MkNNBJYFhmeD5RubxG3pIyrpbIqIxSAWGZAL0BJ5vsZQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYJDRzD6Nyxj6u2IC9XgfNuISgMRBPQ7I6dEV+V7QkxOeOMyI3fF
	d9zOV/X7EDAagtweEgu+0tryhkowbky/6V24s5e9pZaka+K5TZD3Qb3PJK1vHFyut7Fgj5axTfr
	qpRjcgUjL8re7iygFU5vWOoYf2wZpsl4=
X-Received: by 2002:a05:651c:1444:b0:3ab:5423:dd80 with SMTP id
 38308e7fff4ca-3ac6fce6af2mr24493581fa.9.1793092169187; Tue, 27 Oct 2026
 02:09:29 -0700 (PDT)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027085200.1501599-1-xiaolinkui@126.com>
In-Reply-To: <20261027085200.1501599-1-xiaolinkui@126.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 10:09:16 +0100
X-Gmail-Original-Message-ID: <CAL4WiioJcbB9gB7tbBcwLdRUPG=zX-5B-7G5=oMXGiy=f_WLSg@mail.gmail.com>
X-Gm-Features: AclHuK8EVwFrXUj1qFMsxab1jfMHpLxrzYP4DKEcT8xEm71gKtZLAmqWJRAV0jE
Message-ID: <CAL4WiioJcbB9gB7tbBcwLdRUPG=zX-5B-7G5=oMXGiy=f_WLSg@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: netlink: do not clear the vlan info dump error
To: Linkui Xiao <xiaolinkui@126.com>
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 09:52, Linkui Xiao <xiaolinkui@126.com> a =C3=
=A9crit :
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> br_fill_ifinfo() assigns the result of br_fill_vlan_tunnel_info() over
> the result of br_fill_ifvlaninfo() or br_fill_ifvlaninfo_compressed()
> instead of only running the second helper when the first one succeeded.
>
> When the vlan information no longer fits in the skb but the port has no
> vlan mapped to a tunnel dst, br_fill_vlan_tunnel_info() walks the vlan
> list and returns 0 without touching the skb. The -EMSGSIZE is lost,
> br_fill_ifinfo() completes a message whose IFLA_AF_SPEC is truncated,
> and the dump carries on to the next interface instead of stopping, so
> userspace silently sees an incomplete vlan list.
>
> Only fill the tunnel information when the vlan information was filled
> successfully.
>
> This was flagged as a pre-existing issue in the Sashiko review of the
> net-next series, which noted that the VLAN fill result is overwritten
> before it is tested (see the Link tag below).
>
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Link: https://lore.kernel.org/bridge/ed1de95e-e112-4076-93f0-6f7668e657ad=
@blackwall.org/T/#u#5
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
