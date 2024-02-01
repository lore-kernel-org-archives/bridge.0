Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019431846
	for <bridge@lists.linux.dev>; Thu,  1 Feb 2024 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747591; cv=none; b=otbFpLEZfaEt+9nLqahF43XxKHgXe1QQSjgX05XMLFw3LzJCcQ516dszpEE04MfnAvTJw4Lqj1FEPvpFr7Oqw3oBlPN2PQk0+Ly3VDD+7CNl9kFjm/vUjpQWEtevF8ytohCm6AQaENmt1KOdxhw/CN0DyBrFV3PpRri4lwXSXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747591; c=relaxed/simple;
	bh=DfK90FjFExrJjPMMCY/tsvVrtnVfs8jikyEr8u82fcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUatnYaBFX9w/tliO+XuRzRnUI27Fndswa5F334NReXZmMIuBbI8LAzeau6hyfX6yx52cCVWQUw2cul/phmNuPPDj5wrvs6xxcMQRMKq6zzza/9AAjrLGoWVx/xHlbHjAdVh8NCGfG6RnSW2STfNjzSe3Pi+bctRo0S1p8yVM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARc8AQJi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARc8AQJi"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a30e445602cso332121966b.0
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 16:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706747588; x=1707352388; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYc3IxBIqD76M0X/oe6yDzIKEZbPMAmuRtmpKU/+RyE=;
        b=ARc8AQJiQk4lPWw2fDpJg4V0+NgpLDpQGyxIzBbUjFKRKZ4NQcZYKMrcSxFGqoKSjN
         tQExdyl8R1tquDmTaRn5NLWCH4OLIUtSGqJYLlVQkEszOpxlGxm04PVOO0CCw+7y5ijv
         y3qgYEGUvXTHaa4K+WUctD685iWN6CDccoHUqfn0hVJOFNkl19tPV2Nare0yNVv6qKPy
         ZSNbBE8QrW0pSvQi/WQqESZSjCFsQgJME/voY3omptrh/mnBjcZ8PGAPDbkzRfyPotU4
         cyS74Y5A+wPoRsNYMrPxDQemOkPlcuA6b2vomfQZxNMb0L04xLTOCa5j/yeIxoI3Xlnf
         yxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706747588; x=1707352388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYc3IxBIqD76M0X/oe6yDzIKEZbPMAmuRtmpKU/+RyE=;
        b=TCG/aRxUbM7cB03MTCmQNy8XoEOoR3rZ2KYgG3bLrEM7UR+uMwpkCZUhtZrWGdj2N2
         oqqy3JoicoS051TIiR0EyEQeSRV9B/gH0XZvWqRQvwTQr72+LBbTNVg/VBRAn/dXEqlD
         NqHORCTnZfiNjh3QV6kZ1R0ywzOY29qzRCMsNEEpjvs70/YddUcgg2nf26Urc34E6uOv
         OQ/h1VC3WWI5VCL9n/EofrSyA1LevCTVP1jB6yWDEzbi6VHOaHLCL/FuJFyXCKS6CDpR
         relZNbJ0Wa2kXLpy53UUEr/rYkbkmFeRFkxGlBYv7YkcVqmEpa5qS+T/hflS//PBwHUb
         62HA==
X-Gm-Message-State: AOJu0YwXJ3OYocCh2ytb6e9EBSqlxviXzJ5xeJCVbJVsjuYaF8EFxtwq
	cr5JtJEGRoksZqN5SDd7sr+nNEdl8OmvsqokQqelHZO4hdevjMNx
X-Google-Smtp-Source: AGHT+IEv8ssH6QhCRod9XfGdUzEQZLHdO4Wt8EUNG5erRbBggiHIBdojxLF61LuKsWFNv2B3fcdZ2Q==
X-Received: by 2002:a17:906:c795:b0:a36:39dd:3f93 with SMTP id cw21-20020a170906c79500b00a3639dd3f93mr3199570ejb.4.1706747587975;
        Wed, 31 Jan 2024 16:33:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCXJrEtYNLYN0unC1ZswqY7VqW+7k40kVV2s0UBLdDcDgo4+eyUZyPDEgG3YTl3bJs9jV703oGkBxfo1HudUBaqDc/vQeKTIOM6uU5mkuh2SWhKOIelql8CZRlfJmifcdB2Dixrlqu2C5QwL3h7JnyN8KNjewZ+188RHFcD7fACU8OEu7ENxMkqhO95dIZK2BD4NcmoJ8UBE0DGYJoatdCClPT95QonxF0WcVxcTEf9h7hAEigdzErYdKFejSkJQ==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id qh20-20020a170906ecb400b00a28f6294233sm6630925ejb.76.2024.01.31.16.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:33:07 -0800 (PST)
Date: Thu, 1 Feb 2024 02:33:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, roopa@nvidia.com, razor@blackwall.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <20240201003305.thoj2y3bjyxq2hlj@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <ZbpCA3kgoCKsdQ4J@nanopsycho>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbpCA3kgoCKsdQ4J@nanopsycho>

On Wed, Jan 31, 2024 at 01:50:11PM +0100, Jiri Pirko wrote:
> Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
> >When adding/removing a port to/from a bridge, the port must be brought
> >up to speed with the current state of the bridge. This is done by
> >replaying all relevant events, directly to the port in question.
> 
> Could you please use the imperative mood in your patch descriptions?
> That way, it is much easier to understand what is the current state of
> things and what you are actually changing.

FWIW, the paragraph you've concentrated upon does describe the current
state of things, not what the patch does; thus it does not need to be in
the imperative mood.
