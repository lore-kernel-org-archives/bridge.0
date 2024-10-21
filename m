Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503131F4737
	for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507014; cv=none; b=ppP6am6dyMoapF5hwLJvT64EkVowIA5xW4EPJ40IKdDpM/K0j/ebiueUYdjBLoIhFCYvc9bRGBX29ZSNKSlOFwyQwRSiehR2l77KfmfNfp+yGNMC+GMqG1He8Rf5f65qNHcqzPhuqT0NQesZ35bHus02mcZLjejUbKlS/QYn2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507014; c=relaxed/simple;
	bh=lPEiblptSouibb7WFhNi9rGs9Bb3s7/GT0xRZ4fg4VY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hrmUoNfyZLNDQYK2M5RrIH6L58+GYEkNoZtMbv9tXF3xF84EuBAYsiiumyHxg+LalK6PoVVQyzN7ujQAysZuID5Cq42zVyIofIMlW4IS4rf8fSScN9mUcstvCCv5ICtRpdZZrvJsHK0L0l4p64LFtSw9q3P96nB/5dG4KcIpn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PA7DDXzE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PA7DDXzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTSf3YKmAE+ZgWB5bS9KvyFO6sfcn+EvZQhAD8CYTeI=;
	b=PA7DDXzEv9RFt7KhqM3VDj7sp+bjYidf2oBrqaGtXzZi+8+W5ykaUZHnvfKh57UMTZV7sW
	RldtxBiQ3GcRDDBYAbaxXEt8CR10zoNR/GuG356kE3qfb6+6r1ADmK19wuqkH4JwtRoATC
	l8Y1JcW/RLFuKSAAMHSUgdVnhJAJ3rM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-fkE-lwEiM0yu7F82tMZu5A-1; Mon, 21 Oct 2024 06:36:50 -0400
X-MC-Unique: fkE-lwEiM0yu7F82tMZu5A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso14021455e9.0
        for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507008; x=1730111808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTSf3YKmAE+ZgWB5bS9KvyFO6sfcn+EvZQhAD8CYTeI=;
        b=bsnjq8OYZiS28+DkYBb6aO5p5U5HnbPoj0GQqSjHJOd7xQ8Ksahegop3kc/8LeZNYX
         IoQhKhUppd5v5GWFX7Vf1++7cifZwlRIxcINaynvRh+d9RWOHOaWCFm6j+Y5Ue+t361Q
         Yf1+ezyAJmZWwfuZpuvdn+ekIS3PyqE1nV41HMN+xJcV5Xao9OY6IaPEvL/x2XlnujIf
         wCpCJsUCSOIkXSmFDqYRbrs2SB5SezYYwNvcwz8mLOOxqSrpuCMRX/vGN8Orxd3lYHs2
         gSk6pfRL2DTYgHw3zqyZDk9773quwSALIWRuz11U3DDE7JukDfo4vYHdaLEf6nPlrW8U
         zJCw==
X-Forwarded-Encrypted: i=1; AJvYcCXRESV/kyYMiaklPa2hti9TJxBhwSvqUxd3OBRBEtZNPam/iQqZVmh8JKrak8vSPKR1s9bJWqg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc/l7TkkUWuvtxxdaNVy9BolyGgsDDWCml8ndyc2SJ/FXSN/3Y
	Eb4+wwdgNo4j1Z+XNTqrLL7+lfeZP+iy8katxfm/1FIC6Mbu1X1QwMI8Zr+5rOqvFxDgvACFNLt
	SUd+oCjbI3yE09taLX6CcPfBNMeCuUQ10C94JRYY0Vb9yqtG/rrHbmQ==
X-Received: by 2002:adf:f141:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37eb488c4d7mr6627875f8f.49.1729507008005;
        Mon, 21 Oct 2024 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3vKPJxaebwFcXlOBxK2rvLgodp7PKXmmX7JS5OeC9VpYp3nL6jzYBBr/CEoA24nLd9cOZw==
X-Received: by 2002:adf:f141:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37eb488c4d7mr6627868f8f.49.1729507007676;
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94356sm3975738f8f.67.2024.10.21.03.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Message-ID: <c83c58ed-32c4-4d6b-8877-2b6392fcec8f@redhat.com>
Date: Mon, 21 Oct 2024 12:36:45 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/10] net: ip: make fib_validate_source()
 return drop reason
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-3-dongml2@chinatelecom.cn>
 <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
In-Reply-To: <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 12:20, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> @@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>>  		return -EINVAL;
>>  	}
>>  
>> -	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
>> -				  in_dev->dev, in_dev, &itag);
>> +	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
>> +				    in_dev->dev, in_dev, &itag);
>>  	if (err < 0) {
>> +		err = -EINVAL;
>>  		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
>>  					 saddr);
> 
> I'm sorry for not noticing this issue before, but must preserve (at
> least) the -EXDEV error code from the unpatched version or RP Filter MIB
> accounting in ip_rcv_finish_core() will be fooled.

Please, ignore this comment. ENOCOFFEE here, sorry.

/P

