Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036436F438
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368871; cv=none; b=Uw1E8YbYEsjupJW3lfz7//VQzCx7aUBjIyjAkkqIA49eKwbdMeFWChOSELCQg4M61dVskyYGwAnxjQFe3NmQpw9CD/gxj2q6R7FHWdnlvrEqucGKOGR539Wvh7HtqbAR2V321aIb92U34WyBJAqmvooqi5K5mSYXS2x+gvZpkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368871; c=relaxed/simple;
	bh=ly+vK1eV0MGOs1RGreYF74zbHkfsvtS15LwoHeCeR5w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ByOXK2L2NAkB52FeJ+Hljug1zOvkYb5FeScH1KwQEQJVaIObvwotVdwn6pbV1Zcd5WzgDU6QY0UiRSeC7RA7fAJzXTYtUfctp4nrxijjzyZqqxf54jlUujESnuEDPLlwBy1FQHX6TWniNUe9IHdSNDejLzERM912SPMh7XzBhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YvxHHaIO; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YvxHHaIO"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca94bso7074845e9.3
        for <bridge@lists.linux.dev>; Sun, 13 Sep 2026 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789368868; x=1789973668; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eugk2zCKqcw2FGieDTlwJSn9meU/w6rFiEHk/2oTu8c=;
        b=YvxHHaIOA0N312/gn7Tpc/Te3jAt4m4knu2JyS6MNnk6u6lrhf2FlEj1StZGTgqcuq
         OPtqNldthUJt69PAa0NP98L2IgOqE6NCs5okUqlD6QJWPUwLEg41CxErqWZiT0g3FxTS
         DaKVTD9j3mJfJqYEFeVddIvg8IGD7m4EpS6wSkXfTVw4PMiv6QKil1jQAXEShgNMHflk
         GJekfZ9D8I/4PR+qN3zyrViAcW14ngLYFzUBEVDo//dOFzG60LWbnVW5Ztd3Euuz073+
         SKS+sybfCEZVzL5ccOFm/QtDMJUdaWjPtDfLdkIjWgL7rHZOoECtDT3pDYwF41x98UlG
         JOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789368868; x=1789973668;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eugk2zCKqcw2FGieDTlwJSn9meU/w6rFiEHk/2oTu8c=;
        b=iTOM64vjwWhPvh4i+A7DF5WbCqIB7CHNRpyaemyCFlobXST/3x24F4+d3vTzhM1tcj
         xZi4emBhEmIu5BsaAYRMOKkfHS66oZNBYf1zF/Zd9tpeO7iOyRY+5tiiAOvUkwZG4vqc
         aIlNDdFzpbvNtz5yRFHXQ8ytMMJwJyeKkpw5GMVey2VbDXi/8LpQ0AuT5ZH6Gc7A7EZw
         13/wFUtefgygergjsNnwNYJuK8CkzBdyShu7PL3mBii44CDowpBvnnC1X4IifbfklzCs
         CM3PkRHrL56Us6/C+blHt4iY5t5/bz8pKLhgVjcEyC2lUZKtFv/NVuL78ySqbira6NHn
         +XoA==
X-Forwarded-Encrypted: i=1; AKwUvBzyZfAcwpFnkijriWupwzShqF7/d/JeddCTtkAFR2LxDzX9kWczQhl71YHQWWKEWlXMw8YU8Pc=@lists.linux.dev
X-Gm-Message-State: AFuF++k5e4P7cTxrgMC2mPFB8G4GWtLljCt7UGnWEcldvkuj1Gfl0eCO
	M/ISdZI66UdrL2Zz40X8ykwwkucOU7vgrxHA5jZ5VCiwDfHxT5onrKez9942EGBECBQ=
