Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E43AA50A
	for <bridge@lists.linux.dev>; Wed, 27 May 2026 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866198; cv=none; b=O91ERtu2uZQK4rfrsQUAqCSOgN4ZRF3VL5m9vvgrSXwB9+YKX+06ITD+FZVeViz/0BjbVIkXJsFPQUGSObhWu1oEHq+yOGXSFguAbwB9Cdh2XL+Hih9Z8Ri39JiqEVm33wZZB8Ei870ea6xypoGe0i6AUK65EzFmj7545VFZKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866198; c=relaxed/simple;
	bh=vIxdAAp8PLpZ7PFhmWuqtC4SuKqVVjfiU2X5PLRSPSU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hPB//CwNDsxtGHGkkwggbFn7pptyICiDQfYHSg5bP/3LfW6dbz9v6q7Sq3J0VIwaZxBUUwVJfn3MaAlugHVPrS8F/bqvcRQYhQ0q9DwYaoynxDfPiLzPPc6+uzGj9O1Vhn5r53ZNqHARrO0ksy3QPS4hgyW51kOEoM9tak1O+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=fnkplXqq; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="fnkplXqq"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R7G6Vl002262
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 08:16:09 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R7G6Vl002262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779866179; bh=vIxdAAp8PLpZ7PFhmWuqtC4SuKqVVjfiU2X5PLRSPSU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=fnkplXqq1W7tBpY10raBDNXPnWh/hy7hSDTEHEITN4r+5gPg6kHeXyIwfh5U/5cnG
	 Kh/V4PkkvGpI/b7dzqB11kz5oLcJnc5jd/fodJfrK2ms7aZgkQQV3Od9rdfXr1E5X0
	 0y6Xw5NuAYfdeIKy34rqj9LQ7xiCxnG3HWXk8WX34RvcguyY+XRM8k2drIRm+yGKSF
	 CnrPdVDNIGKfiFj9dyM6WWzwkUrpEDZxgimUzThWPmVOB8hLyb2tRbMXdLOEUS+m1d
	 bbKSmYZEHT9xMiqwNqH/ASU9aJmGA8wkPEY8v2t4OQeY6x9tobP2tcSyfELeyyOH4O
	 /ERegxyFUjGIw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 1/6] net: bridge: mdb: add
 MDB_FLAGS_STREAM_RESERVED flag
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <946d52d4-1456-4cf8-9dfa-9bba96121dcb@blackwall.org>
Date: Wed, 27 May 2026 17:15:54 +1000
Cc: netdev@vger.kernel.org, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>,
        linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CEA01D0-0C3C-4617-AFEE-6B213C4B731D@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
 <45e7cd01f9449c8ef15a5affd587fe7645ecddb7.1779841530.git.lukeh@padl.com>
 <946d52d4-1456-4cf8-9dfa-9bba96121dcb@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Nik,

> We don't add hw-only functionality, if you'd like to have this flag
> you'll have to do a software implementation of this feature first.
> Also please check the slop(code) that Claude generates before sending
> it, there are obvious issues in this patch.

Noted, will review. I do have a software bridge implementation which I =
shall include in the next revision if it progresses. I didn=E2=80=99t =
include it as it still needs configuration knobs to associate one or =
more traffic classes (or priorities) with this flag.

Cheers,
Luke=
