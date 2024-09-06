Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3701CCB31
	for <bridge@lists.linux.dev>; Fri,  6 Sep 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633836; cv=none; b=A+/uvNkuuJVPq2jEOcOSKtu+6k1JVA4+mQxZkKFEiwEhlnEdqujq/SAW+hMz5uOw/8R0496i8YWcKeNmHA7GDURhuw9oqtDSWqG1FpXm95fP2yzWzpwPmH0YM8Q2ZOLqlqxEq3jB9Ya6whqveKAyhq7/1bO8Ow/HMO3IoUJ4yEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633836; c=relaxed/simple;
	bh=NhdQH1a5W6hapzmK4P0XA2IAR44oZC3J7Z1ztW+orLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuBXgNw2tbQFp/9oGNmvBWiACLCajQXxecFx5TzSVT+Q70D9RN52SQk0NilcXenC+/LdBj55vr2X61r+Oil8AoN3qWjIlPmEKv9O66HhLrDgEQqEuiJPgEQDsV8gYMGBT2YBkMEK5nSXm8YBI3Oz6yz0U7HB/Wn+NRIZfWgtins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGcE0YjV; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGcE0YjV"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39f54ab8e69so10556265ab.1
        for <bridge@lists.linux.dev>; Fri, 06 Sep 2024 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633834; x=1726238634; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhdQH1a5W6hapzmK4P0XA2IAR44oZC3J7Z1ztW+orLg=;
        b=YGcE0YjVTUp1XprkCEjFro+/Zv8BPYmx8eUOBB2ncjGnCOAFrG0ctab4pjOGhX33TM
         MXdIXk2koqECKbNpWsX9H0GRQ2C8lKiB0ht2YSTnA+BrDv1ZN9LOzEHMVNDVpJLt8IZo
         0bj6hWmG74/coYK5nyXpzm6azuek8yE/cH60La1QVsd9HzT8qG2ljmYbS2Is9sB5x6FD
         GEBafqSiGn3kUkNhF656qnzMhHqBvGhGYL36LcfsL49zXQgOWJ3YMRarq+bhj2dtai8F
         hlgcezduDoYEVSX0wCvk9LWR1XedE28oBKJ8BAXke6AyyYkRjb8KryhgwZZf04GB2dpF
         fu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633834; x=1726238634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhdQH1a5W6hapzmK4P0XA2IAR44oZC3J7Z1ztW+orLg=;
        b=cW/R4IyLLeVZ8CuMrc0F7+tnTBl3UIjL21UAAgP2exx85+uQ6CcGkZasUeQsimjVlQ
         AShBGpmmN9rXn8Y7xH/JcEzODS1fyfxoxIauMBdmzOS/xIpmWEbfPLuuFeHbicxQhSXq
         UcVi8+4+eu5QoEruUxqVobEOZojj9Vu63bdFKcCCiTQmOVXkv4PEYJFne1eSFhaUN32F
         W9dKRLwB8e8jTaMxYlVhb3PL6VqFFt26Gh5+bE3tsbWCFAky3epa0Zg57K9yUvcYJYv3
         5NsnZJ1WfIsQe/ezGIilpJ0wrRcNChE/1nq3XkcpH6tgZRQ3pjxKUTxiAXMmaO1enC2l
         vQDA==
X-Forwarded-Encrypted: i=1; AJvYcCVBNP9YeF1K/ZfDd8P1XnMBHk1eUZ8JqEKIna9VhdxGnjyQZ5qq94HJpReKqEOgYvSuTtyinwE=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu9R//154r20wDJHI5y2g18Nwaj3h/fwz8TkXgav+4TWUjalxj
	H2H/Bo42dWKbcmhxYlYmhBawq3gKzLNalxb+qLDw1c6BE1iR184zLgRjZzVPTbUMWU80Eht91W7
	Ielr8O4ZExX2GYpky7AzsienuR1g=
X-Google-Smtp-Source: AGHT+IHlLthbmKYIA0lXdf8bkLngRRLYn9z6GK5ZajQE9FHf65MIofrSVVfFZVVYi7C6mTQ8GGJ2XTekFieonTp2n2M=
X-Received: by 2002:a05:6e02:1b03:b0:39f:60b3:ca2e with SMTP id
 e9e14a558f8ab-3a04eb5f1f7mr24501095ab.2.1725633834252; Fri, 06 Sep 2024
 07:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240905165140.3105140-1-idosch@nvidia.com> <20240905165140.3105140-13-idosch@nvidia.com>
In-Reply-To: <20240905165140.3105140-13-idosch@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 6 Sep 2024 10:43:42 -0400
Message-ID: <CADvbK_dn6vs05tbwd+uOL0raj_X6HFWAGqPqNxKNpaqSmw5yug@mail.gmail.com>
Subject: Re: [PATCH net-next 12/12] sctp: Unmask upper DSCP bits in sctp_v4_get_dst()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, gnault@redhat.com, 
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org, 
	marcelo.leitner@gmail.com, bridge@lists.linux.dev, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:54=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.
>
> Note that the 'tos' variable holds the full DS field.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
