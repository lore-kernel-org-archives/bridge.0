Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF547F2E1
	for <bridge@lists.linux.dev>; Wed,  8 Jul 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534412; cv=none; b=fOYc87EFrBbosW0EPXW22TPOH2TK6Ol2WfQI+ziW1BIMaPrfGyWs+J5PtDusEtEv//JryN5a+HQwIPsDMKK5QCpfBL2viCh/G/GEnJaMFKP4RS+tnwEQ2cmsYgodXinWuwvUXZoPXXrxh8pZRonSwiK73bnqdYc7AiTS0CQcTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534412; c=relaxed/simple;
	bh=mKB64eFzBwevlbfHP4GHbGCdzZzNbk41FGpjUYsfux4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeZJyqz0x3BiZZT9jZatTIWbmyTJuEMtCrSuHHXo5JVJuin34eoYg12Plb+oS/L/VFWNExCZQHut9PkYbmWmdyAWb0eXnUggdLl4BRElrQRTxRqblEGnTJjMKfSwHFeG32Bv3oA/QeO2lw8p/9S2K8TJ3s2KakvJfXmFNjW7I3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W0RGk0B3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W0RGk0B3"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4758bd3731bso89863f8f.0
        for <bridge@lists.linux.dev>; Wed, 08 Jul 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783534407; x=1784139207; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=W0RGk0B3P+wqm4AgZ/vsB1z8Yw32zZNsMPsLdsSgrQ4ja6BX7OqqjG0GHaEG7jM2kR
         0MLCkfHo22RaGnDpPiix0O6gVcZgeRBee6fxPVw3Gc2f4B+Cp2wZK/o1sVxtz8QDxfMh
         +sssDK7iL8L0VWIPQl8/Tu/cYKt1Vw1pDVt9z38vxqHUBJrPeCZ/5fY9vVAM1XZjzyqu
         +NvI0kuqgDbuKjPZl5/jF4/eUHH+m0QKCQ0BgDqrRbHza7ncE5mEjyHHazbQBJ7ICBY0
         yl6qprqBLuV/vgXXxukaxViq53nJMTtUF395uQof4qCJ65/KfakHKr3PHCAnzAoPuR3I
         NJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534407; x=1784139207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
        b=dZCaVxqpUEwKnx/KsZWkYqEvd6+E+jN2BTkTfUU4AqIzMsIHP0eyLbYYx6QrC2fLYx
         5sJMBmrTZIhOJtm6+qqmmIilB2vnPIyQ2iDmDoKeKwMoGishh9WfbhfIEm/SXksaEB3H
         pMXkxRH+mqejREHMV1i9nlvGTYU7Bdjyj8RtKu+7vnvZAfKJfDdoJ9wWbj/kGV3e1nmn
         8KE7PgtKApE+cKVPWYd7Dyioth8GYt57Ee0WdfOFTwrVJ6xFBdL9O6QvCNOLV+732LJ8
         NKPT/tvAvOYIubk4dTjH/zv+n6mRWUf+3YEomMZongmAatkoBsX93ZMRrH+lYW+HCThB
         v8Ww==
X-Forwarded-Encrypted: i=1; AHgh+Roe33cKERl9tlh85ZWH73+u6qPYGyWUx31lB/Z6HnKyceFYugm3E6zVn0xpsvMB8/Suv9fmiBg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4xhJOtZdQ4gfb9rL7KhLbKcuxbwyTenzze1PwjFge5RS9ibBQ
	32KkPgvG9By6234WcFTaRBjLEy2KwPBXoVOvaGYHWaoUER7JHJy23kWom9wkw7/KjNs=
X-Gm-Gg: AfdE7ckHfZ1By+NN9zQNkseFMzl2pJpxNRejlsnO7VTUZkquV0kOdF1AuIuo1kGBORF
	X1Gpn6LqNmCF71flxMC4l/toZ5g5t5K5YTotA9oqB2a4qICEATBjnKq2EJMDkL1kNQ8oZjhKZNJ
	wtj0FHpV+DjiIsyWsPamGRNc58iXFbwCr/oJZE1TeMgR3mPOzxA/GB2T3ZQX4okW3nwoJO3giof
	CpKpmQYVw/Z09tTB+bxI8DNN4+u9rtLtHkTtoqT6vNcA+DKQDGeAMzT8PWJXWwjlxGmaWFDLgCg
	SvWJ9uzft/q6t1hrVd8ALHsByyYvwa4q/c/L/qq05M64yXSb9xAkS2JhDJe5DWe9FtYgmriDo8J
	hrlCiuJEEO/xZHWg3hnhwjlrBMf6n4HH9u8QOpu0BJhXEJSC8KQXahieKVXPrpGsGiOtAg1jL7c
	HZKTnAar/qDTXLVyKfbWIGaIvPMNIcuM1CgrChYg==
X-Received: by 2002:a05:6000:460c:b0:473:c608:eeb5 with SMTP id ffacd0b85a97d-47de9a4f159mr9196162f8f.29.1783534406837;
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm43325516f8f.6.2026.07.08.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:13:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>, 
	Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, cgroups@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
Message-ID: <ak6STbqZd-Q-c56v@localhost.localdomain>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kijzkd5xnaepafl2"
Content-Disposition: inline
In-Reply-To: <20260708154510.6794-2-petr.pavlu@suse.com>


--kijzkd5xnaepafl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
MIME-Version: 1.0

Hi Petr.

On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> =
wrote:
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a4337c9b5287..60eb994c32ae 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs_parser.h>
> +#include <linux/umh.h>
> =20
>  #include <trace/events/cgroup.h>

There is kmod.h in here too but it's unnecessary, no module lazy loading
in this code.

Thanks,
Michal

--kijzkd5xnaepafl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6TOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgY2gEAgOkCGIEUNQ8/AFfxYtdb
0XG1ZQXkD0d1Rm0cAq1+u8cBANw3nWI/wHkp5zcHmZWevxdnweU507gsyVTXzMGQ
ZwsB
=k+w6
-----END PGP SIGNATURE-----

--kijzkd5xnaepafl2--
