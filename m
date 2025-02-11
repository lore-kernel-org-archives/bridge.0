Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3186FB9
	for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 14:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285174; cv=none; b=HTg+8zjITHuq3aK2Q2IiyCAuU5bu0YG31wObW3aQhzP9BPDj4Q6fyCAwvyIYPM5TEFr5aymd5SZQuG1aIoZZO2n38nMGijvSY49V6X/fterVL+Eb1Dni+X1RZzASREaO+ngQ7sM9eo2wJz237v0U3/0Re8ukATO4tR7hrjIE2eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285174; c=relaxed/simple;
	bh=6uWVDSjgS6JIISR3Ig9ZHEbq8J0PF0Iw5i8ZVq3tF3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX8e8EUhy6h0nuIFIk2gjwKqcSVkGlRoi1wmd/t2yy1wVYmAifhRMajePotj7sSIxuSWTOI0fuQLN38PMXW9diNDdDE4vZc+7EeJgzNDaH3TjslqKy5+0zXm2Hqk6OLwrZjxGcOZ6G1eUsXUqRQp1KHfhgIBDOVnqiOl/KtoBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0b3NEjb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0b3NEjb"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7ee6f5535so3202266b.1
        for <bridge@lists.linux.dev>; Tue, 11 Feb 2025 06:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739285171; x=1739889971; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uWVDSjgS6JIISR3Ig9ZHEbq8J0PF0Iw5i8ZVq3tF3Q=;
        b=E0b3NEjbSnglYsUWLNHJfzWOy5/1OBLZU46KzkvM1SJX9jNs0B4CwN82W8LvN9rhcL
         cSy+A5iTjsYUc5wab+UvK6J3boDXJv+DyzK80X+iTy8iXlp779dXdQvQuc6K8NwRc5Ly
         D/5DRLKFK12+6tQ3XxY9AS4tvfqq5vv8U8R5eTdLvxvcJTow44G6pKGFLy4jZmgOUUgm
         3XBaxKFI/cfR3v4wMYu7TDaNoxqHiY3zcNbFb5NynYtTLCTDMGerPfKpEcBB2uQhpCh8
         hdbhVTcJGQXNOZgal9SGd7ette+Mw0TaXK/5mBeCG53v4uvEm86aTNtaLU6VpsW/ddNg
         v1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739285171; x=1739889971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uWVDSjgS6JIISR3Ig9ZHEbq8J0PF0Iw5i8ZVq3tF3Q=;
        b=d838WOfMXQF7+6dgMNr1QjTkxHys7QAnaaQkbaOMidhrqBoJt1eLh3Q3ezYtrqQgAa
         dV1oXnWW7dUicDNKnaxPHtoKxXGg1nOZtfgwowgaKCKYd03t63/4jeGhgZDeMl0Tcto2
         DUcqgWi6iJRRJSQ+r01c7ZT/rQwk2W5mZo+xkf7pqsuIGHWM+epMntJqXgTJ5c4G8Wzm
         ufDKQwBhHAqeCzGIsuOaxEwn17BlDiHQto7ZLXMdELRzsd51EWOAzFhKz5z85UmX/lw4
         hQIFDINwk1e3unjOAzwf7GY2Wg0zSv14irHfyyyXbKjtmxaGH+eDlJDyGnawSvJdztq0
         1Gjg==
X-Forwarded-Encrypted: i=1; AJvYcCVB4O+7mn4m1qOOmNmohuGcuXF1Fm21v1zpn+1MfRt26kW2g2axTGTUSDNuJkU5T3vmmxyDGB0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxR/IJ3PbH02aMIQIbVc3AWKaLNlWbL9RxFrApG3b1kb9Y+Ymbr
	/x8r8P3MMB8MqBW2w1LmHUq39WepQrSehnfE5i/j+tRbQASz8w/u
X-Gm-Gg: ASbGncteev0/TYEzve0DeEzvnlb/OsZOrmKE1kkTyB3m0qNQ0nLsZd6VvYkXBiEk7V0
	9urUG9Z9WW2220Cv1Q9nxvStdxVW9IMX3I4NeoIHKoeZOBbtGFuGj/PwUlsTc3EzZL2EJa9XHT8
	Vn2DPzlPeG9PU0uD+eTJbUEjIBq3+bM7mTzE6BFcR1GFMlAK4qh0QE5wtmNqSg+OVBDoy+jw43s
	aVgMBSYd5PVyCse9Noa7x2nt+OpRJRLCpYBZaBqlF8Dg0yGiikZQ+ULpuxw0CuF/SxUXOHWYi2m
	TKY=
X-Google-Smtp-Source: AGHT+IERuaTSU0FjfFqdLB/FrYmkIXox+hXTzqKNJOTUEB7oHG1m+Cn9NfYp8r8pLkOryAH3/WRqyQ==
X-Received: by 2002:a17:907:96aa:b0:ab6:eec4:c9c2 with SMTP id a640c23a62f3a-ab7e0eeb604mr95768366b.7.1739285170925;
        Tue, 11 Feb 2025 06:46:10 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78e561ba0sm898239966b.137.2025.02.11.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:46:10 -0800 (PST)
Date: Tue, 11 Feb 2025 16:46:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v6 net-next 05/14] bridge: Add filling forward path from
 port to port
Message-ID: <20250211144606.ljj2rddz32p6gooe@skbuf>
References: <20250209111034.241571-1-ericwouds@gmail.com>
 <20250209111034.241571-6-ericwouds@gmail.com>
 <20250211132832.aiy6ocvqppoqkd65@skbuf>
 <9ae3548a-844e-4449-9c00-5dd79e804922@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae3548a-844e-4449-9c00-5dd79e804922@gmail.com>

On Tue, Feb 11, 2025 at 03:43:22PM +0100, Eric Woudstra wrote:
> Thanks. I will correct both in v7.

Please wait a bit more for v7. I'm trying really hard to ask a pertinent
question on patch 11/14, which currently I don't understand very well
what it does and why it is needed.
