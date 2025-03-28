Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C9B8C07
	for <bridge@lists.linux.dev>; Fri, 28 Mar 2025 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177205; cv=none; b=Q862jkrk337QAcspVmsuAYCsXPNY5ShjjBzoGza7vvs4BF7e+xfMt014bTJ2I2/JdgxqbyWOt/YJb44AuQzCa8sqiAR+xCStpB9DlNtAr+Oh1E38qwmq2tcnXeChnQqZ70saYCtbIzQ/quBwrY3Sw4LsUrYBlf5lGvexj4A5oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177205; c=relaxed/simple;
	bh=sT9l1soy8g6kWWMfr03ZflF0iPIE60RutKuPCUgizfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ9m84gSdl8gY1Acom3XctYxUfMqc1QfkC8Gx8gqO8L9ofZW73nwP3A7CV3Xo+1gj/cnyowMIl13avtG7S1r+vACHiNOukw2CkyyG9w9Gpuph6zERzibIH59CFBtfF+Rnd9XeunbTDVO5GGnY7oXVPZvkyTI11nQ1wC0hD9Zrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0YaQGDy; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0YaQGDy"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6ff37565154so21551677b3.3
        for <bridge@lists.linux.dev>; Fri, 28 Mar 2025 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743177203; x=1743782003; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7ArQSvGzCkLOtTBEXoN03yuh87JN3AovyX63+l1thA=;
        b=R0YaQGDylI0Y38NEXS209RrgQYlWLTWfFTCFyAgfKGyr38G2RgsgdMB+/7r9uAO7A2
         shb/g9vTid/qQzmUUsK1giz25fMmsvSVPxUh14tMqSK85cl4sGGV5fl/e25bll/RSUOT
         4SDTiQO4cMpR3tROfcmAiEhoGSV6iRP41ZyFp9eC3Kxtqtcy0PW8DNrP1t4cUJqWQ/hX
         BUDCbFWKdEB3wkmTDGbEUg4eUNGyCZpnlQ6YN/ALuqq3seJiVkl+MK5VaVr86khvQWCW
         s54N66kJOjpsCbMakZhfQZ71sl+gMrlPETmTKhV+SgZ01p/22B1zFTj85ZdmFscJWx8Y
         qS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743177203; x=1743782003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ArQSvGzCkLOtTBEXoN03yuh87JN3AovyX63+l1thA=;
        b=vsDOrDdHaw7wJYhmrlJvD1k/PqEa+E5w4i0C1jQ/YU8tsrRdfb55d0FhbOV4ogdYHQ
         /i1RE6tOFOh9o2aSX9xiwV0qxYJya0d2OVwGRreA0ny6nB9A5qHU9GpLYrVWXFti5XWL
         2uozke+iBwh/g0b2ODymR0NWzShtjut1AiTZ7mlTLuLSUTnq5B9zc6Ysa5LTCY0n35IA
         e0fzDvklNfZkFQ5mDLYKNz0DfMQz8kxpGqkL9WRQ40rSx+4oIdZXPidgzpK2Y7LT2gQX
         A1Qoa8ozuGLytcshz3Lef7bOaKj79rgvYJcfMDvCBtc/z0is+cC/vlXFHcpgGOBd8VjH
         Xz7A==
X-Forwarded-Encrypted: i=1; AJvYcCV+4cAam3jkhmNRSFE9Vgzem55rHVOZzVwAVTqA/rsGdyHwJKAKSQVeOwLRR73p6mJCsshvdiU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCRbnAXzN/0cgRIrNyiP4hMDevM29PcOMvkJ+EKlm2Jt/1QrzO
	xrga7mx0etzVMbkFMBSKe9sa0rX1cUUeN6O2mAq+RyjK9ANtMoMl
