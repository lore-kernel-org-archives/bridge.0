Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F53A1A29
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372644; cv=none; b=s5J+6UPx0OVJgSz+pNyBxK+41jw8GS0QcmHbVaRlhZzd6s0QCoAPdnjxd2utddtausrPJreZfsVb0x/700b8u4VvnYCxkZscWqrBVdjVCkqzODcZ/hLO5Sbra2O24Fo4xU2rSGALuC+8u+rhGapltFRonyXY6N6RXWz5h3zazQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372644; c=relaxed/simple;
	bh=fk/KCNGIGqU5wDmfahQyXniObJrM97UDdoYWTGTMtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahniq1PFu/aixrGlk7xqGo5J549wCr+nn7S9CxNmDviUJOm2/U3ZXlWa+4DGw+QHSAH9lrqOPcM0sgmODIGDON/m0j/Zq9Vw6PcfykRT6+Zg3aS/ohXmR+HPf3lBW9fDHzfKT0dVYENRtpsqgEHtvs81O8H8m2YSq8YsPT1xkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=muH0ZxqY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="muH0ZxqY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49e6bad7b79so15228675e9.1
        for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789372641; x=1789977441; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ov1XGcV6x2Ewxc2p28aGPDAphWY7SIsit3j0snwG5Lo=;
        b=muH0ZxqYpdm78obH+YTr3HivXYdhe4S9kzTvqGZwsWtdWuuofeCF6xcMIs7CFRQvfZ
         RHAtRWBpVTq0Eaf9AnK5hwteY2pALwOMvvPpB0kYNAHEogDOnvqsTs7Y6YaN873Bot7s
         ljHX4jpYMIARE0VJEbSlXWmruPmI2DgGExgDACEwaBuJBi+KY4ebTRkMr1OdKLUd0QWc
         Hs6pNIrPBFyPmQoHnfUcpi0yBDppqaaOJ4SGYXlVEhgN5Q3IMm0Cb5SZL9psAxPeLUke
         PXuKhpYRs5AsuoMhP3x+qsx/BB724P0PQHrLjZa+/vvHBQ3b/gDxj+mYYjfZKLuB2jyP
         +e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372641; x=1789977441;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ov1XGcV6x2Ewxc2p28aGPDAphWY7SIsit3j0snwG5Lo=;
        b=L7gXVp599vjRI8rwehi0jw+H3nWGhIXN/rmX5KbN0DcZYQhILdH9LCkPRsSWspgmmd
         HBWQ/qXs+vAoozH4ocz5qmSjuwXv8TmzVozHJJBYqwSPm341f0tchoFR81IurW4m2A6i
         p4wfNjjMh/8fzLoI5ApJ++0Mmci4TiFuXBiAhrKWrKiGIMipACy/5+V1WFiYPc7+bUEy
         gbtpJS9PV5lX016gh6IUaMufTvQbpGeBASXChT1DYUnznOK+s6g0fLHZ1sXpwLWRIVia
         Hy6woB2g9po9ALc/3u9ytByY042LcOeKsWg3gwxoLTAZ1S+W2i1kl+D6XJpdvJNPrKqq
         Ii7g==
X-Forwarded-Encrypted: i=1; AKwUvBxQ9fXcOzpCzBKmyX3Oq4ek1wEPWtU4AsA0sZb7LRNheA5p0lKfoNSW7I4201iiHw9afuVIgrE=@lists.linux.dev
X-Gm-Message-State: AFuF++lENL4yk82DC4UOVmV0/C4lp/IKRyzBQf7NV0i/Yy42bek2crrw
	SFb6lSYQiBV55GRtW+YUkpC1OOdbLoWxIB45OIi0qca4lNiYcfV3SFhkHAIj2kIdR68=
X-Gm-Gg: AYBFou2yT+HGBiee63FjmJZ1BGlaGeL1Pl8+Rqrh/eT16nbh6Jfo2ThFIqP0hZOhxLg
	8pN1DxVP0Pp1GUBVD4syXfdgesaulvA9V4eO+PiKPVLv7IHIzB0aRrc+rWRg3a8mu6/pxmUvhUs
	wTE2m+Xd23QJo+uzwhF+UlGon540OR2fndNV97MqREDxXHQUhCcnoFsfgK3Htr9Grx5NXO5rETx
	PRf0gnSw5Azp/vde839CJj97xqJlpJhpt7KI+Y0JJ6355Zwtax7eXNsu2ccBrfOn1ehNrFWTpVO
	KZMy/b9brHx5Eh4XhHRZGGlk0AwmxMNfMVbSYDzjNfnx3VNghsEsIPjRIXxmxpRgxRGMdqfdRBx
	2YXzNQiSP13jpqXN9huij20YfoBeSP/37u0PYZBoWHY9S0WKl3NdG0zZonbXax69G7SdI5pbcUa
	YIaszJhL+McGvtJ9f4HLKLgAQRMgOAG7zlRCY6PoJp3e3E5O9cTLNVXywMV4nVPIceZjvhfiBhK
	sF46kLfg5FrJstS/kO8+QbVlu/3kO8=
X-Received: by 2002:a05:600c:3586:b0:49e:747e:c00e with SMTP id 5b1f17b1804b1-49e7a64e729mr17751295e9.9.1789372640697;
        Mon, 14 Sep 2026 00:57:20 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm25193528f8f.2.2026.09.14.00.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 00:57:20 -0700 (PDT)
Message-ID: <3c85a4c1-b7d7-4027-9a37-7f9c05c8a2e6@blackwall.org>
Date: Mon, 14 Sep 2026 10:57:19 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: vlan: fix leaks on switchdev
 deletion errors
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, petrm@mellanox.com,
 vladimir.oltean@nxp.com, bridge@lists.linux.dev
References: <20260911100645.1360386-1-razor@blackwall.org>
 <20260911100645.1360386-2-razor@blackwall.org>
 <20260914075459.GA179479@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260914075459.GA179479@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/09/2026 10:54, Ido Schimmel wrote:
> On Fri, Sep 11, 2026 at 01:06:44PM +0300, Nikolay Aleksandrov wrote:
>> __vlan_del() stops the software deletion when the switchdev operation
>> fails which is ok for an explicit VLAN deletion because the VLAN remains
>> configured but not ok when its VLAN group is being destroyed and everything
>> is being freed. __vlan_flush() always destroys the VLAN group after walking
>> it regardless of individual deletion errors, so aborting the software vlan
>> delete leaks the VLAN object's memory (and potentially its master VLAN, due
>> to references).
>>
>> Allow teardown callers to finish the software deletion while preserving
>> error for reporting. Save the VLAN id before deleting because the VLAN
>> object can already be freed (queued for freeing by call_rcu).
> 
> I think we should only log an error instead of aborting the operation.
> 
> It's not really valid for a driver to refuse VLAN deletion and it's
> inconsistent with the 8021q deletion path (i.e., __vlan_vid_del() ->
> vlan_vid_del()) which doesn't abort the operation.
> 
> Also, by the time the switchdev deletion fails, the affected FDB entries
> were already flushed and the PVID was already cleared, so the state is
> inconsistent.
> 

Ack, sounds good. I'll just report the error instead of failing the delete.
That makes it even easier and drops the need for the second patch. :)

Cheers,
  Nik

