Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18773502A3
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778177; cv=none; b=ghUIgDDnm2ykSjri/vie24/gD/ZcadAKK/AuuqRAoy35ctcq3j3Y7rt4O3uOg8jME8BMaRJGznttleBlbumOXGBHCvHQZJDb9ePn8CSoB3fWZWVrvcraSZdQxPj/r73NUrO+TbBmfL0VtUSgqPG7p8ts8keDhwxE6J+f6OGraUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778177; c=relaxed/simple;
	bh=j/hNrN8yCx2c4pErAxcUpIOPgDMVep0Bk1BF9TT9jNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsfolJ+HsiX65YUFDo1zYVvt5TnqLMio6y8wvjwk5nYKrJUxxev7Ik4LAV6J8g9js2MpUVmC4gjNDPN9wIGCbxArO9U/FvOa8sMwm1H4JxDu7blFjbW6Y49zI+JRNTlXzdS/JOJs/eOP9ZRyQRl6llNT7EJm5ke2jw1M4T+6Zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TC3uXvOc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TC3uXvOc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso30273415e9.3
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 08:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1771778174; x=1772382974; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xS9l5mc+XFl+nwoapUNzADH+s1Zoh0SwLY8LpTEI3o=;
        b=TC3uXvOcuUzJlL0iQrehBXMfjlkvZ6hcSLhXxkW1S3D1/Pgt/NdWbvYAXkgAYWr9ek
         kYdBYvVUDbjx+dYww6c9d4vRYHqzbfrOf6Vn1UAZvqH4tj5Gc1HZja6tsHiDQcTzS6Ku
         JTpRZ67ZJVRLfvI9/E+H66jAlQimLiYZfiV2hztTR7TGgB7S9UsRIscLeqved24dBaNA
         Foh3TuFuAtogqsIPhGts4VReWVSytrAV5XCR3UvsVtvlXaaUkEG19Jal7hOrEGp1j6oG
         /fImw3nVP2bcnypQYTDS12+IG68h7OBa1SNfZx5lERgDMXtQLzr+qtCeLRt63Vyc4vW1
         7+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771778174; x=1772382974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xS9l5mc+XFl+nwoapUNzADH+s1Zoh0SwLY8LpTEI3o=;
        b=iiVzWDzDNaGYyxag3iRZnmBQ60iikiBhwQPFvQzxw7DdLKL+6dBBo8x3axSq3OSd4u
         q6bvvzSjKly/jYObupQQsWmOvw+frweOkcnIsUwN931V5S0GeXNumnG+M+PDmjJyrjxU
         1wNzWTsnk+FqJel+n5T5U8GGJZqXwqgx+e6bQ4JaEvz/Csxesvm72ayoe2SPB7v19Th1
         gQD2uaCzuN6Pi+zRWmR1TFhJDNbW+PlBBIoW3zrjHmXjck0aOitz0biAAKAKsSJeROqk
         q+5ALmEojtNM6bpIXt62qs7x/gMIqNK+s1l31AkKZyWvFHFEIY5CdqFGiiMd2QDTzsTQ
         alpw==
X-Forwarded-Encrypted: i=1; AJvYcCVIbEiqdj2L7qINiiOqm9m66jWWETD3VyLs6gUDzDeKV+LMOXBPh9FzxrOspYI/Ds6AUTqpJdU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWk4wx4V5qSugkGXJmbhRH7rMaaqKtJ8Oc67YdX6SxDaffy9TI
	CLjVQwOXv9pwDUH2KAmsYvHmSozN8viONVDZ1IjhECMSRXJ+l/J0nHqWitdsa1q+NA4=
X-Gm-Gg: AZuq6aLZ39BA3ptaanLd4XzMIOIDFnBT5ysYyfgu26Abv1RI1HPbAwIjgpppxgJHD6X
	GERSb0QHzYXDjv8HRmFL7ouSmwnjxYfHGVg6XDmV90T8NMYYIRIFFPl46fvOWgp4Vjb/eMIt1/Y
	vnozxwX+Og1sbjJijIuRsoMfjwQgw2kbIHkdVBIOx0nW94HIP2yl4P1Op3xmC8nRJyzrMKjluHT
	1T+LX6LLcsGicclVcCct+B26VwNhWEPwFLpaYU0Oqms0fipXEtkbE5z5mjAtr6I0ZrL/jRwjwzV
	K1RlWfZG24Rfd+9OMcm8gf98U6VWOjkDu7hw+njfrvDfjaa8R7b5I2KBUxEUUID5ZYXH7VAAzNx
	8gx7q9nzohXX615tdwH0gtbaLPZ1rHq8EAU3W9psmKs8KzOP1O9fMfvGg1CY5p4M30lXyU4lAfi
	J7CIeprSQhXXHiCSeLgOrpWTTFJLW32UNCIkCgSrons4gWaxxPKn3D4xbIeQ==
X-Received: by 2002:a05:600c:1e85:b0:482:eec4:772 with SMTP id 5b1f17b1804b1-483a963de9amr85845895e9.32.1771778173648;
        Sun, 22 Feb 2026 08:36:13 -0800 (PST)
Received: from localhost (176.111.181.192.kyiv.nat.volia.net. [176.111.181.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00e8bsm10865692f8f.15.2026.02.22.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 08:36:13 -0800 (PST)
Date: Sun, 22 Feb 2026 18:36:11 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net 2/2] selftests: net: Add bridge VLAN range grouping
 tests
Message-ID: <aZsvj1Zo7msYRRCJ@penguin>
References: <20260222085338.3143823-1-danieller@nvidia.com>
 <20260222085338.3143823-3-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222085338.3143823-3-danieller@nvidia.com>

On Sun, Feb 22, 2026 at 10:53:38AM +0200, Danielle Ratson wrote:
> Add a new test file bridge_vlan_dump.sh with four test cases that verify
> VLANs with different per-VLAN options are not incorrectly grouped into
> ranges in the dump output.
> 
> The tests verify the kernel's br_vlan_opts_eq_range() function correctly
> prevents VLAN range grouping when neigh_suppress, mcast_max_groups,
> mcast_n_groups, or mcast_enabled options differ.
> 
> Each test verifies that VLANs with different option values appear as
> individual entries rather than ranges, and that VLANs with matching
> values are properly grouped together.
> 
> Example output:
> 
> $ ./bridge_vlan_dump.sh
> TEST: VLAN range grouping with neigh_suppress                       [ OK ]
> TEST: VLAN range grouping with mcast_max_groups                     [ OK ]
> TEST: VLAN range grouping with mcast_n_groups                       [ OK ]
> TEST: VLAN range grouping with mcast_enabled                        [ OK ]
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/bridge_vlan_dump.sh | 203 ++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org> 