X-Gm-Gg: AYBFou1TJRsU5u49JHVR0P90R5HoqnWx+DNjHSywP+4A3tiiOtKxlixIi82keY3fWz7
	XpDHN5ICPCzMRtZ+paJq6au6MLhZ8UZreaOa4OA+sGKY43R7EX+E07icVVzHD3dagwnugHdlqaN
	FTzSjO1i02n13KeAAbXjYTu51/hpG+s4wU6CVGZshtj4K6tHDvSFdWst4bZw4BpEf6Y9Dmu6wJX
	fyQfRH/5Rkt9/HP8qmL3aerCVm75hGXd8x+KPHJyZ4rBXhDjq6ZXAOaexcLXb8ZgNrdE4Rqn5n1
	if/9apyN8rYQNfTzu+SL2s9xyPkYQZokbs+l2NcboNJI30xY9P06CMyMbea9fhVnQrigjEGvB8p
	yw1y7mo3/3ie/+SQNqst2VvddkFODCpK5r7IKUSQudekDyxnqnIHPAPt463fiME6EUNMPS6+BL3
	tVY+cDJfYfRFUdM9MIM7vy3p8jPidE4LotA8w1pa7SfhqGxbJdjPnFgdeiyaBAq/GL18ZPzrAVG
	KpBGtPXA6VdxC3P/gSJIxlQs2WThg==
X-Received: by 2002:a05:600c:354a:b0:49c:ffe3:2b3f with SMTP id 5b1f17b1804b1-49e7a637667mr13448515e9.3.1789368866926;
        Sun, 13 Sep 2026 23:54:26 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm357607795e9.3.2026.09.13.23.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 23:54:26 -0700 (PDT)
Message-ID: <45f4c367-e9d4-46b0-9325-0182c936bc18@blackwall.org>
Date: Mon, 14 Sep 2026 09:54:25 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net 2/2] net: bridge: vlan: avoid NULL dereference on
 flush errors
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, petrm@mellanox.com,
 vladimir.oltean@nxp.com, bridge@lists.linux.dev
References: <20260911100645.1360386-1-razor@blackwall.org>
 <20260911100645.1360386-3-razor@blackwall.org>
Content-Language: en-US, bg
In-Reply-To: <20260911100645.1360386-3-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2026 13:06, Nikolay Aleksandrov wrote:
> __vlan_flush() is used for both port and bridge VLAN groups. The error
> path unconditionally dereferences the port argument even though
> br_vlan_flush() calls it with a NULL port. Any error (e.g. switchdev) while
> deleting a bridge VLAN can result in a NULL pointer dereference.
> Use a bridge-specific error message when called for the bridge device.
> 
> Fixes: 5454f5c28eca ("net: bridge: vlan: check for errors from __vlan_del in __vlan_flush")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   net/bridge/br_vlan.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 1748ea1fc202..3aa0e1fedeb2 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -467,10 +467,15 @@ static void __vlan_flush(const struct net_bridge *br,
>   		vid = vlan->vid;
>   		err = __vlan_del(vlan, true);
>   		if (err) {
> -			br_err(br,
> -			       "port %u(%s) failed to delete vlan %d: %pe\n",
> -			       (unsigned int) p->port_no, p->dev->name,
> -			       vid, ERR_PTR(err));
> +			if (p)
> +				br_err(br,
> +				       "port %u(%s) failed to delete vlan %d: %pe\n",
> +				       (unsigned int)p->port_no, p->dev->name,
> +				       vid, ERR_PTR(err));
> +			else
> +				br_err(br,
> +				       "failed to delete bridge vlan %d: %pe\n",
> +				       vid, ERR_PTR(err));
>   		}
>   	}
>   

Note that currently only switchdev can err out and on the br_vlan_flush() path that
is unlikely because all ports have already been removed. But that relies only on
the facts that no swdev driver will return an error at that time and that __vlan_del
returns an error only from swdev (currently), these are not hard contracts or APIs
anyone follows, it is by mere chance that we haven't hit it. It would be best to handle
the br/port cases separately as usual and check the port pointer before dereferencing.
I think this belongs with the previous fix for the memory leaks.

Cheers,
  Nik
