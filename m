Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5717996
	for <bridge@lists.linux.dev>; Fri,  2 Feb 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858468; cv=none; b=QVMzgAVIn7bnL+clsiUlW0F64EjBDMUFBNEVlt6LVoZ/mJANyhr8VBjxZv132bP5jnpJidC44h06eyLnl5Z4U1NQIU3y+9Ytb9bxVlAv4VkCnohONISfBdLiOQyfAT08XvJdpzD5sn80M23BOrzAIPSeM+Io/NDwof/3W2RPuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858468; c=relaxed/simple;
	bh=pk77FvIoJFqOe3hjIxvi07qZKYT8KOekiGIY+FDjot4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFDQTiFuJmCQfS2bqkAKpw9MnX4ghNKxIgeCodI2HwWB/7G/KGbZ6ltWZsRzTvdmOwqAfByAqVrO5PqE1Iv81R/2KXudGtsNMpEE4SFG6wNd9B/LYYRG7sBy4PK0929gKQpIntUc0/hzmWRaZ2r/zQeoECBoCewP3WgvCqE+Y60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=VJPY+azb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="VJPY+azb"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51117bfd452so2998721e87.3
        for <bridge@lists.linux.dev>; Thu, 01 Feb 2024 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706858464; x=1707463264; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwbUUQIVXVTz0VccesbEfswR5fbWTE4n9Q0ACHmmb3o=;
        b=VJPY+azbwrfy9W4OsTam0xMCepnPMn4gto6xL9qUpM2DSn/WByD1VJvCuqXYKA0vZm
         Hcg76GEbmkxFc6q7MRomv6/VMswtwwrSZ5zt/yY6poGyTtTsMsG2X7ln/VVfV6egeNcc
         LafF096NQAhFcfLulBB4ZJGMCKWW9e2HBmq+ViRYdzrfZt9jeONVLuxIcJsM4HPJNJPn
         pCkgXQDFgudjX4yfWZVu5Znkx2MdSGOVSEsmd7qA58lAE4pMuqT0dra5p/MK18CKh7AG
         pqskmYNBWYBT7+go8meEep+PnrYPWjOCisyLy7F0EK2bXNkqPQ4PbWrSTz73k+e7+Uyo
         KFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858464; x=1707463264;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwbUUQIVXVTz0VccesbEfswR5fbWTE4n9Q0ACHmmb3o=;
        b=VaTAfZLhCEKFepuUIr0BH6Zz1Z9QD33a4Bugr63hV9mrNS379THVibP1aA1h3nPDkU
         NPZ37DXkm9X7qq8nDwfT8n2m7jYlEUuKRjKS22KzuaSDIjP/FC1ZX1+IGS17iOxFU43+
         fHSqWevRWSTGZixsY6J45U1PjeNy2WS0yIte3GptjUpxDd6U6xzAoL4bLgew8sqJO6eu
         huTYZVYQO4HkNXNyBkin/D+0h6JHNjJh3N51J/XpUW0ZqD4Yi/yOdOOnvUM3baD/Cajl
         0v+Aai1VA0jqk4JNN8YewGmWuase9Wn4ixJ1bKM1GjT1jMtF1zp8Enlb7b5ViyTkTMXd
         fBcg==
X-Gm-Message-State: AOJu0YzJoxQQlttwRbSqjH4Dwek/v/AJrL2L3vHweDv1LtjGsTztxzbz
	qUQARtwy4L1zIs+Af6xxDSJSYwSMh6e+xB86XN+c/QhJCOvwlqQGHG81CAoT5IM=
X-Google-Smtp-Source: AGHT+IGZd22/TiTxCGbUUTtD8AI3EPo3xd9ZDSbi1WavZgWzxDLXkVe3FH1D+WHjWkFCgjA3uP+ipA==
X-Received: by 2002:a05:6512:374a:b0:510:c73:631b with SMTP id a10-20020a056512374a00b005100c73631bmr3133365lfs.19.1706858464152;
        Thu, 01 Feb 2024 23:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDttNK642bVGNWWIPtCuzxOk0LEdcayDqFGQzkpaO9ZT33Ak4k0SgSLF8HR5O+K2BS6CdYB8hNQiijdiS1nscvv5n9F8lV19mhhr35hhyvJ1gWyuoliZNSy/PMHjJfAbsUvIodlknGmPkoTlvI+I1QqCrMtEmGU0siBea5LHAL0vcjEYB7EP1wEvNNaobBPzf63EQDB/SHL4D6L2E7+/1qJhYhMKH/y27KBsEve2Cxcs8ODiiQEOBKPB8QmflEEnfis+immUGyFkaVXPlga5cC/CF85chOqTIBBptTJuEff5H5bYKDbEwF6eZgxZKwZWMH1gnhCHCORD4=
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id z10-20020a19650a000000b0051129fa324bsm212280lfb.296.2024.02.01.23.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:21:03 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/5] net: switchdev: Tracepoints
In-Reply-To: <20240201204459.60fea698@kernel.org>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
 <20240201204459.60fea698@kernel.org>
Date: Fri, 02 Feb 2024 08:21:01 +0100
Message-ID: <8734ubtjqa.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On tor, feb 01, 2024 at 20:44, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 30 Jan 2024 21:19:32 +0100 Tobias Waldekranz wrote:
>> This series starts off (1-2/5) by creating stringifiers for common
>> switchdev objects. This will primarily be used by the tracepoints for
>> decoding switchdev notifications, but drivers could also make use of
>> them to provide richer debug/error messages.
>> 
>> Then follows two refactoring commits (3-4/5), with no (intended)
>> functional changes:
>> 
>> - 3/5: Wrap all replay callbacks in br_switchdev.c in a switchdev
>>        function to make it easy to trace all of these.
>> 
>> - 4/5: Instead of using a different format for deferred items, reuse
>>        the existing notification structures when enqueuing. This lets
>>        us share a bit more code, and it unifies the data presented by
>>        the tracepoints.
>> 
>> Finally, add the tracepoints.
>
> Is there any risk with conflicting with the fixes which are getting
> worked on in parallel? Sorry for not investigating myself, ENOTIME.

They will unfortunately conflict with this series, yes. My journey was:

1. There's a problem with the MDB
2. I need tracepoints to figure this out
3. Having a light down here is pretty nice, I should upstream this
4. Find/understand/fix (1)
5. (4) probably should go into net

In hindsight, I should probably have anticipated this situation and done
away with (5) before proceeding with (3).

My idea now is to get the fix accepted, wait for the next merge of net
back to net-next, then fixup this series so that it does not reintroduce
the MDB sync issue. I already have a version of the fix that applies on
top of this series, so I'll just work it in to the switchdev refactor
steps in the next version.

Is there a better way to go about this?

>> v1 -> v2:
>> 
>> - Fixup kernel-doc comment for switchdev_call_replay
>> 
>> I know that there are still some warnings issued by checkpatch, but
>> I'm not sure how to work around them, given the nature of the mapper
>> macros. Please advise.
>
> It's a known problem, don't worry about those.
