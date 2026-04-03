Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD325B1EB
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775202665; cv=pass; b=p8fGqK09rv110VAY4H8opU2ddJ80semqaYebOPly5L8S1pcFeOSbll5XICaMRbJRTgsoUZN90V0a7KEeJ6o0dD82wrR+EHuJTpmF6T0JEloaf9UBtgsFyPvuonyaxbQp7irAKcv36Bf3Fkw1ft4H8uTJAXO4f34jha8h+CiM3rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775202665; c=relaxed/simple;
	bh=dd0wcVBzvcg1oc0Uq/WGTRb+kCuStk1ncnJUMitvdEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEpWTnjRDlwp6DxWw8WRS0Tr0FX9bZ/YfVCXFjslkjoehjZhNnSgaKRCuCQnA5DfhdBdO3U+W4O6JGhmv4jl4qEUMdhJpHyyqaZv51R8x9B6Nguh2dX9P9B00qsK/XnaVeuOSdmSgcgSZtN1n0ddpwbMugljwRUMquH/HFKPbug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0QmSePC; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0QmSePC"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so212220566b.1
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 00:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775202662; cv=none;
        d=google.com; s=arc-20240605;
        b=ixA+dvpwMiLh8iucCrYe6fMPSUdu8h+ToWjeXLIQ+oCHuqvaNmecmMQdq5eJL7GbiV
         rApevi9Q4XjrqGxdA3VHPtxK1H/11aQPZE9uL8LdK9UJtamvhMUoJs7vmriFvqrdoPkG
         mKSTXk+k1qNJqb/RLk4M6wTkYhCycTMH8EcLyzWA3calkxa7m9InZlEuHNnJEG+I7kGV
         rTjYbJrs4vQixuGBppaLVHIEumeERGbEkkhAaGZ6zX/RHCG3OnCBp7O17vnfYvDMIjPQ
         FI9eCAnpzskLHpEPTlwVlsmBquVdQxYip6AWQ093HvJjVR6mJ2HH15b0e6flfKErwSVs
         +XJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzoumJBKpZU/3O7s9r+rhYMdWgYGL90pbXwFIlwFZtw=;
        fh=3CO4Vmk4bzqIPr8DynRjS2pYT/5c1tXOT9q/f9Qn38U=;
        b=KGDwBT/lN+xEeMBgjxaxzbx9awg5ySwslmB57x/3e6jG6YDPhOuYPa0odnIZF/2YZW
         M+lmubdDuTiiJAJNh91f9DgaiH6Jff/YGohkZJjS6gzWnn295hvevQR8qGOySGyrWpSW
         ZoMngkLf4Yaod81KryjH4gPZ5AJ6W63k7u0tw9iGPZfGgy1fT6/TEio8J6kB6rVb235Y
         xbX1cgq4ydrhKUlos7H/D0B2dCXyS8aLm9lOrDoYGJjiNtZvWJMWpQCqUo0SBXawTPsS
         cvvnYsv8nTWlJQMrno8k8ZfR9lYuoq/cqjVATFjXhgYf2NWPlnGgVemPQLjeQYp4fDRw
         i2fQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775202662; x=1775807462; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzoumJBKpZU/3O7s9r+rhYMdWgYGL90pbXwFIlwFZtw=;
        b=U0QmSePCdJZtSElMSwN2u7ITrhhfL7jV7sudOGTkoR5j+4u964SobFyOpqnB//Jf8a
         w7yiWRiiLgewFKDU+LMddz5e+gkJl205GBoPv09GBOVAT7zcLaN+DRMGWgnbQVU9SSH+
         WhS0awLrapkWzpJPMv6UyM9nZaC6Y9HvvNWqavAEmPGeU0KUfidG6reFLl+/DP5uh6Xo
         mhq3Eh3e4CR9d2eDDuB2ebMsTWkEEOtyDbHLFnwJFkXS7w1Jyr+FmVPAB7qQWEB5BgYP
         kn5aHM/L90eX4gXSEn41rylaCq9s2LCV4/pRPWTX8d1lt/d0vujJ2zSIcpZKtiUtNOyD
         95tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775202662; x=1775807462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzoumJBKpZU/3O7s9r+rhYMdWgYGL90pbXwFIlwFZtw=;
        b=e9JaDxittsU//FXm5zDWpbE4ZqFpZzO2eUcUKpV2DsNqFcPBREOhetCG18AZuOTJeL
         cCUEV2vl3ourxpzJ0jLfzde9KKRqg3YX9UlfYoiRyYblr1sRBx4ag6WE7jP7enWMXfLs
         AyHnFaqAloTBCu7s//QrV3aXVhJFS+yTxnqH3pqZSWpjT5+ERJB91zm0lLKnSMIMZzqN
         V5bDcUmt41UOshV13z0BRu+o5+JPYvwy9SzFOu3KNwQSBdheyhNWNn7/+ZXwEs6EafT3
         o89cGkOLpwssN8A2spkO6hLQYNhw2HSJKXUmY8Ae8wnLCXr1S43CiP+yYoXtnQyvOhBP
         4tHA==
