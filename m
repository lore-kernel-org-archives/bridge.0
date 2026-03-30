Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A439A7F2
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899570; cv=pass; b=Hpb5LZOKNff4BxfKYKMY6pcdE2If/3LAP+jqGPqOLupm93A7IXU7ak3o13pmQDZOSGzgkg3yiz+4k2LQBXPf4JYf7sBPcIxIMJFwQ67Jr8N6+RUZBuz1dB3e0n4/bpm/enUdzbDbDgP6uQzhceRHtE4j2SNTEa20fowwSHoiMMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899570; c=relaxed/simple;
	bh=raOnWdkwciR774nemG5W5s7l+qsio7cSR6A3+T7p82Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae3jaII10s3zJjlZOwt3FuzPUZ3MZGxpiERQYoNNEtj0ZjOAF58hfdKnw2WVQzPGcbckblVDsyEXXlMdSQC+nR9IdP8Amz/WQu0+z/aIDasgIMbxnXHhPaDtLWMG9ohbsuUd9YUG0fMlLMswFiEjnIvH/+SWYRevoFoAGNsvnlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1Fidzmt; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Fidzmt"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66a9a2187a5so7748914a12.0
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774899567; cv=none;
        d=google.com; s=arc-20240605;
        b=Tdfdrsj91VfRnRgG/eIBsqDXcc6X0AjHtRqyqnNZtT6kess7s470Vn+8lxh+7pOqU7
         anA8ncyvnWF+LThZyFvMBT340d8ME2VTEDv2FSPODaH84Y29gUdeUmQ+9YPFZnbaWzx/
         PDI/tlVtd8bV6Cp2gGG4oNGB5Dy7Qxm345Be23Lqg8Nly+4IrfieQYkZZE2/Vltpuuco
         vFX5DR7z2xJ21UiEgcaH5wFls6uCtb15MjT8yU3Nep0k5tUkTLUQ4tBi8Fu+fX8kiWdH
         nxKC+tbkpXhkUVwK9cTJsdJMwSMziANEhzEULF1Dv0AbwdVYsUjlyV6ErrYXy9NmKx53
         cByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKh8L3ukh4XUchWBADzpdMRcZ/muD9vhADkdS5aaBtA=;
        fh=XA2aWbW/LMlfs2TPJuopT/d2iANfQIj9Ttx76dYgXDs=;
        b=cFRwpWye4doAsxonUshjJSWDEWBW7ZoMHqAM++PZ6Etdv5/hr2ApEPTZkiCGrhC3og
         Qxe4yYf2H2Tw3vyhd2hhVi68uAHPsGoNQPWlAg+Lu3wczcI4Cb2pEOSSoAs+N7/TRWUZ
         O1au/0mtudDOSZry3GMNnJogWUj08+bNiOUhp5VMXMI05Ev6hcX53e2SuGAZjxsxVnWX
         bdCQ+XP6gQf2Nx2b2X8ay7fxJzjq3xektUtlftnaBqrwuqK1/juKwqZzXoXa6PIAm+d+
         xq6G4Wg0Bo9raZgKCFpJLO5ne6JhilVNj+Yin22T/IXGPmlWeJmz2s8Sm2EiAZK3ebUU
         p8Qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774899567; x=1775504367; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKh8L3ukh4XUchWBADzpdMRcZ/muD9vhADkdS5aaBtA=;
        b=A1Fidzmtgf7DcP3vzDJKeW5ibvEL9xsOkoukSnjH3hNkCaV+y0lef1Nm3AKuiq4xjt
         bQc+d+IB5JPny8si47+U9VjPdaNFNOyhKL/MnR9eRkGSFiZB0c3BynoZXtIEwgDg/lTl
         V/5eNEUZ7unhgz/uWc/pxyGDgHhN65aoxzAjNXRx0VcA6vfPfXkECYuMsussAXR2ZcLT
         XIaCCGEZlS4boy1ZA2Rca48h6qTQxBQd394H1np+vdUTQTdJ8p2owQSNFNLHo36+XCjr
         hqxC0S/1ewQvC1xh1qrroXotiYPqbMQ0XzPOBt7C5D2x9x99/gP+qLk59auA9lR+/3t7
         luww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899567; x=1775504367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKh8L3ukh4XUchWBADzpdMRcZ/muD9vhADkdS5aaBtA=;
        b=psZyAs2YzXeKwOv0PRl4ODq9b+f9P/TNARs0OzkrstrZrHLOIv2mQZcqJbRLepdzht
         4LdOQS5ddBeoAj3LbKsC4HJbt2gfPHLAmdLPZXy+wvx6UUM8OF2xeGkFmcdfVgfb4xjv
         7fUoA7xshm84EJCJ9EPZR5DhoOgBk/SX30NVOoTaKkaC/P1bSG82OvIljvvcXfWHYJ9W
         Jtuq2HbnGanAkw+OUj0/SAVzSMMGKSvf24wGlRXYLFyeoFWqxeH8bkwzSl1pQi+Vr2Vj
         KMXVjh9WRp/uN2t0dk8OLT4VUdE79ZYGkRUm7JVEMlCg7Z8uPFsQqA9kvRs8rx6fr2vv
         A2HA==
