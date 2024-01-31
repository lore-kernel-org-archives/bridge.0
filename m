Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981767D3E6
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707916; cv=none; b=CBoL3e17b+K9tN6CG7WRT3lFMALGIR7GENZhJ5mYGeqq64v1fL27MC/EvbjZ4G+HdB7hgc5cNTdVaTcvi+CLZtBHSeRWTtrXhJWvyQGegG7tFd1SgOtJen/GIyFTIBSUljJwuANEaRK0tPtItzMTu++ZxZzsRsYWId6VMwyaIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707916; c=relaxed/simple;
	bh=B5akkCadRMd6543+II2hS0/0ZN2LSIdXzGcCFDHKGko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+rdOXnCdrn1ujF6rCQ2SHK8DwtawcdEPp5u2648DcemtiPDcy8GomU4U4ID8SZdBy+ltrtZo6SQ0HTR2/eYQIpSoou7Qu2mnB7hCiDENjK4z17PblmEDSZJuMURwfQCeHn0VSbF80aBcX75XSZAnSnSJ3ZvzmdNY7N9RY6j1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=MLTPddFs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="MLTPddFs"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511207d62b6so2105805e87.1
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706707912; x=1707312712; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5akkCadRMd6543+II2hS0/0ZN2LSIdXzGcCFDHKGko=;
        b=MLTPddFspDXXbFeaIPMsJBL02e4iCTnoCo3YBXbTNUJoF+hhXOH8jMwqv8oHRtUuOK
         kR83iH9n+aedjXXch5vbNrLz6LBhJO7FM78jBLS6RnPk2MRPUShH0csepVvHh5jFBslw
         XoVgoX3dIc2E4IYOOG//mCTepnIoiyzovCJuOxcXKfJmtocaE1pyIAJrjTPJledaewbw
         KPHzLkf9gJvvxUdC6l2QiG0eRremBngnZVuBGeI/UVZPTblkmHnICGlJVFguzdQ1O3dK
         QRGalQYRC1s+R8cOrC86NOb5aSCy/mqvvFqOpFwo5ldpdu2PSPvOLGzvf+NBd7ArPL/B
         /K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707912; x=1707312712;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5akkCadRMd6543+II2hS0/0ZN2LSIdXzGcCFDHKGko=;
        b=GbWAhbyQX0CPvjxGNjj6BWQp9yWw5no50H9XLFuRtxDVnNczNPi9XDU2/iSYLKpjk3
         TjJGqn54U0ToKT6HtgtUESuWsEq+wcGL9TVPyaeWSaBj6pvDWjQ4sOQSGrTtkIcMZji0
         gW5EVmimxLn6MYNFw4/W+3uSr5POpcD/rzzs6KowXIIIdYQXEO/TUKgG5jr4rfPc9eYb
         Pygk+DisKDOnfbwDIi7nc83UV8ySHoxEthgkACSpCSBpm/KFOXI9riFPgaBIiQEeB9se
         kqtBot/cmdK9RVFFcplM5e1B2sbG3JYwfztMgszAzgHtij6FZMWN6ER7tgjFnoO01oEi
         ax+A==
X-Gm-Message-State: AOJu0YzYDKz0s9Mg+Md4HXJ2LevvFAmE0Xh2OMNNlB8jlzvey6CnQQcp
	8iUz21AIpyjatetxf/LHTtZ/6LoSYa7F0g/UX5ZDU7rhlRqey9xIwlpYpjP9E9g=
X-Google-Smtp-Source: AGHT+IFXNOVZCBNi80sdmZ1CnXzKfIZR8B6cTDwHE01kPBqY1xwLRfu/6QACKcnImxj8hEM6UNrpeg==
X-Received: by 2002:a19:7011:0:b0:50e:609c:ab90 with SMTP id h17-20020a197011000000b0050e609cab90mr1152146lfc.32.1706707912421;
        Wed, 31 Jan 2024 05:31:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXCQEZBdGE+kA/EBG6EagF45WN2kE99/U62sVYnOno5Q7EbJGkD++TsrrshIigXpoPecLeshYJ96xqLcqjMnd/YVKqEvUoQ+rvJ3g4WjD46Q2Uy5eUTRvygJY9SQrZtQ4IqVrxKw8LzZ9J2M19EX6fwja4Zf1Ykq346Vaz3/KRVSa2QSsNaKjvup7RkC33tbKRudJG6pcIQNqq2pc0qLILB2XS7vMbXLMOGsEUS1Ct+IE8LF+yAFz4NxhUt48w=
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w1-20020ac254a1000000b0051129fa324bsm26283lfk.296.2024.01.31.05.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:31:51 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
 roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an
 object event is pending
In-Reply-To: <ZbpCA3kgoCKsdQ4J@nanopsycho>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <ZbpCA3kgoCKsdQ4J@nanopsycho>
Date: Wed, 31 Jan 2024 14:31:50 +0100
Message-ID: <87eddxtyrd.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On ons, jan 31, 2024 at 13:50, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
>>When adding/removing a port to/from a bridge, the port must be brought
>>up to speed with the current state of the bridge. This is done by
>>replaying all relevant events, directly to the port in question.
>
> Could you please use the imperative mood in your patch descriptions?
> That way, it is much easier to understand what is the current state of
> things and what you are actually changing.
>
> https://www.kernel.org/doc/html/v6.7/process/submitting-patches.html#describe-your-changes
>
> While at it, could you also fix your cover letter so the reader can
> actually tell what's the current state and what the patchset is doing?

Sure thing. Do you feel that this is enough of an issue that it blocks
you from doing a review of v1, or can I wait for more feedback and bake
it in with other changes?