X-Forwarded-Encrypted: i=1; AJvYcCVlLanHVQT5iJZqxs0ob+E/SjObW/NG41l6hDtvxVHjypScUZeQrH0YCa7btV8qMkvpP16vHXc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0aR/D7C6vOv3pXDGZuuY+0m73moZPfRnDe6KSyqouKwuSnspn
	+xMz0dZfGHzLS2XuhiwrGhOKvWCVA5gGBm8gAt2kn0nYtakPcTijXbavtewJs28vrYVzOCeZKT1
	3ERc9+E1d6GLazY0x+dxfo2AEjah4aqg=
X-Gm-Gg: ATEYQzzdk26oQPefINj3pBWcn8+LwhZ4QEkEqaptNhqwnT9lc3yeCsI1XKpN3mN9sev
	cFuRBM5e6KEcnPaq5RHen3y4FcnuMxVroBJ4f4QgWaEF64P2PObmeJ4pUL4EKD+m0OBd20U321z
	+JDC1FS9Dm7aGydMmrBPuqgjJYrpORiDiEL439f1SpRJYO8+Nph9LH3UY0VYNCIMVt/rpebXrX+
	6S8T+FmUPBiPgWv2jtKWMudskLMQm7QoqRK/clfC0QE+SQQoqqry0dIhMffsMlxkxAqjns0vDCR
	pKDCuVj+P8h2zfP3Bg==
X-Received: by 2002:a17:906:478e:b0:b98:1129:51 with SMTP id
 a640c23a62f3a-b9c675492c5mr95779166b.17.1775202662236; Fri, 03 Apr 2026
 00:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com> <20260330191611.16929-6-royujjal@gmail.com>
 <20260331141347.GA1637150@shredder>
In-Reply-To: <20260331141347.GA1637150@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 3 Apr 2026 13:20:49 +0530
X-Gm-Features: AQROBzCimHZIQikwfz6IXnJcfEgHNzZT7diUDVok-XKy8P3nRmO5_SZI4DRIkdI
Message-ID: <CAE2MWkn3gPc1kBwy2p7r5bx6QozMStM0N6oEutT7g7GnJrKteA@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 7:44=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Mar 30, 2026 at 07:16:11PM +0000, Ujjal Roy wrote:
> > Add bridge selftests that configure IGMPv3 parameters and validate the
> > resulting Query packet fields for Max Resp Code (MRC) and Querier Query
> > Interval Code (QQIC).
> >
> > This also adds helper binary to encode floating-point exponential field=
s.
> >
> > Future extensions may cover corresponding IPv6 cases.
>
> Please cover both IGMPv3 and MLDv2 since the patchset touches both. You
> can add the MLDv2 tests in bridge_mld.sh.
>
> Also, I think you can simplify the test by simply matching on the
> expected values of MRC and QQIC using tc-u32.
>
> For both IGMPv3 and MLDv2 please test both:
>
> * MRC and QQIC in linear range.
> * MRC and QQIC in non-linear range.
>
> And please make sure the new test cases don't add new shellcheck
> warnings / errors or it will fail in the CI. You can ignore existing
> ones.

I will upgrade the existing test cases in file bridge_vlan_mcast.sh
instead of the previous file (bridge_igmp/mld.sh).

I have some doubts on test case logs reporting. Below are the logs
without my patchset. API used vlmc_query_intvl_test() and
vlmc_query_response_intvl_test().
TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK=
 ]
TEST: Vlan 10 mcast_query_response_interval option changed to 200   [ OK ]

I am expecting some suggestions from the logs below. And are these
covers both IGMPv3 and MLDv2 for QQIC and MRC?
Actually mcast_query_interval=3DQQIC and
mcast_query_response_interval=3DMRC we already know.

TEST: Vlan mcast_query_interval global option default value         [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 200            [ OK ]
TEST: Vlan 10 mcast_query_interval number of IGMPv2 general query   [
OK ] -> old case added log
TEST: Vlan 10 mcast_query_interval option changed to 6000           [ OK ]
TEST: Vlan 10 mcast_query_interval in IGMPv3 is 60                  [ OK ]
TEST: Vlan 10 mcast_query_interval in MLDv2 is 60                   [ OK ]
TEST: Vlan 10 mcast_query_interval option changed to 16000          [ OK ]
TEST: Vlan 10 mcast_query_interval in IGMPv3 is 160                 [ OK ]
TEST: Vlan 10 mcast_query_interval in MLDv2 is 160                  [ OK ]
TEST: Vlan mcast_query_response_interval global option default value   [ OK=
 ]
TEST: Vlan 10 mcast_query_response_interval option changed to 600   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in IGMPv3 is 60         [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 1600   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in IGMPv3 is 160        [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 3000   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in MLDv2 is 30000       [ OK ]
TEST: Vlan 10 mcast_query_response_interval option changed to 6000   [ OK ]
TEST: Vlan 10 mcast_query_response_interval in MLDv2 is 60000       [ OK ]

Or is it better to name them properly instead of mcast option names, like b=
elow?

Vlan 10 mcast_query_interval:
TEST: Number of tagged IGMPv2 general query                         [ OK ]
TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
TEST: MLDv2 QQIC linear value 60                                    [ OK ]
TEST: MLDv2 QQIC non linear value 160                               [ OK ]