X-Forwarded-Encrypted: i=1; AJvYcCV+XmYQdFc51hYyZLJUZvS83Eqd89Ql8RBx/s615uYpDzpXcq49VzjRU/a8w1SS3r0gRKgwTG4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1lxpO2lH3qr+x4zxqyaY6naY1yfTel7o+5dm4ciDKgvEd6rO8
	DndoQjm3eWFj8tPw+wJC/AqeLvmo2ThTXXCXSHaRnMk5nXg22XEOVIx0xAcMegvxd1v/Cl1gpiz
	vvv7riiOHL/nOqeszy5RToW5IzfGXj/o=
X-Gm-Gg: ATEYQzywp2y5Vf6J281B0TjUn2r21b3IMqZcFFfR7QMsR53ubsyMb2nKGnUf3oBBDrK
	zFJQtBfsS/niowPOVP5JGG44VCOsctBv0dQyLkMNhkerJcV51eRL4OgqopEG7xJE7Id+rp5Cly2
	KkqLRNwhvIJKeKtEtJDobdpDPuxzcKABhEWk6En0vChgEs65DqYEw1u3O7xk1w4N5KB6MNaOT0g
	VDcWktuOTj4PgUTsyqr9Y0GGcM1i6OWsFrPDuQURfRc3P9iFGqEUUm8wDgEvw1fIUSOwsxqAxAe
	QqyNa6k=
X-Received: by 2002:a17:907:846:b0:b98:4f24:a6d with SMTP id
 a640c23a62f3a-b9b502bfd51mr937477666b.11.1774899567358; Mon, 30 Mar 2026
 12:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org> <20260330191611.16929-1-royujjal@gmail.com>