X-Gm-Gg: ASbGncvPgIekLiSLS1BmOvjG3BMfjUla4XirhmiOfoah/1+jMXktTa+0yaHrvxv3LEO
	H2wPb7NU5Qk2v0hJAtEY5oZHpR2swXA9ZQVD1ApQMkyl4irWvFSHQVgWobLl3jUmMJyvqRqRwN7
	9Jwex3iJRxFUeIvRNQjNWhT47qj/KKN63dQDuBArrnVQ71tGf/wBi/NCtOtco/yFR6xzDCpJmys
	S6KaUNZZHuXB6h7NCl9oQcPHsSBiN6pR0FV62JvY4LJQccLiGCp+aovAhvIdtfCC8ccTVnybNgn
	5J4fyleVD5LLm1jj4LtqgqChEDO8xqoVWEYubZXBQcEe1S4rCRyZTFnIjuz8E9VVySc=
X-Google-Smtp-Source: AGHT+IGvERJjffAn9lGWtupVs38GAUyAPk1DPO/OGaC8Od9Qndrrp1k1J3/OD/IDOZXkvQIKjJKqRg==
X-Received: by 2002:a05:690c:640d:b0:6fb:9b19:ab49 with SMTP id 00721157ae682-70224f2208cmr121748237b3.6.1743177202740;
        Fri, 28 Mar 2025 08:53:22 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7023aa2ab05sm7519417b3.118.2025.03.28.08.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 08:53:22 -0700 (PDT)
Message-ID: <8f51bb33-c5a5-4046-93d6-f58e841256e5@gmail.com>
Date: Fri, 28 Mar 2025 11:53:21 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
 <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
 <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/2025 6:52 PM, Nikolay Aleksandrov wrote:
> On 3/27/25 00:38, Joseph Huang wrote:
>> On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>>>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct 
>>>> net_device *dev, int err, void *pri
>>>>            pp = &p->next) {
>>>>           if (p->key.port != port)
>>>>               continue;
>>>> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>> +
>>>> +        if (err)
>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>>>> +        else
>>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>>
>>> These two should be mutually exclusive, either it's offloaded or it 
>>> failed an offload,
>>> shouldn't be possible to have both set. I'd recommend adding some 
>>> helper that takes
>>> care of that.
>>
>> It is true that these two are mutually exclusive, but strictly 
>> speaking there are four types of entries:
>>
>> 1. Entries which are not offload-able (i.e., the ports are not backed 
>> by switchdev)
>> 2. Entries which are being offloaded, but results yet unknown
>> 3. Entries which are successfully offloaded, and
>> 4. Entries which failed to be offloaded
>>
>> Even if we ignore the ones which are being offloaded (type 2 is 
>> transient), we still need two flags, otherwise we won't be able to 
>> tell type 1 from type 4 entries.
>>
>> If we need two flags anyway, having separate flags for type 3 and type 
>> 4 simplifies the logic.
>>
>> Or did I misunderstood your comments?
>>
>> Thanks,
>> Joseph
> 
> I think you misunderstood me, I don't mind having the two flags. :)

Got it. Thanks.

> My point is that they must be managed correctly and shouldn't be allowed
> to be set simultaneously.
> 
> Cheers,
>   Nik
> 

Helper function like this?

+static void set_mdb_pg_offload_flags(bool err, u8 *flags)
+{
+	*flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+	*flags |= (err ? MDB_PG_FLAGS_OFFLOAD_FAILED : MDB_PG_FLAGS_OFFLOAD);
+}

and then from the call site

-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+		set_mdb_pg_offload_flags(err, &p->flags);

?

Or simply clearing the flags in-line:

-		p->flags |= MDB_PG_FLAGS_OFFLOAD;
+		p->flags &= ~(MDB_PG_FLAGS_OFFLOAD | MDB_PG_FLAGS_OFFLOAD_FAILED);
+
+		if (err)
+			p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
+		else
+			p->flags |= MDB_PG_FLAGS_OFFLOAD;

?

Thanks,
Joseph
