Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B6363C46
	for <bridge@lists.linux.dev>; Fri, 17 Apr 2026 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405446; cv=pass; b=UoCAtqVUXmqfiaI/Tue9N/OB5wh6QAY1hgVOvHe+xarSIK0sbFszreSS/pI9uyxInPEBWq5LpdGeXZbjsE5vAU3zWtjBgRTBPnUt4i0Bfc9tQem/zIK8BuAF56zJt0raJdzZHzuL1rG9ED8+vPfgwBmUzLTCeqcOw99RqF1Qcfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405446; c=relaxed/simple;
	bh=4fDLkAlPYl0zlshMTeD2bs7dYFbaoYKeX26/lmejc3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJHXrN6H+NrvMQjmnxXk2Hjg9RO2YVUy9kISTtn3K1jxoGY2x3bQv9sWcgTzyfxoEB8+8gruZgZ9gk0wH+HTxMMBJ/qbbvHf4mcdcNLw4i1qzNXkajIy/zU0TlRa1wR45gSD3FU1RPsNhr13u8MzZZizNuy9SgtfAnPawPtHlJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYb0fAYv; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYb0fAYv"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6714f678bdaso434827a12.3
        for <bridge@lists.linux.dev>; Thu, 16 Apr 2026 22:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776405443; cv=none;
        d=google.com; s=arc-20240605;
        b=Ts+1YFWvQvEPC3jhwc14Z89WrRwErVvb5dF5w60GWJnYQOymskvMqHr4e29MVjizoY
         S7gI2QEOE66CJUVJrZzO22cuiARnZ40bfQNNAz1AzwpI8fSwdK/eLkVaZWJRws9ulV0L
         scx9kjlbm3o+kT1qYwrinPnmDKDhpOqD8TMZ4ufOVX/pVhI8k6zHT5ZD1KsoU1EGcpYU
         ByNxUztv6ccAFwjudPJg8LBc16KisaX0ZYIp5YQGaiO8YyFOLl/5EsGQdEQVfSJH0Abr
         /bCj/e33EcsnTc9JL5Yo5KRIYRHl3KGrAgF2G00yWqB1rHZvhPRgYBHfnUIWKFA58N1K
         rYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qHJSbhAY5Hj1P+Kw9gp3GRgD56SU4QEL2uene58s+UQ=;
        fh=JFpVC+5gMe+3PhDvZI1f+Rch7EJeEblquf8/Xy96hCo=;
        b=YugDdsZLUxQxOIPIpeeO8JGZ1rgLxcSAy/BfQF/Z+JxWJGlerI09US86n+zDXob5oD
         Sohsay5vXJr/BM4Mr9Pp9zT3gqa4bNgVPOWUNBzKXwxCeTc4VwB6hQPeP/litfe05TTM
         QAE55xE8oc4L1Uw+xYXR3z3EhLRRn6jrvXZ+wjCuoezYku2leLp1Xq5HXpv9RaYp0Arq
         iahDqsBhOI8BCg+wUcCRAdUv78UFjfzITb3pP51T8IcO6nDwzVWlROlLLf6QXZAYpe2u
         1vJBSCBCqULTNpQG1dMJCDelFce0urXnvPNTSui9Per6IBLxh1pgueJy0ZxjQuGRl/Mh
         3Bcw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776405443; x=1777010243; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHJSbhAY5Hj1P+Kw9gp3GRgD56SU4QEL2uene58s+UQ=;
        b=sYb0fAYvOUke0++ffN4Ck8A3idufzMfkZD7i4kKQTy46sfKzTyPPUehmx+kjCrXp1b
         yG9Sui4YoIEuml8Yl90QBNmpZDvDzGzjYpBBjmvoHW8FEqgffqvjEATM+QyhfguprJSN
         JpaNNufmnV7BXR1L9hIUpxymtLEdJGs0y+pBKz2Nx8FrAYHE7oNbfDxOi32pSTsck1y9
         mQ5WYGkDPUtQkITfqkHXI9dS0zULRQa/t9X7e11FYF0WlBzU4bRlt2N+tvPVyDAo8c7K
         BWb7KCKUYh3/5X9rxsyGeMwjDYSfbhl9cce44nuuSQWegruk0lbSG9pC1JW/Ikl/ydOn
         S45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776405443; x=1777010243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHJSbhAY5Hj1P+Kw9gp3GRgD56SU4QEL2uene58s+UQ=;
        b=awuBXM/I+g3F4tOz8cQYYImdLKWX5SlcQk/uVsynZuUikDS14jLvI/k7TT8zJ3F7FJ
         VbaZTaF0XVCdQAUsK1oF4w4D+TX+gI7uGSbcOEwqneno+2X/9C+C9cqWopvvXEi97el2
         RHFFrzeU8ZYmH5gFYtlzZzFxEDTdXfexzqN6jxTSz2y63oz2TjcQgKS8HQAP7J2UCsIo
         aCmwzqVwjuiwHm1HT694ABOaNca6BAZRYp6arYbwDbMyd5aBcVMrRJpkcfv7RN+Z5bDa
         ua2zBFqTAXrPNrZNPfGlRHUQXLM8Xgk2DIK/J/tUKvpM/5XhiEs4BnCzRtuaV8NLGElD
         LIjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9alYKwk9cYiMjkknay0Yy5NffERGJsRK7ch3hjUiszTntUL9/5iBMX5abgttMquEs7triCk40=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyia21CoGMIUb4TYuNb8+KJ3WmtIvPVJiI7AEHxCfdNgGD6dbdU
	SQYNRHfJI7sNc1VgA6nCaArCWZhu7KCfp1hxImP0CC9a/UhQtgTAx76b/bnCTJkkeT3cZCT7fPP
	t1uS5as2MdElHrUJwS4jqqkbctFN77rg=
