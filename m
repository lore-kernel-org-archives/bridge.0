Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C07286419
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212285; cv=pass; b=Ljr5Xfb/dixziGhpsw7ZZeUDKzlaWa/KF4+w/yJ81SKeiYkIBa32gUgv+trEniLAkMsSrNWQfA/0EPvx67A6Rxb+n9mE0EVGfpagIkz9UklM5bVpgjY8k0t9lA+rSpDo33hUDiA8JjXItOSMOVujqeZb9vd9J6zBh4oi2uDNr2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212285; c=relaxed/simple;
	bh=aovUneDvP1GBNolJAjVlVkkQADn5zmmkErYFqtVNwNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiZliLqCQqxewvrGyA83ruwO4L1vzagmj5RwdjiOaWIoe+6wFD6OeDDqFEaH6E10K8a7K+2mI+ZilLdAA07zaUKr5/zlkQ393Ki5KpQF0EPCMjWkNZQuAg8DIRK3n+grDXp7UVNJ1pW1++PlD+7swyMSPVwuXjFjvowJrBZJgdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs0UTRGL; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs0UTRGL"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so255519366b.1
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 03:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775212281; cv=none;
        d=google.com; s=arc-20240605;
        b=EmVd+wS67GSpxij2P10Fb1VSznxVDmYWDBO1dD6QnC5wN3WqwFCJSIxdFEEQxBHcVl
         z0H5wtzoWuox1QGCVxk3JzaCnWzFovpAjBdkjeqkYzeTP4QNyOrTpQMq4QQDYK6abs+3
         exu1oFeuTzmOg5Y+kqI89daZI7wba8+bKSMIpUbZSJNhl8CwJ2K1Eh6QC6JxdowHftXB
         +Xy47GAsYb1sAOwTBhk4r+8r3ZZeJCuRqfxT4kUSIHWVI7s/lTCDmTER3S6z5iYlmvep
         YiCYKnEcXy07nkIzbUPJrW41oemeszKDKkio3HpzqIHPom65Y5CyH1zeS1o4lh8xlMqf
         YuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHwL4zXImEU/IfCJ7oBNFaaImV63q09hkn+e/UcNPOA=;
        fh=Syq58Cuga+ap1qJUZHxNxm5Myi0jHD7tXP7oUfdGOGc=;
        b=UNiWQgZU5eNM76Fs0YeJsiYZgZbg6aVg7/8vDym2CsBjjbafgcMF4/0JpbSR9EGSoe
         Aaufo6k/C08f27XlG4q7Hq73BWN+OsBdU9H0UrKa1HmwzyB/Mywii9BXOPmXVizy8p6a
         XVt2Cu42PAnkuLLRXcaTIwaBaFaMhfVrXE7nde0I0fBoYaYyg19lHHCgjpR2P/Toa1JV
         U6TIp9HDYZau2mppPh5HAWbBPpB82kxroBIeH06WT4WL9aAkGaFN1ZkNC71WE5490nBk
         gjLp1+eTgMiEvOiQ1xqUG3h93LBY4109DtNROnOjsvFTyzTmyld7MnkT+r0c6W9GjfCz
         d2Ow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775212281; x=1775817081; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHwL4zXImEU/IfCJ7oBNFaaImV63q09hkn+e/UcNPOA=;
        b=bs0UTRGLeTXZt+rz3UyeFaA4x7w/D1nS7owXmWCE9Pcb7z5Glw2HonP+yRyf23qgvH
         Sk74elBBR5ejNZZRSVH9/t2kjv+YHNAhX0wwgXssLUxOEMVXeMuHs2YpDb8LTPOCpcDg
         FItHYm7LhBH8KIZz2DYYUx9jXgULLz1ivumYMLNIOggE539D7MpzzALF750b+pgniKhB
         zaUL6pcq+rY5Ncr7BxmyTwaX/InZATIyUUFdgNTmbKVVS5uAfeNerKR3VR/DqskK4ky3
         qRZFGo9oouRuN7d23n8Vz8qlqU6IWHVESk/JsK1JvXgnEsZim2IZKGn1rSfYq7kxdn09
         kZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775212281; x=1775817081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHwL4zXImEU/IfCJ7oBNFaaImV63q09hkn+e/UcNPOA=;
        b=nlZ611/G3NE1+Jvx6D2ROx5qCnN5Z/CY9LsIu9VWnyn85R2Kjpk6alFV72raiSAp8E
         PHXZCjyEFZRwBwmwVTt1N+bpzJcYZJlgXhN4EC0sxe/4uZCuycbkUzFm4ArWAMM3SdOj
         uGdmwxEdFImpOO5IeKW4NSjWqHeM8Iydzb0PgJN3MIGfyoVVnkJPcXZI51GgbGTu3056
         y96h0TTHIvdxt4UuIMyGkYLBEj/b639VTx9l2eMLleoueCgFPHjwoZWlFC9Gv2VSn1oL
         kezdLwqjfBuEI11N2CGwtyGv38/IYibVcuuuvOyUW+oht9zrNWcNv7Vzu7UWa0NWFZA2
         CkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzoYcjZP2AqO9eysNDGrmFqr2groIg9rBTBlDkOkJmyYs9rVobak87EtlKMULQnObuSzvAvTs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMAGtIDeRkv2Xhg8wg1C9Sz/+UzfGEp34KP7QslUHAsYDSsIe2
	1IQEkToqC29D/23iYtZ/59f9RVmB5oTThupg8NF21g0pvzHa8+4SwXaqahTyjKSJxzMWvDoCwCQ
	e/7ejJjl+eCxtx2W8jGsxMHN6ZRrIntc=
