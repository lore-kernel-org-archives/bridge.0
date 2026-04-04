Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783691DED40
	for <bridge@lists.linux.dev>; Sat,  4 Apr 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323556; cv=pass; b=rnejn7VHnHxSwU+a/uo33hhhx2emvKmtHK2EI3Y5yUR37FaodW/bYmSQ/WdU/n5AdKfTt5TS73LxCv8u6TzeCgXRzFYJ8/C4Zz4uYBMGpIEZFwKXxnWhJAFTPkeUQMPy5wkMPfNpI0crY2DNmdbIsXrSDHwro5hamCy4EUTYrx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323556; c=relaxed/simple;
	bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZUccowhOL3Zl8DRBEFASWU7Y/Pv/j/4Tbq0i9Ta3DL9ajSQQouxf1jBTOpiqtWA5ZH4L9ut3ErCxamYOl7uOh1f3HGlFjS5ORYrb/PVg2CPip4eIvn7EV3SSqWI0M9MjYm4ECfKNrdoeDEBB2a8mbj7Wsqg43hQmLZFOvio3UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4eH8Ur8; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4eH8Ur8"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c6f1d1282so179407366b.3
        for <bridge@lists.linux.dev>; Sat, 04 Apr 2026 10:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775323554; cv=none;
        d=google.com; s=arc-20240605;
        b=WXCXpsEsO6pZEEBbIL4HBhqnxhe6L3sax4LPJQ/TpP/toNzE7I+MtTR1kEULePUx4U
         +kTtz/XuiiUiyL/OIJBtie3byTwJyRfZrfs5HOMemmkcOeA/5l/2ExCx2z8fm66wz4x0
         ZxDfuLcgdLqE8xHPHU6+I7yYIww3QY4DuhMXX8nQysMuyKSmkyf0ecppOnQZPd2JrGKq
         mLHF/ZNlSA7KZTuaaBjHqDQdSaSDNUIJhwTGv/0d60py34XJ2rFebpLFv0+11suP+fyX
         jUPhQZHd8p6pVzrsPCwf+aKa3IXc7Va8DZxQb0cX1DK5La0QHW/ocPzybMM3GcxfEqQU
         HZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
        fh=GhzmAPOcYmV4uxeYHo0LT5UlRsGZbKvOPpaZNe0XHAw=;
        b=GnJnwRqKKMc2g1Qk9weWwetUDndJYbS72a7moCOU/btTaFs9KWgz8rHeoibUoUdU0O
         n3SLqiKHQXQ+XSmyefmwMf9TdUhunrqts3EcMu0nTa/Qm6SjD3T67jd0REHXdAjL1ZF7
         U7m2TAiMlD9D+AVDqRScurKhSfxOY29QL+cClIrBBX4VPPm5wb9eVF6kPDtacT1ewXNu
         UET7ypVWQCk+WYPSS7AqlCZ8VDK1dw525qeDRYD6ApebNvTWy7mT2qgnJ5qygVyVaIpQ
         TeoKbZ2I5t6kA6CTKMbtVZagx8FAAZXRwHDG9rnvewOwjXgfs72Yb1JuvdCAa4tvRE87
         1OFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323554; x=1775928354; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
        b=f4eH8Ur8sfMZIwZYuWLvrBFPaW7P0K3UgEkgBSNFxpUw5JhIk6+c63xo8TTgi0YA13
         eVxXpg8UiBqNYJxIWabAxRi2XDKFmUvqhXBrJdH2lnquqdpenFAbhjmv0XESldyOzPjw
         E3yaxnLkph4wQVBh0H3V/nqispmKhFOy4Z6CPuS056U4rBGxYRF/S6RXzr5ee2xYS+bG
         gXKR9XG7cuTANiATI4+/jh7ex1MCQJ/5G8NaIGoY3pDlKtbpsw8YkXmRHosIiD1/+voM
         RQviapBHjocFNWtMLo9L1B8gN4sf8wsxLjhE5i7AIBYMuAnb/6n2w3e9tNLbOrgoy6dJ
         4HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323554; x=1775928354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iidgvtRYuaAhqrnd+5Px2QKaie9WCq8NPbXMgIRsVnU=;
        b=MscGmf5BbSVupcF8nJTzDvn2fHX4oJKrTMmhoe0CfHE8FM0BHRMR6jkoNCc6PY0JE5
         hUuoc6drEwhBnmM03L9ZC/h79W5/2RuTpJvJjr/IghhNgzzdH8AHYVeyngO3E2lzsOZo
         Z9Uu224udMI+J1QL77kTrwqLnDnbHDCJotcc31++Y5JzGJnwcz9EmnVrvyL+ydNg+VMj
         nDzIAReSyK+93cQ4jrnZ9jTz4hxiZebGtjKuoSX3wkiYfrPkvGpRvfPgS5zDyPfXTaUx
         cRpMfxdTPUDLoqBo5Da5vDVnpgpChi1Uny+hVqenpFGfO2/uO+usfxAAUdeX8405myOs
         AVJA==