X-Gm-Gg: AeBDiesLYSVnIPoUci6R3RJA4arXDlVAXGEo7idHxvw41a/zyV0VVOjvUMUFKx8aZsN
	ZD6mMFAssgJESufalQD5Ghc0inMA9RHIj/+vWUt9BnwoGeJo2xYY99bcWlp93k1S8f0plDSZ5hj
	NTpJU3xBpr7QRKX/MOkt0RhBnLk/nQYuj9elPDn7ChFin9K2hvhkwl1eZjBENVm13RNss2pU6pu
	fPv/AIM2ByqasvYkrNs0LJBUS8FtNBUlKNUuuQUaV5f0GOc1lBGqLlSaziCiiHKZjgA/vqtVEl8
	UvTgIvP9D6zt0ZM5Sw==
X-Received: by 2002:a17:907:3e9e:b0:ba0:fb42:c254 with SMTP id
 a640c23a62f3a-ba41e4fc17fmr74134166b.33.1776405442662; Thu, 16 Apr 2026
 22:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260412111047.1326-1-royujjal@gmail.com> <20260412111047.1326-6-royujjal@gmail.com>
 <20260413084752.GD209364@shredder>
In-Reply-To: <20260413084752.GD209364@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 17 Apr 2026 11:27:06 +0530
X-Gm-Features: AQROBzB5fY-R1K2iDCJS4HRU-pTbet9wQAIZsnd7rkDVCi1swjpapiVgZRyU1jc
Message-ID: <CAE2MWkmvdAVMBvJ9xKgEzjJZ010=oY_ZoG==FBjHEisHEMrS8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/5] selftests: net: bridge: add MRC and QQIC
 field encoding tests
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

On Mon, Apr 13, 2026 at 2:18=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> See some comments below, but note that net-next is closed:
>
> https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/
>
> So you can either wait with v5 until it is open again or post it as RFC
> so that we can at least review (but not merge) it while net-next is
> closed.

Let me clear the changes asked here inline, so that I will be prepared
with v5 until net-next is open. You can ask me to send it as RFC v5,
if you have doubts about inline answers.

