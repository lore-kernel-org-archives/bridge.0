Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926461F2367
	for <bridge@lists.linux.dev>; Fri, 11 Apr 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386069; cv=none; b=V/GOjc7Dt+/A/HHHp9P1bU3qR8IKJJg8bLOdSxN0cX+iOMeQQttDd4VZZOPrUrbevrstTsk/YXxgNoznek9alvqH2n4uKGG4WXeTOSJ9/QxwnuPunxkPyiCzduVpRB4K3hcdkcY5lN5UO1jdlgVIFuZqhgW0o3Xo5VQTD5cbr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386069; c=relaxed/simple;
	bh=6xqHOzSEtizESNQeKofm4qGWhQziFiLceka4SYrVITY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjgqYJ/tQHwvZLgGYrZXIu/hnMgNmw27IpXl1B9ld2zW44ogh+/ceOs8z3Et4+9TIpSVKXyK6ZpxvIUfTfQOXIiLBtqXKgfGKneU0Epu0oEHh2tVRMbXcDUEdtiTXFHKEy6QhQld/AM+bCsDvTNR73SwE2MVGUCy6n/bwBZUi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=de9psyhY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="de9psyhY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac56756f6so1767319f8f.2
        for <bridge@lists.linux.dev>; Fri, 11 Apr 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744386065; x=1744990865; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1ER5xB9Jg+xmJZBLV8A7QxFaT92qRl63hkizFpOJiI=;
        b=de9psyhYRi7uyXTJDlB1HOtET5x3twwzGcigvwBqhePYKjNyMNDEELQm6R+HkfqGDQ
         gGIGMsS7cYovqCtt24GcF3On740qwDX9YpiiCaf4yb1eocPGbtKlllr6XexqMTq9lgHz
         6AxOS2VcjWq87Iy5TWLp6lqc9MrzAqs3YuhLFOKrsTbj5sAkYJgOdRqiLKz8vAuUK83c
         JQvA+ZxXvuG35XXJSVL+4LDhOYdZpCwXgTQiyGKmR5PeWPcpw77KiKEbzD4YACu0mL+b
         tLGR2eXzkoKawoES/PzkIB68//B8o1Ee/V4x06w6beVghRy3ZPmOnlJ3vQQz8FmyJucW
         3nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386065; x=1744990865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1ER5xB9Jg+xmJZBLV8A7QxFaT92qRl63hkizFpOJiI=;
        b=sQ2Y4TiA1hxJcn3XQR2KOVBvzHz4DrUuoMudWlQdZQY6LImjcRlwpFWPGHJ875onbs
         nA7Kby7cvDNj88NgOD+EvxgXPc0YIy57lJ/8NpD0kLRK8VOLfZwgewOsHLdHQ1RmHF1w
         BUUEkB1g+VGOBh6hONoVpctHogGSOuhPknv6qNkqPZYYyeBMSdP0IXQSpbIKY/mVt8hZ
         G916mYEtt7zqWt0SL4+R0Oktd+IznQj+H1606tanur5JaElL2PXsYrAiEYz2XWpVEvRX
         TAZnuUGTpRheQRCG7ODmV2vuy18iu82UXcEFXUGlO/586mtKPB388JWdjcExfA8siAul
         ksiA==
X-Forwarded-Encrypted: i=1; AJvYcCU2bl9w8eRERtQM/KpL/xKFBABLPNr/MCXDh5rtt8DlaqPFjSlM+rRckHC6Q+a62SbHXZ3sBS4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyyuZ4S4a5Hx3tpHwLgRmx+PVZuYy7H1iaBzDnSCE88h4tT/to7
	+qU5YqLSV+Q+MFPx3ss/Fmm0sDrMO3nPdCnJ2Y4Dx9Q0R76ZrPEijiTBAUt0dXA=
X-Gm-Gg: ASbGncsdtVDQEqLWxIPY865925iZ5hIOHNnMmD6E4XZ9MZdKUyb77w6w74CApGcHNjv
	iINDVZuDmPyh880EZaajRqyvZjS9THmidf3WGGEvU8a+9uLUBJoKFfy7/TO9VBO29HshJJAF1vd
	7vDYAj5S4POGW9ZQ6lA699opGgdIV6DIkpvi3QllvP9oHkBpplnk4U7LfmB4V6/+i7beHUwJVYe
	w66/KX1YDkrpidCrsZfbYu41I946Kh2sCzz05+doZhIRtrv/c0S3M5QXaFjoOdWzZbgyhOZErhC
	8o0d8bqLLy27ry0lpZrzIASLoK6PgHGCMDqWrSbkH1XEaiZN50nn3PCw752+7jqTdaPv9mY/sum
	LPiNb+J0=
X-Google-Smtp-Source: AGHT+IEisQGsleHy4Zv5Gzb/47cBIzfdWyFjOgUR75w0kWOWSpMn5SkcGKo3Imt6toqDOuEhLNofAQ==
X-Received: by 2002:a5d:5f94:0:b0:39c:1f02:44ae with SMTP id ffacd0b85a97d-39ea54fd3d6mr3226660f8f.27.1744386064350;
        Fri, 11 Apr 2025 08:41:04 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235b050fsm90397935e9.40.2025.04.11.08.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 08:41:03 -0700 (PDT)
Message-ID: <7e7746f3-3113-4f80-b9e1-71d28048c2d3@blackwall.org>
Date: Fri, 11 Apr 2025 18:41:02 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250411150323.1117797-1-Joseph.Huang@garmin.com>
 <20250411150323.1117797-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250411150323.1117797-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 18:03, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 20 +++++++++++++++-----
>  net/bridge/br_switchdev.c      |  9 +++++----
>  4 files changed, 27 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

