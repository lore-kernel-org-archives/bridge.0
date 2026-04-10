Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6D3CFF5F
	for <bridge@lists.linux.dev>; Fri, 10 Apr 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844434; cv=pass; b=qO+stDiO95xIzE95+3NCYq3rzdTpF5LeQvfZr12hzBxArszMaID/GgG4DzGyrM2/t5qSZKW61+X/YOvGZcHZVmVNRKn72o8DQGB+85eomVsdWkFaw+0osdzjNoYdoOTiZo/jNL4rmE11ctlu3s8jgAH1rF+4rbAJcMs9V3lmv3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844434; c=relaxed/simple;
	bh=m0SqRtjpc8fweCPgbIsrD2d0z6GAWlzdIRiS41O4cxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFR6r7v3cc+0Qw5SRqrW+bAz8JC8eb/Lk7eHCobaeeiQ64XkuPkjRlhfnK6WvhwIj2+9m4G8Sbm/TBUrtkA1BB6+apIKgwjQiLEdHDEAQ5DxIz+cF25iVl2uEjVjf8NAhi7rVF+/Uud952pjlBTHEa0Xrx4uP+1+MzZGbNO5GGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLy5s0NF; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLy5s0NF"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so429383966b.2
        for <bridge@lists.linux.dev>; Fri, 10 Apr 2026 11:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775844431; cv=none;
        d=google.com; s=arc-20240605;
        b=N8aVCbJ4aPhiI4KkirTahtgv1Z1nAwQ4y5nIPe+7q2tOGS3WCV8WVPlW2roseeX7oS
         SO2uSEBzTc5kJiQPbGNVr2gfv2yHAk0SVFVxnkdUiIwmYdsoGFVtsf+ULRMzUljIyOZi
         0T2IW4ATJ2+/p66RTXXSu+SbdyydRqI1RpnIBHN/dU+UMyCK7jjGDLKEWommhOtmbTNu
         Ek+FbrdGywZWtAQLozLiPd7zrRCmsRr4JouKLWmc92xNYjaEOy5QU3fWFYhXB2WsnLrE
         s4mUr6vc30p6ngZyHkxam+9+70BIkhpxifEKbfGGlo55P/HYWpdFGeLi6HNwN8vL0fOb
         NNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGufM7na8wMpN8zx+blIkzaxv+HrthUqBNiPXsfFPcU=;
        fh=qhPdfJokIlafRzOKK4F4JNJYoRkfLzVQYVWFyZs9Gzs=;
        b=MFxOJpLTLUYHIg+/9P78GwrR1vk+fG10jVRTNixRvFISr+vUJn8Y/ILN7lD6CpgAN2
         BW6R++42RYLmLf83DVgjO9oWktb3XFioVRGKlHzcHAX0dh3o09bni0koWHZTO/6yxaMy
         Jip8rkItTtnbzkMBRP18sVjCEXPRE72fdPhmta66eGMgRHWyzPrZ7AJJ7F8d7Qeug2cR
         qipJbG5bngZrunDNC2tRDYHa3UR8FZh5BbaG6ocosFY7lRpDdCqWFMwaofkojb6CLFl5
         qJaeTg8c3mvsWppqMHrZM+ABnTrkHEHc6Dya52BZg/piDJ4i+2sONdKAMmOhLxhbmExw
         xEGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775844431; x=1776449231; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGufM7na8wMpN8zx+blIkzaxv+HrthUqBNiPXsfFPcU=;
        b=pLy5s0NFDzHgj5Fz2P3rctz7ZDNYyT8Z6oGCDr4zccjpYlCUC7k+SpRGYZjCYQxbOI
         0gwVGmDMV7fzp+9eXr7laWXeq6UMqwPRblH1/mITS3Agnt+7l3sCJYxsUNbgCnIz3pSo
         Xgzgv1mXkEQcScz0TEwv07kINEuZnpvDFVYan6eXPojHatiKDEuQlM9BZIkVOmM81KJY
         omM7dFN9VmNaiTBkN4llCtKIY4LvixKaCZOl/qcZCiNrsfBZJiIS6lngxR7IANPSLNb2
         5hTej1qBZ+QMcpkHl41cEIeEeNZzS4C5SC9W/7DWOIIUh+4BZNX0plA5RuZYAu88IhDe
         mmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844431; x=1776449231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGufM7na8wMpN8zx+blIkzaxv+HrthUqBNiPXsfFPcU=;
        b=ZEc+UIB0Ze7fxOTnjfFHOjpriIJFUf/48kxAdgj0CVQywb2vvI7B4I029WdQQBGvqY
         j3ZMlRI+g8HOu4gBoA+SQ8bdVJGNddqWXWkJEGyy5diZmK0j2wss6qhMh5d/C6WlzIQM
         q+uTc20hmky7CQPscJ2brNoAc5XQHzgM8xNtSDqsJM69wHQJdTFAdL1oP0UA1lUwLiWH
         su3j5AAWKpHEOIHn5BNs22N8o658sg1/+uFN2ZiRVgAXft+HLV1G6sOZOHonwkNHqpt1
         bdwFmH8G+DwQFfijfQaG5fYVRoVwhtr2HUozXkFUt7q0I54dFdQ/dudrwsQxp5NkBmS+
         pY5w==