>
> On Sun, Apr 12, 2026 at 11:10:47AM +0000, Ujjal Roy wrote:
> > Enhance vlmc_query_intvl_test and vlmc_query_response_intvl_test in
> > bridge_vlan_mcast.sh to validate IGMPv3/MLDv2 protocol compliance for
> > MRC and QQIC field encoding across both linear and exponential ranges.
> >
> > TEST: Vlan multicast snooping enable                                [ O=
K ]
> > TEST: Vlan mcast_query_interval global option default value         [ O=
K ]
> > INFO: Vlan 10 mcast_query_interval (QQIC) test cases:
> > TEST: Number of tagged IGMPv2 general query                         [ O=
K ]
> > TEST: IGMPv3 QQIC linear value 60                                   [ O=
K ]
> > TEST: MLDv2 QQIC linear value 60                                    [ O=
K ]
> > TEST: IGMPv3 QQIC non linear value 160                              [ O=
K ]
> > TEST: MLDv2 QQIC non linear value 160                               [ O=
K ]
> > TEST: Vlan mcast_query_response_interval global option default value   =
[ OK ]
> > INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
> > TEST: IGMPv3 MRC linear value 60                                    [ O=
K ]
> > TEST: IGMPv3 MRC non linear value 160                               [ O=
K ]
> > TEST: MLDv2 MRC linear value 30000                                  [ O=
K ]
> > TEST: MLDv2 MRC non linear value 60000                              [ O=
K ]
> >
> > Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> > ---
> >  .../net/forwarding/bridge_vlan_mcast.sh       | 150 +++++++++++++++++-
> >  1 file changed, 142 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.s=
h b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> > index e8031f68200a..9f9f33d58286 100755
> > --- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> > +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> > @@ -162,14 +162,27 @@ vlmc_query_cnt_setup()
> >  {
> >       local type=3D$1
> >       local dev=3D$2
> > +     local match=3D$3
> >
> >       if [[ $type =3D=3D "igmp" ]]; then
> > -             tc filter add dev $dev egress pref 10 prot 802.1Q \
> > +             # This matches: IP Protocol 2 (IGMP)
> > +             tc filter add dev "$dev" egress pref 10 prot 802.1Q \
> >                       flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.=
0.1 ip_proto 2 \
> > +                     action continue
> > +             # AND Type 0x11 (Query) at offset 24 after IP
> > +             # IP (20 byte IP + 4 bytes Option)
>
> Let's make it clearer: 20 bytes IPv4 header + 4 bytes Router Alert option
             #    20 bytes IPv4 header + 4 bytes Router Alert option +
IGMP[offset 0] Query

>
> > +             match=3D(match u8 0x11 0xff at 24 $match)
> > +             tc filter add dev "$dev" egress pref 20 prot 802.1Q u32 "=
${match[@]}" \
> >                       action pass
> >       else
> > -             tc filter add dev $dev egress pref 10 prot 802.1Q \
> > +             # This matches: ICMPv6
> > +             tc filter add dev "$dev" egress pref 10 prot 802.1Q \
> >                       flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::=
1 ip_proto icmpv6 \
> > +                     action continue
> > +             # AND Type 0x82 (Query) at offset 48 after IPv6
> > +             # IPv6 (40 bytes IPv6 + 2 bytes next HDR + 4 bytes Option=
 + 2 byte pad)
>
> Same: 40 bytes IPv6 header + 8 bytes Hop-by-hop option
             #    40 bytes IPv6 header + 8 bytes Hop-by-hop option +
MLD[offset 0] Query

>
> > +             match=3D(match u8 0x82 0xff at 48 $match)
> > +             tc filter add dev "$dev" egress pref 20 prot 802.1Q u32 "=
${match[@]}" \
> >                       action pass
> >       fi
>
> Sashiko has a relevant comment:
>
> "
> Does this configuration evaluate all packets against the pref 20 filter,
> regardless of the pref 10 result?
>
> In tc, if a packet does not match a filter, classification automatically =
falls
> through to the next priority filter.  By using "action continue" on pref =
10,
> matching packets are also instructed to continue evaluation at the next f=
ilter.
>
> Because both matching and non-matching packets proceed to pref 20, pref 1=
0
> seems to act as a no-op gate.  Could this cause the u32 rules in pref 20 =
to
> inadvertently match unrelated background traffic on the interface?
>
> To implement a logical AND across different classifiers, should pref 10 u=
se
> "action goto chain 1" with pref 20 placed inside chain 1?
> "
Answer: No, it should evaluate IGMP only by pref 10 filter AND IGMPv3
Query by pref 20 filter. Query filter may include additional match for
QQIC/MRC.

