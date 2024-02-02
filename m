Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614417BA0
	for <bridge@lists.linux.dev>; Fri,  2 Feb 2024 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860125; cv=none; b=sFHr5xgJxoeWgw/CH/mzuJ5r64Ws15OOgBXkI/Y4BlqLTjqWkDFCx5mg0uVkjLrLJuxKcOf499VN3YsYOUixp6sExSgx1VyLEzqBEcqfz6Iqi30PFXSxasQyTC6VJdXgDCh6OzG4Wx0tZEKlqq7JXpV6wHeIhSA58OhYcG6saew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860125; c=relaxed/simple;
	bh=eFT1zUDw67JWpIMb7FiNPNcAM/St0pHP0tiU32kqv2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfPMRWKK46lS1YBFqJzpnXW6L++2qzs79lgYxKVWMP2IFfuxGy9NvAMeF1oBfSYJEywTpNHpBzgYRRkzic71S6yKuo3396F9r5VuR6l9ss8nfyBdBjnOSFgtAlGR/j5ODt5xCUZpMKD7rW5v5LOl7fr8i6TwOLT0uFt04duy5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=gZh73GUS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="gZh73GUS"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d070e2ba0bso19216391fa.1
        for <bridge@lists.linux.dev>; Thu, 01 Feb 2024 23:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706860121; x=1707464921; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+ZMZimisSUD3N7mtlaWa4tyD43J66plXyQoCYj5ZAk=;
        b=gZh73GUScWEOqCAen8lwdIG+lHkEz7Mzs5JG0bUvefJuTDa2cbzLMjMi8njCeJmwDJ
         hG0CD7vnk+ePuNyI85V+R1Ckpx8VTTT7bwB3hx9mSi0T7mJBhF/vSVutcLwArGOQmTA1
         Ln3D+Ud0x4yj/v9lsgHpml7++8kyAevMf85VnWHR4rdx8qqeJsnHzsnAaaZvFed8p4Ne
         3vBrF7X5R2wasIffbmsLYsTRImeOAPkFU6Ojn76oewTJFF/pDuo4xJ4zsUbC8wWE5JKK
         vfwgGQGHLixmgy2r04aNeUJhKZ7+YlT317+KtfQb9iyvi11+XZuJDoj6GClKwC6RDcuH
         IDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860121; x=1707464921;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+ZMZimisSUD3N7mtlaWa4tyD43J66plXyQoCYj5ZAk=;
        b=iIgm3Jo5yZwMRR6PY8NNzbTKLgB8sxHnNU52PZMrg8v49TagHkNMxemzgtq0eitqwn
         xt0+cMjuj59qZTbLOOtFRoOIaOBp4J6Edlj/AWTKi/Jbatd7F3ivyp0/mEDKBw814jdU
         gAwx4HHhXjX6p77vzOyEjcj3hM/0Rq8A9CfyO0RtNnZlKkHfcF2n1LWYKryMfC3QPWxo
         7kOxSrds0OUaZixqdPHJYTzhgw6AgdqC0ovhIo4wytiVl6IQ8/M+bfSwvCO6Es5ABDAH
         wclbfjgwE7cOs/mqf4yr9BIjd3jnpd2c3vg/E4TEnJL9+WKZ37lceJdzSu0xxOzyMem+
         X3lQ==
X-Gm-Message-State: AOJu0YxVJzCqpK42wxu8XECFEXDkJ7ua/ftmFE4l/VIn/+WhGQoKJb5T
	NoJPrkj+YLzT0/xfqMZbwLA9qg1wu1eQwwm5QVSJTXkj1KDsnEWmgZoY0S7tObA=
X-Google-Smtp-Source: AGHT+IGQ1GTduXGV5Oo+7zCX7Gh5dZmxD8UuiZGQdu9rzzTHI5ylCpfw/sa7DkZs8X3MfKduqO+gAw==
X-Received: by 2002:a19:e052:0:b0:50e:bf53:ee77 with SMTP id g18-20020a19e052000000b0050ebf53ee77mr425427lfj.24.1706860121247;
        Thu, 01 Feb 2024 23:48:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXjyqVd8bP6m8aqk9AjU2Kj9FVvNRZ1y9ogfwJ1s8dJk6G/OUDR0O5tblOCJWTgXb6sZYF8LWY0UGiPp5SZGuTJ29ndR/WYF0DuImEoUj1h+947o2MotFa6G+wMnRs89PJ8dLZo8TzIDsba2xqL3PGauo0TN2KH2kC6BaSR9KPFICjQXxxA7Mst10iUfiW3vR2kXMSVoyhiZ9hlj+9WY1/t4hjRD0044nwlmjFGmRlm+zm2QtmJ2e6PzBKsIjQKiBpxs36V+M+4OVK9uclnvFA9uMNaAfG22W1NaadOxrEJLM6Y3I1tcJLoTHwxLELg5+JnUOR8Je58Sr4=
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id a29-20020a056512021d00b005100ec1e3d2sm222303lfo.215.2024.02.01.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:48:40 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/5] net: switchdev: Add helpers to display
 switchdev objects as strings
In-Reply-To: <20240201204940.5f5b6e85@kernel.org>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
 <20240130201937.1897766-3-tobias@waldekranz.com>
 <20240201204940.5f5b6e85@kernel.org>
Date: Fri, 02 Feb 2024 08:48:39 +0100
Message-ID: <87zfwjs3vs.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On tor, feb 01, 2024 at 20:49, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 30 Jan 2024 21:19:34 +0100 Tobias Waldekranz wrote:
>> Useful both in error messages and in tracepoints.
>
> Are you printing things together into one big string?
> Seems like leaving a lot of features on the table.
> trace point events can be filtered, not to mention attaching
> to them with bpftrace. 

My thinking was that __entry->msg was mostly for use by the tracepoint's
printf, and that if you are using some dynamic tracer, __entry->info
points to the verbatim notification which you can use to apply arbitrary
filtering.

> There's also a built-in way to show traces how to convert numerical ids
> to strings for the basic output - __print_symbolic().
> None of that can help here?

Originally, I did use it to display the `val` argument to the
tracepoint, but the problem with that macro is that it wants the mapping
table as an inline list of tuples, and the list must _not_ include a
trailing comma. This means that SWITCHDEV_TYPE_MAPPER can't use the
trailing-comment-after-the-last-item trick, which introduced an
asymmetry with the other mappers that I did not like.

At first, I thought about adding some variant of __print_symbolic that
would take a pointer to an existing table instead. Then I realized that
I would still need some separate stringer helper to put together the
rest of the printed message from the TLV-ish layout of
switchdev_notifier_info.

At that point, it seems more reasonable to just collect all logic of
turning switchdev related structs into strings in one place - with the
added benefit that drivers could use them to log richer error messages.
