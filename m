Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D711D5CDE
	for <bridge@lists.linux.dev>; Sat,  4 Oct 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588310; cv=none; b=lXCg3+8DvSHfL8IECv7MlzxdzSPJerZEAh8LaEMB25CZxUNFfqM7xcTYtAyeskCXYhHble2ryeoX0KsK0aB4SRdKel3imc+zDjP8Xb3H24XUs0vey0F6lr7Zy/67arjZRgO8fkgZafE7gvlNAxjAtqlOG9vAXeyjwizp4dyO6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588310; c=relaxed/simple;
	bh=xIpon02+PxxhgZvHq/oo2SFJKUD6pPkmd3iQGroNCAw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BCFnQ0t2L2jsO2zKpCcIAT/ktHs2SJUqEprHNTUXC/R3X1+ZOW+tkuSS+QrJKYGKRZnglOt+NdMJiAYMnI14kDyJ3SukGNurgPxaUggQiZKA9AmR3hkQmhEcx23PztMI0q45/fbc6xkFWAoMTKEi0K9eXFGLvQyqIjkZLnfXusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZnJFKX5U; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZnJFKX5U"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso6163088a12.2
        for <bridge@lists.linux.dev>; Sat, 04 Oct 2025 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1759588308; x=1760193108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIpon02+PxxhgZvHq/oo2SFJKUD6pPkmd3iQGroNCAw=;
        b=ZnJFKX5UMUdU6MmgV2051tHy0i0CzrBk10iyjL8dc7kfk5YMO7+tE4fgutkLmTG8Ga
         2XEOJY53ybdocv4/6DFy5fDTX9i5oII8QU4PHmsAhWNMU5QgRrRs8Kmo3nNA4gTgGhhk
         ipaSaEGei+z5hwbhGx28c/L+4KvzTUhKIn1pM19KFwlCjnzR+GVkHzZzc4dEFEd3Uo4f
         OJrWCi6oscsSW9O4XvAA/xmFfPCUj1+Lt127rrlSk5nLdXhHYSmH1tkSQf60fX4czPiN
         gc2CiEOGypKB6EnE3ThR5oIbYNAb7cvCNZReiWzREa/bCU954oECIS2XnOHO/5G5TE0g
         v43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588308; x=1760193108;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIpon02+PxxhgZvHq/oo2SFJKUD6pPkmd3iQGroNCAw=;
        b=DXY46gJKGqz1+ZZd21WcHGLW0wLnI7d7Xqy7F1J7KxJR4ufEdw7XiCORZTXYwMzFIQ
         VVm2trrc+ohGGjXxJ3CSkEDEKvKfYqsnrf4qBxRIPCb1k6xQ6xPLrF/y9r8u3xJbbliG
         H9go5PRfV1ZZNoxjSFi1gV6v417a5n5N92ffunXeBHCJV9M6c/hdWOCvdjg2ljJphH45
         Jmn4wsT4jlZpOwbQguDIyILy9raGTK79TcMEEGKRIqeire+CXTll0oJV71yoOgXWyggh
         zxfVcj/f3t8Gig3XnCh5biA1TC2TdX5vXFzkKvlXfdkLvK+G26j89KFiI4Keos0hWrQr
         FsKg==
X-Forwarded-Encrypted: i=1; AJvYcCV56MzKhimLBQmi7WSzOaHiWBexEgWN+mNJjg0THK/5oPdSth0anyzhp/cFbWIpm8dFOGrTeos=@lists.linux.dev
X-Gm-Message-State: AOJu0YyANaD2biRBCwfKHcVd663fg9bkwdUCW909BfMdjF9B4Zq8Ooja
	mVFrdEOOs+/ZOSEhbF1u43AxPo6j2oMdHuQ0ck8MLha2afkFTHTcV4STUFtvWUxCdvI=
X-Gm-Gg: ASbGncu1ZfQxzLDSbNg+/c9NOYFZQaPPPfPRHvAYoc46u1DyEMNVISn0QXMCycjiysX
	TudAy1QuHWIYGb6gInsnEH479o+bXNH71Zl8RJK37h1YJnY3r6lyTxmRCGJW3F2JFFFKnCCzQiK
	07HvRocijYhtC4uUTlOjajbjYc89oZdq4ED1f6LS8N8ilKJD1Mcdx07ZxTtGbEqF2vHZqb9MxpM
	maYz9cad/24ixrJCRiz9SqNBIqYiYbo7ozS5o3VakWJw0D4ZeZkrlpoU2CYdIkhdDkzbts/Wrwq
	N4OymnMS5iFuSj+ndlu/mUhMwaLHE2Wxh1kWKGP9wFTBj6c53i4d7qHxz9MVQUBmEtwMP4Xus4O
	WXdMMfWs4SFM0/pApvueRMiogS9LQlg0kbm+4qwhbYZHFSYm5uEqTU8CMTyyEBjkflA==
X-Google-Smtp-Source: AGHT+IHiaKgJ510GpGFJf/bD85KK6EwJE5YnqKxoe4rZdpetGANffy6OLHDG1PHEb/0alwwlC6EX3w==
X-Received: by 2002:a17:906:f599:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b49c407397bmr880852366b.57.1759588307449;
        Sat, 04 Oct 2025 07:31:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([149.62.207.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b57f0asm692110166b.77.2025.10.04.07.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 07:31:46 -0700 (PDT)
Date: Sat, 04 Oct 2025 17:31:45 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: =?ISO-8859-1?Q?Linus_L=FCssing?= <linus.luessing@c0d3.blue>
CC: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_00/10=5D_bridge=3A_Allow?=
 =?US-ASCII?Q?_keeping_local_FDB_entries_only_on_VLAN_0?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aOEe3XKr25GNGZpr@sellars>
References: <cover.1757004393.git.petrm@nvidia.com> <20250908192753.7bdb8d21@kernel.org> <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org> <aOEe3XKr25GNGZpr@sellars>
Message-ID: <171B368E-D819-4AA9-B343-EE1AE529F8AD@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 4, 2025 4:19:25 PM GMT+03:00, "Linus L=C3=BCssing" <linus=2Elues=
sing@c0d3=2Eblue> wrote:
>On Tue, Sep 09, 2025 at 12:07:43PM +0300, Nikolay Aleksandrov wrote:
>> My 2c, it is ok to special case vlan 0 as it is illegal to use, so it c=
an be used
>> to match on "special" entries like this=2E
>
>I'm probably missing some context, but why would VLAN 0 be illegal
>to use? Isn't VLAN 0 used for untagged frames with priorities? A
>priority tagged frame?
>
>Regards, Linus

Sure it is, I said it in the context of the bridge which doesn't have such=
 support=2E

Cheers,
 Nik