X-Forwarded-Encrypted: i=1; AJvYcCX4e+Umf7OJAO8WMhDyvdnHt8ZxXfsv0nkvnIK5GNfyojL1BTUWcwJPTfvl1YYY7w6FeoGTBqI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzNP/SvA+KKRmZ0fu5V/clqt6cvYqVrzMsvidMJFlyFUByQiVLX
	rs4sezzFaTnrhSo1eZOm5lpzcj5YEgsh0H+c6XsdCGhChNEH6+jO/LwBDARzQ92nv6jAJWuoWFO
	+DQe+Lp2RjVA/wpO6W4WfMGD9ol1j+jI=
X-Gm-Gg: AeBDieugp/sqzMMWE7/6J2lWoWywSORT3/plpULdJfW21L2Rrh6SJzIgGBbhhn+77G0
	DxqsFy96EQIgaV2cKu9ibXhvEe9jBNQgKt6cxFPlY5di2zy3bcIrwPCsk7GfXInUy/s0049+XiQ
	SQQEBk1ZmjMoryalB+wLHADUq1d/r9XPMmNMx7MlHpea1ryhHsy4Z8y+aOiJCre8RL2uVA/ow54
	uikGIL6VYgFxCTs2A1CCsFjONCPXdbz40TqcYC2LZaPPmjRR9mQ7z7sxSOkphXg4Fq+y7NRaX/q
	fMQkSwc=
X-Received: by 2002:a17:907:ca19:b0:b98:4b8:1046 with SMTP id
 a640c23a62f3a-b9c67922d67mr245594366b.31.1775323553422; Sat, 04 Apr 2026
 10:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com> <20260331141647.GB1637150@shredder>
In-Reply-To: <20260331141647.GB1637150@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Sat, 4 Apr 2026 22:55:38 +0530
X-Gm-Features: AQROBzBVeQxzaE8wUvFhFsGym5EPOw52jRhY5t-OqeOyQKNixaLBWAKYKMiyQyE
Message-ID: <CAE2MWk=CSaijB_x0BzMtVGjuibqbzuCov8y+3Hm2UodrJJpF3A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast
 exponential field encoding
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	Kernel <netdev@vger.kernel.org>, Kernel <linux-kernel@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, 7:47=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wrot=
e:
>
> On Mon, Mar 30, 2026 at 07:16:06PM +0000, Ujjal Roy wrote:
> > Description:
> > This series addresses a mismatch in how multicast query
> > intervals and response codes are handled across IPv4 (IGMPv3)
> > and IPv6 (MLDv2). While decoding logic currently exists,
> > the corresponding encoding logic is missing during query
> > packet generation. This leads to incorrect intervals being
> > transmitted when values exceed their linear thresholds.
>
> Thanks for the patches. I will take a look, but please read:
>
> https://docs.kernel.org/process/maintainer-netdev.html
>
> In particular:
>
> "The new version of patches should be posted as a separate thread, not
> as a reply to the previous posting."

I have updated the cover letter title and sent the new version as a
separate thread. The same can be found here in this link:
https://lore.kernel.org/all/20260403150050.1235-1-royujjal@gmail.com/