In-Reply-To: <20260330191611.16929-1-royujjal@gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Tue, 31 Mar 2026 01:09:15 +0530
X-Gm-Features: AQROBzBPKFrWxeTO63V57MZLR93bpDWq5OJl46BKm3EnyddwLm9W3nhW6ZcH4tU
Message-ID: <CAE2MWkkY3anF0Am4JbCFeFax1dSH2F7AyRUjHJs6S17fKkhU6g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast
 exponential field encoding
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 12:46=E2=80=AFAM Ujjal Roy <royujjal@gmail.com> wro=
te:
>
> Description:
> This series addresses a mismatch in how multicast query
> intervals and response codes are handled across IPv4 (IGMPv3)
> and IPv6 (MLDv2). While decoding logic currently exists,
> the corresponding encoding logic is missing during query
> packet generation. This leads to incorrect intervals being
> transmitted when values exceed their linear thresholds.
>
> The patches introduce a unified floating-point encoding
> approach based on RFC3376 and RFC3810, ensuring that large
> intervals are correctly represented in QQIC and MRC fields
> using the exponent-mantissa format.
>
> Key Changes:
> * ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>   Removes legacy macros in favor of a cleaner, unified
>   calculation for retrieving intervals from encoded fields,
>   improving code maintainability.
>
> * ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>   Standardizes MLDv2 terminology by renaming mldv2_mrc()
>   to mldv2_mrd() (Maximum Response Delay) and introducing
>   a new API mldv2_qqi for QQI calculation, improving code
>   readability.
>
> * ipv4: igmp: encode multicast exponential fields
>   Introduces the logic to dynamically calculate the exponent
>   and mantissa using bit-scan (fls). This ensures QQIC and
>   MRC fields (8-bit) are properly encoded when transmitting
>   query packets with intervals that exceed their respective
>   linear threshold value of 128 (for QQI/MRT).
>
> * ipv6: mld: encode multicast exponential fields
>   Applies similar encoding logic for MLDv2. This ensures
>   QQIC (8-bit) and MRC (16-bit) fields are properly encoded
>   when transmitting query packets with intervals that exceed
>   their respective linear thresholds (128 for QQI; 32768
>   for MRD).
>
> Impact:
> These changes ensure that multicast queriers and listeners
> stay synchronized on timing intervals, preventing protocol
> timeouts or premature group membership expiration caused
> by incorrectly formatted packet headers.
>
> v2:
> - Retargeted the series to net-next as suggested
> - Fixed a compilation warning in the MLD rename change
> - Kept reverse xmas tree order in IGMP exponential encoding change
> - Added bridge selftests to validate IGMPv3 Query MRC and QQIC handling
>
> Ujjal Roy (5):
>   ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>   ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>   ipv4: igmp: encode multicast exponential fields
>   ipv6: mld: encode multicast exponential fields
>   selftests: net: bridge: add tests for igmpv3 MRC and QQIC validation
>
>  include/linux/igmp.h                          | 158 +++++++++++++++-
>  include/net/mld.h                             | 179 +++++++++++++++++-
>  net/bridge/br_multicast.c                     |  22 +--
>  net/ipv4/igmp.c                               |   6 +-
>  net/ipv6/mcast.c                              |  19 +-
>  .../selftests/net/forwarding/.gitignore       |   2 +
>  .../testing/selftests/net/forwarding/Makefile |  10 +
>  .../selftests/net/forwarding/bridge_igmp.sh   | 109 +++++++++++
>  .../selftests/net/forwarding/mc_decode.c      |  38 ++++
>  .../selftests/net/forwarding/mc_encode.c      |  40 ++++
>  10 files changed, 535 insertions(+), 48 deletions(-)
>  create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
>  create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c
>
>
> base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
> --
> 2.43.0
>

Forgot to attach test result using bridge_igmp.sh selftest.
First two test cases are added newly v3query_mrc_test and v3query_qqic_test=
.

Without these patches:
tools/testing/selftests/net/forwarding# ./bridge_igmp.sh
TEST: IGMPv3 query: verify MRC (configured=3D160, expected=3D132)       [FA=
IL]
        Bad MRC value in IGMP packet:     Max Resp Time: 51.2 sec (0xa0)
TEST: IGMPv3 query: verify QQIC (configured=3D160, expected=3D132)      [FA=
IL]
        Bad QQIC value in IGMP packet:     QQIC: 160
TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
...

With these patches:
tools/testing/selftests/net/forwarding# ./bridge_igmp.sh
TEST: IGMPv3 query: verify MRC (configured=3D160, expected=3D132)       [ O=
K ]
TEST: IGMPv3 query: verify QQIC (configured=3D160, expected=3D132)      [ O=
K ]
TEST: IGMPv2 report 239.10.10.10                                    [ OK ]
...