X-Gm-Gg: AeBDieumC/X5vQTOazvUkdNjpdl2GuZDOXQI+e0Xcc9aNdvXDDaPev6kDEQtsOk6LeL
	ro/Gg+e5+7URosIyuK+qmHQmDFmKf3e6COruNSyruXAMLcBl6KNh/WIB+hWikan0Zr8OlfBmyMS
	cGLW8Oy4VVVhRZKHrBr313+OzASsGyepzECXdMKyz1lp7j6F4V1MBbOEGPGrZlof68ILDc1acRG
	VJtBdCoJNUi6YDLc40ltzr3LpEI9pBq9SDPEueCGXMJ38eLBROn8B6mnMejVIPuabtlQXQyPqHX
	980uojY=
X-Received: by 2002:a17:907:d005:b0:b9c:393b:f6a4 with SMTP id
 a640c23a62f3a-b9c679adcd8mr122872766b.28.1775212281230; Fri, 03 Apr 2026
 03:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com> <20260330191611.16929-6-royujjal@gmail.com>
 <20260331141347.GA1637150@shredder> <CAE2MWkn3gPc1kBwy2p7r5bx6QozMStM0N6oEutT7g7GnJrKteA@mail.gmail.com>
 <20260403101944.GA66518@shredder>
In-Reply-To: <20260403101944.GA66518@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 3 Apr 2026 16:01:05 +0530
X-Gm-Features: AQROBzBqpVc7_CAPXcQpzbI6yBbYR-8a-svH1NtOipIeuqjLRiO89y7FSqh-KG4
Message-ID: <CAE2MWkk0_B78wEnt+NwrCZ0653W_BHxNWjT+7F70KWHtmiugKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/5] selftests: net: bridge: add tests for
 igmpv3 MRC and QQIC validation
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 3:49=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
[...]
>
> Is there a reason to place them in bridge_vlan_mcast.sh given they are
> not specific to the per-VLAN multicast context? bridge_{igmp,mld}.sh
> looks like a better fit.

I could see the framework is ready to validate using
bridge_vlan_mcast.sh script. Just had to apply a new tc rule to
validate QEURY+MRC/QQIC fields. Something like this.

                tc filter add dev $dev egress pref 10 prot 802.1Q \
                        flower vlan_id 10 vlan_ethtype ipv4 dst_ip
224.0.0.1 ip_proto 2 \
+                       action continue
+               # AND Type 0x11 (Query) at offset 24 after IP
+               # IP (20 byte IP + 4 bytes Option)
+               tc filter add dev $dev egress pref 20 prot 802.1Q u32 \
+                       match u8 0x11 0xff at 24 $intvl_match \
                        action pass

And writing a few lines will validate the test for IGMPv3 QQIC non
linear value of 160s.
+       RET=3D0
+       bridge vlan global set vid 10 dev br0 mcast_snooping 1
mcast_query_interval 16000
+       check_err $? "Could not set mcast_query_interval in vlan 10"
+       log_test "Vlan 10 mcast_query_interval option changed to 16000"
+       # 1 is sent immediately, IGMPv3 QQIC should match with non
linear value 160s
+       vlmc_check_query igmp 3 $swp1 1 1 160
+       check_err $? "Wrong QQIC in sent tagged IGMPv3 general queries"
+       log_test "Vlan 10 mcast_query_interval in IGMPv3 is 160"

>
[...]
> > Vlan 10 mcast_query_interval:
> > TEST: Number of tagged IGMPv2 general query                         [ O=
K ]
> > TEST: IGMPv3 QQIC linear value 60                                   [ O=
K ]
> > TEST: IGMPv3 QQIC non linear value 160                              [ O=
K ]
> > TEST: MLDv2 QQIC linear value 60                                    [ O=
K ]
> > TEST: MLDv2 QQIC non linear value 160                               [ O=
K ]
>
> I find the latter clearer.

I thought so, hence asked which would be a better version of log.
Thanks for clearing it.
