Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79538A714
	for <bridge@lists.linux.dev>; Wed, 24 Jun 2026 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284395; cv=pass; b=Vy2kUC9F91UDAZYQmj8Q3aNf1gWhX9x2S5pld6jXfvlxll9q9F3sUbGvCa6vlpjoHWXJGSGid2vztbvakLMShTfqSwcQ4WH5Ht+CypZjLfNXU2l1juO7Datq9yZZB/q+QR61GxFel99ZERVmvVtFEl8jEHirqlEJl17FXzSWKGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284395; c=relaxed/simple;
	bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dtjvymgxE0tyJY3ox3MXfuqTU323XaPAb6csSvNJoa6fq/oKkF+inFqIKPoG/7xh+exNDZsHEDL0yL6ahfesnv1Xpokv5TwBRBH6u67NqjQKGf627mWDRwCI3CccP8MWg37VoFRu5ZjedLFNPtA1TKPTRuqKY6hcsbI+/fVS/Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJPo1WPg; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJPo1WPg"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c07a6527453so96564166b.0
        for <bridge@lists.linux.dev>; Tue, 23 Jun 2026 23:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284392; cv=none;
        d=google.com; s=arc-20240605;
        b=MGXjHvG5q2dBbmhoXIg0uVnVnzmLy5zklwWJ3akL74Pc8roycGQl58tQgslqh3ASfK
         jmiIHTV1wAuDIxWOO8/c3/zz/FCpGIgp5uJyLXZnY2Yje84WiN0XDZ8K/XeK1wQW0CA6
         WcK/7ldraTiYSCf2AUnofWBQXJa1uAR9XOTfiSTsw6bBYEYaHBwB1QkXwuv5LhxbS9WG
         zqVGzc9vbvMbJyN2lfrF/SvzKlnr2b+pn0Qaks6dgubBHA4c83J/nveGjmsNFFxw1b2p
         Oab+eMdD6/bb5xqYclalmg637tfyATVDCy/BnMu1A0TzF3HQbUg6psNM5yRNHX5HvIlH
         qazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        fh=gIqLWJGwg+8ys5uVQyXPJB3ktlxek7pGEZnaAl1AwsU=;
        b=JHfhgOM1FPelAhEkxAYW4yvypFsNidR1D7353hogSbrI9thbLBHNwdzdWpXUa1gzs6
         3wlsLQQMk0xRw8VQCqbEidMHDwuZWfHd6b23HCmyXGUt1OG3xhEthm/MaqHqsuGNmL16
         +p758rO00z6nv8vQSo9O0WyifGVEryLPvfEShpb2jgm80ns9VcHnGR7SVrGNLJ9a1BVw
         lRVn2J9vkFDdXnstSgP04dTdXgKuOztf/jAVJy198Gaet/M6O5iq3kWQ+8X8hLUmkNQJ
         5cu5ywQfGthBGDVjzYw1MiSn+iHlZy+5QwFN6QX1KaHnCYtputLGvA9pl0nwGtn/MWwV
         5ykg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284392; x=1782889192; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        b=AJPo1WPgXUkE7yaNI6NpRqe8sEp9bbUfp+dEkBOgoobV/gNkyuCjF5Vmktb0RDUYfd
         DJRARp/OgUSQx1/LoOnUPVApBjpHvFqD3G9JJQ0wyThH61OI+/zbwwIBi5UNYCamFNNp
         67abctfCHJYt/ZMO2muv0cWtrgJVwFfzlI/DnQ93xc8Kyl59Ul4cddhEIuVNGvylbs0Z
         TnSpQQD/jy0BpMIHKKKRocuVzN+tWr3yBaqos6L8w271AELIA2+qD/una9YIGNag5VcF
         xTKpU5jUA+ytgNPEz5HVpObD6f6LVrxxDSpJEhc4EUH+8i1QMAb3l05Qcwyx4kW1G+pf
         7NDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284392; x=1782889192;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        b=gHi5Ux+QRkrQHQHNNdxZ1AeSibxqtIs5LDFGfhAJGqsvUNW1hjCzaY1J6JnkQRf0Bz
         3aDj4tFdd+DGSozhZYTBlX20LS2QfgnDd9zLKgv+y8KO91oG55Rcawqb2H/Ef98DScDy
         SqreFV712ExICqhZO/y3/yoqaUunEfi4EGh6EwJjYoakPHqU9jUTU7iHtl/jvvQjMZZY
         O/fIjiPipRc5Ofsunz5TysW0iMfzFs9KAqImVhO+9riW/21/RQ36bbWoeG57OZWtGpQV
         VgnlF7S9hvpRGhWlEO9cCeQIfSC18IYui2+afeoVmDYgmPGPm93LxrnbOSgMdO3qeYwC
         6NaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PLMEZfcAbzfI9+LxJMHAMIvMdwe2FZtfYJL/Z9JyArIqRehYrb0qMmW+yXuhRt0lT2q2GpNY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYnsuehwC7H9VzSW1BCoXPUHdd5ww2A3xvc1bUmpZ2iByKNDRX
	uj278CwRB0z5m3nnmX/YE2jh5mURoukAUoKbQLZpY55On/fasd8C8+z8B5WbxyuDCTIjS8FNvY+
	E7YW0bPBjBfwVMM411yT35i2jOhBNLIk=
X-Gm-Gg: AfdE7ckrL0lFgaZjfzQ7FSYm2zkxH9tD+X16imzQjXuNENH6iojDTiYi5pVwqYsoLu9
	1lCchngZu9AF/h2e3VOCgK3Ybt3XGdSB50WBuH/Ji9NEHResm1/wj857L1mnx1DVnLOi/faKOU4
	5fKC/pljDYrXSGjoaHtpSQLVVODQ6fVgIBpwhNHXuztWyOJt+iqebDGR7qBbKKGGTXh6CKBdTIu
	DXPeyRgwlh5SjmbdsJtyIPy5/XjPDjFuKPt0s8LgWAOP36ieRp/5ElS/LKrx1MzCLpc3fe1i+EU
	N04gyGpj
X-Received: by 2002:a17:907:a807:b0:bea:f5ec:e70d with SMTP id
 a640c23a62f3a-c119cc73499mr81252166b.10.1782284392161; Tue, 23 Jun 2026
 23:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 24 Jun 2026 12:29:36 +0530
X-Gm-Features: AVVi8CcjqT2HGCtdY0b3TsVb5_1CyqP5ethEgfbUu0VypPx0SY_tnqJhPcFQITk
Message-ID: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
Subject: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	Kernel <netdev@vger.kernel.org>, Kernel <linux-kernel@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Please consider backporting the following bridge multicast fix series
to all applicable stable kernels:

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify
calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

History: The multicast stack currently supports decoding of IGMPv3 and
MLDv2 exponential timer field encodings, but lacks the corresponding
encoding logic when generating multicast query packets. As a result,
query intervals and response codes exceeding the linear encoding range
can be transmitted incorrectly. This can cause multicast queriers and
listeners to interpret different timing values, resulting in protocol
interoperability issues, membership timeouts, and premature multicast
group expiration.

Testing: The series adds the missing encoding support for both IGMPv3
and MLDv2 and includes selftests that validate the behavior.
I backported the series to v6.6.123.2 and verified the accompanying
selftests. The selftests fail on the unpatched kernel and pass after
applying the series, demonstrating both the bug and the effectiveness
of the fix.

Given that this is a protocol correctness issue affecting multicast
query generation, please consider backporting the complete series to
all applicable stable kernels.

Thanks,
Ujjal
