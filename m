Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6939FCC8
	for <bridge@lists.linux.dev>; Sun,  4 Oct 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121485; cv=none; b=tWeRpnzkaERgqT1ZAmDA4imFpBOfIWsxdSwwjCBD38MUZ4PAD2wWKWLXFbCPuQ3yEKqzRMFw9hx8nWsbap3pRtEfH6mQe9NfcmeX7M9TFwv5h/hdXSBNtJLXy98YaxPDd2ueOyYhx9x8v1tTcBViSaKMbIihNqOznLaja9HvhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121485; c=relaxed/simple;
	bh=ln9flUKLuXflNGj9stfywtJ7V/181gsJo/hWYooAygk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gb6V7e01nz5lf8X4w0yOCZHATVnQvjR3tG6C8e6P4THR2WGfkClxSPMHGz0lgESjoH1apSUV8TxbeCeoHUIAN7Nmcb9H8GVZgCDcWWPk3o7R92hyEOicWbrdZD6nPgFKqcaRChDCtGZ/W9MvtzP9ykFAVGmeCeZ3fk947/q7hew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MdME/3FV; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MdME/3FV"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af0707d41so415094f8f.1
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791121482; x=1791726282; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/AXmPQS6GE1nJ+OCjL7tvM9iqkO2JwhEp916Dgp8F+U=;
        b=MdME/3FViRMGYkI0XF0Dy7HQF2oYomRJOvb7NrbevBSfxsJxQnZc/+ePvCz9ucogdF
         /azU3xUKkjWHnRl/AcF48FZ71UJjvj7DPWqB2beOkTwDLP+9xyByjplOTCA51187gNjd
         IsMR4I7zukV8OIMuAksi/Imn0r9RW4P9pTITDqDZZGqRK1RzHatiFOVyrXXYnLKbD+C5
         6JaNSWXwLRIc7LS0oy6/rTuT7W1bwXfTw/B7XFp9Vmap2G/RowbcQtSKP9fidGttJexk
         UwhK2u0IzArqPu9W6xn6zmcfq5vQW5Jss+fcpfvWE/Wf4LaNmF7H2J9jSW2M73RS0TmZ
         EpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121482; x=1791726282;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AXmPQS6GE1nJ+OCjL7tvM9iqkO2JwhEp916Dgp8F+U=;
        b=I7fAU7ms3FSKaIjH1L38+mYZeFow2Hg/ZBNQwYOPqjOJlQ7JxnSdeKfJz6gw+d26Qf
         27P/QYT74FMLXDgdj7o4ceb8frPM87mB0JUOmyRjDe1Crm7aPPCifB9VWAJxDgEzmKbs
         6rwgSQtw7tzZoinMJ0T40aQ8hdSUDgWH5D3l3WeXaO0XGT/sgHeoqiK2H80gV9p2g3Ia
         +Ifgy7nz4Iw073HLHfoc82TW/u55ypDovEX9sT6PuuryYmjOY/Pw3rrC+RQ13wmjSVCC
         vz9rog9oCXJFq2cnqxCASDzIFgU1seVpL+eyi5CFwhDEA9oVT7tFVZmA58KmRAC1oO3B
         +RcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPv0oW+tF4+6DXDiEGbHdJ4tygA1/x1LCyG02Bo8Y61MsxIChjNKHpbzk76vrzOd+GFnjpiU8=@lists.linux.dev
X-Gm-Message-State: AFuF++nYOJyojvUve1XxGeK+kKjkJG/WQiAhis4RtkV5HYrhaz7bTnxL
	4JkS2EaBgb9ka68SQEWNrBd+AJ/6wmufZPm5TxSMi16mffeJqcsOF8MQCyI4y1xNm80=
X-Gm-Gg: AYBFou3+PTvL+xWFaD7YT/8+os3RGtKhrF8xBScBYSjCsEhDwyGYR3sW0Tq/pY2FVBP
	rCKJ4Umr2O8xGCg66xNkGJ8BCuMJdUf8T34SYDL+Dtfn/GPVaVrAli6qSdhB6U5mt3L4gULl5jG
	kcIt7xzJiUON4hDZCr2KTpmDiCsXuQ0T4X+WBOpNibyjTZvUMLubOkrWcZOZhh/q72pgU5mPww3
	3UD3Zj1vEAr3Ex2pUuzSmn24etcJ91oXkUxD+5TiVS2gHN6jPkq0EWd+n50kkmgEVxf55ggb/sj
	DSw9t6U5QcCewE/djn+inbx0/h+8juSeKUaschyKyKBViLgGrQkRH+fFYQDUFyXT6kxUSfa6LdA
	jlAL6LR6PHpfTYatqHCOD+oss+rIQkpD8Hwpax2P2/413WKnD0Dt/P5SscN5rEwhYbVWwKEU3WM
	DcLFIgs3FQLJBb11tOJ/Mf793e3iEo8UyQWO+IX3/TPnnthv0HrWoNm0GPLJnBJcrgv/xZZUWRG
	1fA+SUofI/FsWKj/kJ0wfYoB6xQ
X-Received: by 2002:a05:600c:530e:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a027534c46mr151316115e9.6.1791121481987;
        Sun, 04 Oct 2026 06:44:41 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280be5dfsm287188975e9.7.2026.10.04.06.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 06:44:41 -0700 (PDT)
Message-ID: <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
Date: Sun, 4 Oct 2026 16:44:39 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Content-Language: en-US, bg
To: Julius Bairaktaris <julius@bairaktaris.de>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: Ido Schimmel <idosch@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
References: <20261004124254.3525496-1-julius@bairaktaris.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261004124254.3525496-1-julius@bairaktaris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/10/2026 15:42, Julius Bairaktaris wrote:
> br_fdb_update() lets an entry roam to a new port without holding
> hash_lock. It notifies switchdev that the entry left the old port,
> writes the new port, then notifies the addition. When two CPUs receive
> the same source address on different ports, these steps interleave: a
> driver sees two deletions for one addition, or an addition for the port
> the other CPU wrote.
> 
> DSA counts references to a host address on the CPU port. The extra
> deletion fails and the extra addition is never released:
> 
>    qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2
> 
> With one address roaming between a DSA user port and a Wi-Fi AP port of
> the same bridge, the error appears 3-6 times per address when the two
> ports receive on different CPUs, and not at all when they share one CPU
> (4 runs each). With this change it does not appear (6 runs, different
> CPUs).
> 
> Take hash_lock when the entry roams or its flags change, and send both
> notifications under it. The common case, where the entry neither roams
> nor changes, stays lockless.
> 
> Fixes: 90dc8fd36078 ("net: bridge: notify switchdev of disappearance of old FDB entry upon migration")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> ---
> 
> Notes:
>      net-next 941056f91907 ("net: bridge: fdb: factor out existing entry updates")
>      moves this code into __fdb_update(); the same change applies there.
> 
>   net/bridge/br_fdb.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 

Absolutely not, this was made intentionally. Taking the hash_lock would further kill learning
and roaming scaling. Surely switchdev drivers must have dealt with this for some time
now, if you'd like to fix it do it so the software path isn't affected.

Cheers,
  Nik