Here is my new filter:
             tc filter add dev "$dev" egress pref 10 prot 802.1Q \
                     flower vlan_id 10 vlan_ethtype ipv4 dst_ip
224.0.0.1 ip_proto 2 \
                     action goto chain 1

>
> >
> > @@ -181,7 +194,53 @@ vlmc_query_cnt_cleanup()
> >       local dev=3D$1
> >
> >       ip link set dev br0 type bridge mcast_stats_enabled 0
> > -     tc filter del dev $dev egress pref 10
> > +     tc filter del dev "$dev" egress pref 20
> > +     tc filter del dev "$dev" egress pref 10
> > +}
> > +
> > +vlmc_query_get_intvl_match()
> > +{
> > +     local type=3D$1
> > +     local version=3D$2
> > +     local test=3D$3
> > +     local interval=3D$4
> > +
> > +     if [ "$test" =3D "qqic" ]; then
> > +             # QQIC is 8-bit floating point encoding for IGMPv3 and ML=
Dv2
> > +             if [ "${type}v${version}" =3D "igmpv3" ]; then
> > +                     # IP 20 bytes + 4 bytes Option + IGMPv3[9]
> > +                     if [[ $interval -lt 128 ]]; then
> > +                             echo "match u8 0x3c 0xff at 33"
>
> Please pass the expected value as an argument instead of hard coding
> "0x3c" here. Same in other places in the function.
Will pass the expected code as an argument. Also will update the comments h=
ere.
                     # 20 bytes IPv4 header + 4 bytes Router Alert
option + IGMPv3[offset 9] QQIC

>
> > +                     else
> > +                             echo "match u8 0x84 0xff at 33"
> > +                     fi
> > +             elif [ "${type}v${version}" =3D "mldv2" ]; then
> > +                     # IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2=
[25]
> > +                     if [[ $interval -lt 128 ]]; then
> > +                             echo "match u8 0x3c 0xff at 73"
> > +                     else
> > +                             echo "match u8 0x84 0xff at 73"
> > +                     fi
> > +             fi
> > +     elif [ "$test" =3D "mrc" ]; then
> > +             if [ "${type}v${version}" =3D "igmpv3" ]; then
> > +                     # MRC is 8-bit floating point encoding for IGMPv3
> > +                     # IP 20 bytes + 4 bytes Option + IGMPv3[1]
> > +                     if [[ $interval -lt 128 ]]; then
> > +                             echo "match u8 0x3c 0xff at 25"
> > +                     else
> > +                             echo "match u8 0x84 0xff at 25"
> > +                     fi
> > +             elif [ "${type}v${version}" =3D "mldv2" ]; then
> > +                     # MRC is 16-bit floating point encoding for MLDv2
> > +                     # IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2=
[4]
> > +                     if [[ $interval -lt 32768 ]]; then
> > +                             echo "match u16 0x7530 0xffff at 52"
> > +                     else
> > +                             echo "match u16 0x8d4c 0xffff at 52"
> > +                     fi
> > +             fi
> > +     fi
> >  }
> >
> >  vlmc_check_query()
> > @@ -191,9 +250,13 @@ vlmc_check_query()
> >       local dev=3D$3
> >       local expect=3D$4
> >       local time=3D$5
> > +     local test=3D$6
> > +     local interval=3D$7
> > +     local intvl_match=3D""
> >       local ret=3D0
> >
> > -     vlmc_query_cnt_setup $type $dev
> > +     intvl_match=3D"$(vlmc_query_get_intvl_match "$type" "$version" "$=
test" "$interval")"
> > +     vlmc_query_cnt_setup "$type" "$dev" "$intvl_match"
> >
> >       local pre_tx_xstats=3D$(vlmc_query_cnt_xstats $type $version $dev=
)
> >       bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_quer=
ier 1
> > @@ -201,7 +264,7 @@ vlmc_check_query()
> >       if [[ $ret -eq 0 ]]; then
> >               sleep $time
> >
> > -             local tcstats=3D$(tc_rule_stats_get $dev 10 egress)
> > +             local tcstats=3D$(tc_rule_stats_get "$dev" 20 egress)
> >               local post_tx_xstats=3D$(vlmc_query_cnt_xstats $type $ver=
sion $dev)
> >
> >               if [[ $tcstats !=3D $expect || \
> > @@ -441,6 +504,7 @@ vlmc_query_intvl_test()
> >       check_err $? "Wrong default mcast_query_interval global vlan opti=
on value"
> >       log_test "Vlan mcast_query_interval global option default value"
> >
> > +     log_info "Vlan 10 mcast_query_interval (QQIC) test cases:"
>
> Let's remove this as it makes the output confusing:
Sure, I will remove this line.

>
> INFO: Vlan 10 mcast_query_response_interval (MRC) test cases:
> TEST: IGMPv3 MRC linear value 60                                    [ OK =
]
> [...]
> TEST: Flood unknown vlan multicast packets to router port only      [ OK =
]
> TEST: Disable multicast vlan snooping when vlan filtering is disabled   [=
 OK ]
>
> >       RET=3D0
> >       bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_star=
tup_query_count 0
> >       bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_quer=
y_interval 200
> > @@ -448,8 +512,42 @@ vlmc_query_intvl_test()
> >       # 1 is sent immediately, then 2 more in the next 5 seconds
> >       vlmc_check_query igmp 2 $swp1 3 5
> >       check_err $? "Wrong number of tagged IGMPv2 general queries sent"
> > -     log_test "Vlan 10 mcast_query_interval option changed to 200"
> > +     log_test "Number of tagged IGMPv2 general query"
> >
> > +     RET=3D0
> > +     bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp=
_version 3
> > +     check_err $? "Could not set mcast_igmp_version in vlan 10"
> > +     bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_=
version 2
> > +     check_err $? "Could not set mcast_mld_version in vlan 10"
> > +     bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_quer=
y_interval 6000
> > +     check_err $? "Could not set mcast_query_interval in vlan 10"
> > +     # 1 is sent immediately, IGMPv3 QQIC should match with linear val=
ue 60s
> > +     vlmc_check_query igmp 3 $swp1 1 1 qqic 60
> > +     check_err $? "Wrong QQIC in generated IGMPv3 general queries"
> > +     log_test "IGMPv3 QQIC linear value 60"
> > +
> > +     RET=3D0
> > +     # 1 is sent immediately, MLDv2 QQIC should match with linear valu=
e 60s
> > +     vlmc_check_query mld 2 $swp1 1 1 qqic 60
> > +     check_err $? "Wrong QQIC in generated MLDv2 general queries"
> > +     log_test "MLDv2 QQIC linear value 60"
> > +
> > +     RET=3D0
> > +     bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_quer=
y_interval 16000
> > +     check_err $? "Could not set mcast_query_interval in vlan 10"
> > +     # 1 is sent immediately, IGMPv3 QQIC should match with non linear=
 value 160s
> > +     vlmc_check_query igmp 3 $swp1 1 1 qqic 160
> > +     check_err $? "Wrong QQIC in generated IGMPv3 general queries"
> > +     log_test "IGMPv3 QQIC non linear value 160"
> > +
> > +     RET=3D0
> > +     # 1 is sent immediately, MLDv2 QQIC should match with non linear =
value 160s
> > +     vlmc_check_query mld 2 $swp1 1 1 qqic 160
> > +     check_err $? "Wrong QQIC in generated MLDv2 general queries"
> > +     log_test "MLDv2 QQIC non linear value 160"
> > +
> > +     bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp=
_version 2
> > +     bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_=
version 1
> >       bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_star=
tup_query_count 2
> >       bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_quer=
y_interval 12500
> >  }
> > @@ -468,11 +566,47 @@ vlmc_query_response_intvl_test()
> >       check_err $? "Wrong default mcast_query_response_interval global =
vlan option value"
> >       log_test "Vlan mcast_query_response_interval global option defaul=
t value"
> >
> > +     log_info "Vlan 10 mcast_query_response_interval (MRC) test cases:=
"
>
> Same
I will remove this line also.

[...]