X-Forwarded-Encrypted: i=1; AJvYcCXW7pBbPaGtZw6cOslyM3Z9kHV4uAUjO8Q3Wd12EQ8o5x6ZZRPTItW9ZoYyVSSylFn7924QOXo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXDk3H137npvF+0DGF4ZQyvWMu7XZ2bmJUe4061JaAL0l7iJTi
	ZSOJlD6DIekRuEfMtMamOpVdcjW5YFF373h3eZnHmwV/BcjvVSflKLXXJXdMXrvSYiHY6WcKEkc
	5inxZta0HubG5ZxvmJjAOsXArnFf98+o=
X-Gm-Gg: AeBDieu1v4k3Djg3ATMCJ7Qo3CpbGEvE1cAwkPpN7Pc7S5/9Kg8wApzdDb9sBQx9IW8
	qS0aRCRUgg+fQ9epWolKI0CDBVO4ynXa5ZfHSXdxNccLGo6udlmnE6j/8DHj5HON0Mkoxg0KNSJ
	+TYCfc2WdJXrPxRFBpnT2FsIHa9dU2tA59EvWRaaoZ37lZjDtnwj9tJR8dmbdJhed/OdRDIeuZl
	jMv6d/oMUIImrEvAIyl5V88t7GE/9Lf2F8m6OPsllND1/LmYNM1Py5lEAwhY5nbGZGYEeG951xY
	/h7hAEQ=
X-Received: by 2002:a17:907:a1a0:b0:b9c:55e8:fba1 with SMTP id
 a640c23a62f3a-b9d72980914mr205690366b.26.1775844431242; Fri, 10 Apr 2026
 11:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260403150050.1235-1-royujjal@gmail.com> <20260403150050.1235-5-royujjal@gmail.com>
 <20260407134502.GD849209@shredder>
In-Reply-To: <20260407134502.GD849209@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 10 Apr 2026 23:36:59 +0530
X-Gm-Features: AQROBzA5y--UIRYT_Yu32kHeVQkZCbum9kUmK0fpAAGLhqzgcbax6qOFdWZqhBQ
Message-ID: <CAE2MWknjWczxM3WrKkQ0eHV7PdNxMQ62GnTAp6tCPToumZnE=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] ipv6: mld: encode multicast exponential fields
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 7:15=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Fri, Apr 03, 2026 at 03:00:49PM +0000, Ujjal Roy wrote:
> > In MLD, QQIC and MRC fields are not correctly encoded when
> > generating query packets. Since the receiver of the query
> > interprets these fields using the MLDv2 floating-point
> > decoding logic, any value that exceeds the linear threshold
> > is incorrectly parsed as an exponential value, leading to
> > an incorrect interval calculation.
> >
> > Encode and assign the corresponding protocol fields during
> > query generation. Introduce the logic to dynamically
> > calculate the exponent and mantissa using bit-scan (fls).
> > This ensures QQIC (8-bit) and MRC (16-bit) fields are
> > properly encoded when transmitting query packets with
> > intervals that exceed their respective linear thresholds
> > (128 for QQI; 32768 for MRD).
> >
> > RFC3810: If QQIC >=3D 128, the QQIC field represents a
> > floating-point value as follows:
> >      0 1 2 3 4 5 6 7
> >     +-+-+-+-+-+-+-+-+
> >     |1| exp | mant  |
> >     +-+-+-+-+-+-+-+-+
> >
> > RFC3810: If Maximum Response Code >=3D 32768, the Maximum
> > Response Code field represents a floating-point value as
> > follows:
> >      0 1 2 3 4 5 6 7 8 9 A B C D E F
> >     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >     |1| exp |          mant         |
> >     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >
> > Signed-off-by: Ujjal Roy <royujjal@gmail.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Do you mean to include "Reviewed-by:" tag into this commit message or
the entire patchset? I will modify and send v4 once I get the reply.
