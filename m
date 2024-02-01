Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14932664BE
	for <bridge@lists.linux.dev>; Thu,  1 Feb 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773527; cv=none; b=lAMku9usDWMxKeiupp7wvgJOXUPVE/QXQKhLMYerqt+X+LvqHG7uP+PBLDyKJF1rH0Q8gDxe5tWorpBW7DFiA7gW4FhgyQQtTJlIiU/sfkjWgJCjQfMcZj/3P9wnbNXLDSb/H+f2wiWn9obRkLc4hif4nfGJcuvxUX39yp/WbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773527; c=relaxed/simple;
	bh=3doOOfTwch96we44aEoN/N+kUin3abrCSam0C+Uo5og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeCbjRNMkAZGVb6SrtamFcEmQ6Kvf3TiGnZqwXFG7aNKUcREeEIQwBdRguP02U/dalGFiBpE4fuBG/Gzd6+tIByCdE40XFEKhwdpJXmTxqtOg1g+Z4lrp9AwFUv+HDI1OLLpQa8HsJPcn+Ayybl1Ad/8Xw+xfjMqWH8+1rplveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QIL2JT+D; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QIL2JT+D"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b13332ca7so288356f8f.2
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 23:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706773524; x=1707378324; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEB1jKMD6m3vF3/N1fu5eKuMmW/5Mh94YFllnsy6bK8=;
        b=QIL2JT+DWgM2CzSiMZ7iQXQL8NDmkDwWyTZ4djObj2ZhKm7/q5xQMgzdmVFfo/tF/r
         hjzC9Ncu+rddfmLw0RajC8cgoo+40BlKE30PPq7s3QSUroZ8ZMeybYiLE+cpqrudUYWq
         Pt9cGVQpRLuNOX4zKBHa3QhT1bKqjaXKBAge0VuSJlkmA1anoKlVasMkaKjwGCrzLoF+
         +hcCREjZGR/oCQoHo137rFqrAP40Sv8yenjINUr0tse7ph57GQf6i43z30WiY26HxDFH
         +I54rzHWJ25lOw/8T4OdWAmMOGi9Vu0fehE/jEgTmVjoKbZUWStRU2eGRs/7iqVTjSy1
         gTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706773524; x=1707378324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEB1jKMD6m3vF3/N1fu5eKuMmW/5Mh94YFllnsy6bK8=;
        b=TWiM7PZ8BXQFslmOgZnBnj74T4VFXpTYXep06fDw8naTyo6jpXBrQirwUzYVLHiEQa
         bS8ZsMrBxxVZQIRFJl8+u7JRdk5SHhpEEsnf802f2y1vp2BK9TVuJZi9k/EZfundf8pS
         6dIc4pXxmmvNMeaN/5mWG4LPDuHUEcmAYiLi47dvYVipa61A9Q6nxO6SwNndLdzSI/7C
         5S32LnyHPZDLJzh4DvNo7Qenmt7pf7euF+waU2l+NRX1CpTLWVRf1hYm5nNkKOwmsCip
         aH355MLJ9SBPuG8bRqMD2eUkVNFauj95LMVqOCAn0frrXoRw4XHZCJybQLBB3JapfTDb
         XDGg==
X-Gm-Message-State: AOJu0YyQ55hn2d90zFk38HQd9FpGBGtl2age5qmUqu90M1OBPdymDEOb
	HHUJwYwwVJYT9EPgsdmFx3UOEtPMU/HVIPP+5RGgMcGr8cXxy3JkNFSY4f+Iguo=
X-Google-Smtp-Source: AGHT+IEzXnY5g65s5rzpDxqKCORq4oPArdoL9BA0PmQpvUy42l2ZaFRV3D+lBBfzvNNAIB6uL0eSHQ==
X-Received: by 2002:a5d:4809:0:b0:33b:1131:ebfd with SMTP id l9-20020a5d4809000000b0033b1131ebfdmr951503wrq.49.1706773524311;
        Wed, 31 Jan 2024 23:45:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/NS4sV9Pkx7LYKa6plBta44EGH7iuV15vC3shcj20wTgNgQFW4+vq0Ga5NuTOuhLoxWf5htnOXGQErwCWP7RKlNZnZ26TzBnLTpyvnchwPPyIMjlC/u2EzVdjHzeBsOFJhVsOZzlQcL4J2WSo+9A0/R8RB3cTnVFRrWvflWyld5SmQ350D+GGQRNmeE4C7TXerowGoWnIDei6nufn6wkuqTe/PZ5O+KkSezx2frLGdenNXe1qH04hEOBBKcTTpK06eJHZ37Z6/5bZoafBd85hYg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe112000000b0033ade19da41sm14625593wrz.76.2024.01.31.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:45:23 -0800 (PST)
Date: Thu, 1 Feb 2024 08:45:20 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, roopa@nvidia.com, razor@blackwall.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <ZbtMEOIDA_6CgRVp@nanopsycho>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <ZbpCA3kgoCKsdQ4J@nanopsycho>
 <20240201003305.thoj2y3bjyxq2hlj@skbuf>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201003305.thoj2y3bjyxq2hlj@skbuf>

Thu, Feb 01, 2024 at 01:33:05AM CET, olteanv@gmail.com wrote:
>On Wed, Jan 31, 2024 at 01:50:11PM +0100, Jiri Pirko wrote:
>> Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
>> >When adding/removing a port to/from a bridge, the port must be brought
>> >up to speed with the current state of the bridge. This is done by
>> >replaying all relevant events, directly to the port in question.
>> 
>> Could you please use the imperative mood in your patch descriptions?
>> That way, it is much easier to understand what is the current state of
>> things and what you are actually changing.
>
>FWIW, the paragraph you've concentrated upon does describe the current
>state of things, not what the patch does; thus it does not need to be in
>the imperative mood.

Well, there is no imperative mood in the next paragraph either :)
Therefore from the patch desctiption pow now clue what the patch is doing.
